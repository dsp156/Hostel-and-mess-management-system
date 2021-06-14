import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_and_mess/helper.dart';

class EditStudent extends StatefulWidget {
  String uid;
  EditStudent({
    this.uid,
  });
  @override
  _EditStudentState createState() => _EditStudentState(uid);
}

class _EditStudentState extends State<EditStudent> {
  String uid;
  _EditStudentState(this.uid);
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

  Future<void> _updateEnrollment(
      enrollment, name, mobileNo, email, block, roomNo) async {
    setState(() {
      _isLoading = true;
    });
    await FirebaseFirestore.instance.collection('En No').doc(uid).update({
      'Enrollment No': _enrollmentNo,
    }).then((_) async {
      await FirebaseFirestore.instance
          .collection('students')
          .doc(block)
          .collection(roomNo)
          .doc(uid)
          .update({'Enrollment No': _enrollmentNo});
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

  Future<void> _showDialogEnrollment(
      enrollment, name, mobileNo, email, block, roomNo) {
    var value;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                TextField(
                  controller: TextEditingController(text: enrollment),
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    enabledBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black)),
                    labelText: "New Enrollment No",
                    hintText: "Enter new Enrollment No",
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
                      return "Enrollment No should not be empty";
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
                    _enrollmentNo = value;
                    // _isLoading=true;
                  });
                  _updateEnrollment(
                      enrollment, name, mobileNo, email, block, roomNo);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> _updateBlock(name, mobileNo, email, block, roomNo) async {
    setState(() {
      _isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('En No')
        .doc(uid)
        .update({'Block': _block, 'Room No': _roomNo}).then((_) async {
      await FirebaseFirestore.instance
          .collection('students')
          .doc(block)
          .collection(roomNo)
          .doc(uid)
          .delete()
          .then((_) async {
        await FirebaseFirestore.instance
            .collection('students')
            .doc(_block)
            .collection(_roomNo)
            .doc(uid)
            .set({
          'name': name,
          'email': email,
          'Enrollment No': enrollmentNo,
          'Block': _block,
          'Room No': _roomNo,
          'Mobile No': mobileNo,
          'uid': uid,
        });
      });
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

  Future<void> _showDialogBlock(name, mobileNo, email, block, roomNo) {
    var value1, value2;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                TextField(
                  controller: TextEditingController(text: block),
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    enabledBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black)),
                    labelText: "New Block",
                    hintText: "Enter new Block",
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
                      value1 = val;
                    });
                  },
                  onSubmitted: (value) {
                    if (value == null) {
                      return "Enrollment No should not be empty";
                    }
                  },
                ),
                TextField(
                  controller: TextEditingController(text: roomNo),
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    enabledBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black)),
                    labelText: "New Room No",
                    hintText: "Enter new Room No",
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
                      value2 = val;
                    });
                  },
                  onSubmitted: (value) {
                    if (value == null) {
                      return "Room Number No should not be empty";
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
                    _block = value1;
                    _roomNo = value2;
                    // _isLoading=true;
                  });
                  _updateBlock(name, mobileNo, email, block, roomNo);
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
      appBar: AppBar(title: Text("Edit Students")),
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
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 10.0,
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
                                                fontSize: 17.0,
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
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        IconButton(
                                            icon: Icon(Icons.edit,
                                                color: Colors.white),
                                            onPressed: () {})
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text('Block:-  ' + student['Block'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text('Room No:-  ' + student['Room No'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                enrollmentNo =
                                                    student['Enrollment No'];
                                              });
                                              _showDialogBlock(
                                                  student['name'],
                                                  student['Mobile No'],
                                                  student['email'],
                                                  student['Block'],
                                                  student['Room No']);
                                            })
                                      ],
                                    ),
                                    SizedBox(height: 5.0),
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
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        IconButton(
                                            icon: Icon(Icons.edit,
                                                color: Colors.white),
                                            onPressed: () {
                                              _showDialogEnrollment(
                                                  student['Enrollment No'],
                                                  student['name'],
                                                  student['Mobile No'],
                                                  student['email'],
                                                  student['Block'],
                                                  student['Room No']);
                                            })
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
