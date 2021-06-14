import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_and_mess/helper.dart';

class Profile extends StatefulWidget {
  String uid;
  Profile({
    this.uid,
  });
  @override
  _ProfileState createState() => _ProfileState(uid);
}

class _ProfileState extends State<Profile> {
  String uid;
  _ProfileState(this.uid);
  var _name = '', _moNo, _enrollmentNo, _block, _roomNo, enrollmentNo;
  bool _isLoading = false;
  Helper _helper = Helper();
  Future<void> _updateName(block, roomNo) async {
    setState(() {
      _isLoading = true;
    });
    await FirebaseFirestore.instance.collection('En No').doc(uid).update({
      'name': _name,
    }).then((_) async {
      await FirebaseFirestore.instance
          .collection('students')
          .doc(block)
          .collection(roomNo)
          .doc(uid)
          .update({'name': _name});
    }).catchError((e) {
      setState(() {
        _isLoading = false;
      });
      print("error : " + e.toString());
      _helper.show("Opps!! something went wrong");
      _helper.flushbar.show(context);
    });
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _showDialogName(name, block, roomNo) {
    var value;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                TextField(
                  style: TextStyle(color: Colors.black),
                  controller: TextEditingController(text: name),
                  decoration: InputDecoration(
                    enabledBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black)),
                    labelText: "New Name",
                    hintText: "Enter new name",
                    labelStyle: TextStyle(color: Colors.black),
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                    ),
                    counterStyle: TextStyle(color: Colors.black),
                  ),
                  cursorColor: Colors.black,
                  onChanged: (val) {
                    setState(() {
                      value = val;
                    });
                  },
                  onSubmitted: (value) {
                    if (value == null) {
                      return "Name should not be empty";
                    }
                  },
                )
              ],
            ),
            backgroundColor: Colors.white,
            elevation: 1.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            actions: <Widget>[
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: new Text(
                    "Cancel",
                    style: new TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: new Text(
                    "Update",
                    style: new TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _name = value;
                    // _isLoading=true;
                  });
                  _updateName(block, roomNo);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      backgroundColor: Colors.black,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('En No').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text('Something went wrong',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    )));
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text("Loading...",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  )),
            );
          }
          if (snapshot.data.docs.length == 0) {
            return Center(
              child: Text(
                "There are not any blogs to show",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
          return Container(
              child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot student = snapshot.data.docs[index];
                    return Card(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5.0,
                        margin: EdgeInsets.all(4.0),
                        child: student['uid'] == uid
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    SizedBox(height: 10.0),
                                    Icon(
                                      Icons.account_circle,
                                      color: Colors.white,
                                      size: 100,
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          'Name:-  ' + student['name'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              _showDialogName(
                                                  student['name'],
                                                  student['Block'],
                                                  student['Room No']);
                                            })
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text('Email:-  ' + student['email'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          'Mobile No:-  ' +
                                              student['Mobile No'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text('Block:-  ' + student['Block'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text('Room No:-  ' + student['Room No'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15.0),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          'Enrollment No:- ' +
                                              student['Enrollment No'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                  ],
                                ),
                              )
                            // ? ListTile(
                            //     title: Text('Enrollment No:' +
                            //         student['Enrollment No']),
                            //     subtitle: Text('Block:' +
                            //         student['Block'] +
                            //         " " +
                            //         'Name:' +
                            //         student['name']),
                            //   )
                            : SizedBox(
                                height: 0.0,
                              ));
                  }));
        },
      ),
    );
  }
}
