import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_and_mess/helper.dart';
// import 'package:hostel_and_mess/updateMessMenu.dart';

import 'UpdateMessSchedule.dart';

class FetchMessSchedule extends StatefulWidget {
  @override
  _FetchMessScheduleState createState() => _FetchMessScheduleState();
}

class _FetchMessScheduleState extends State<FetchMessSchedule> {
  Helper _helper = Helper();
  bool _isLoading = false;
  String _breakfastTime, _lunchTime, _dinnerTime;
  Future<void> _updateName() async {
    setState(() {
      _isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('Today_Mess_Schedule')
        .doc('Todays_Schedule')
        .update({
      'Breakfast': _breakfastTime,
      'Lunch': _lunchTime,
      'Dinner': _dinnerTime,
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

  Future<void> _showDialogBox() {
    var value1, value2, value3;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    enabledBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black)),
                    labelText: "New Breakfast Time",
                    hintText: "Enter breakfast time",
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
                      return "breakfast time should not be empty";
                    }
                  },
                ),
                TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    enabledBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black)),
                    labelText: "New Lunch Timeime",
                    hintText: "Enter lunch time",
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
                      return "Lunch time should not be empty";
                    }
                  },
                ),
                TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    enabledBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black)),
                    labelText: "New Dinner Time",
                    hintText: "Enter dinner time",
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
                      value3 = val;
                    });
                  },
                  onSubmitted: (value) {
                    if (value == null) {
                      return "Dinner time should not be empty";
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
                    _breakfastTime = value1;
                    _lunchTime = value2;
                    _dinnerTime = value3;
                    // _isLoading=true;
                  });
                  _updateName();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Widget _row(item) {
    return Row(
      children: [
        SizedBox(width: MediaQuery.of(context).size.width / 4),
        Icon(
          Icons.remove,
          color: Colors.white,
        ),
        SizedBox(
          width: 5.0,
        ),
        Text(
          item,
          style: TextStyle(color: Colors.white, fontSize: 15.0),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mess Schedule"),
        actions: [
          IconButton(
              icon: Icon(Icons.edit), onPressed: () => {_showDialogBox()}),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('Today_Mess_Schedule')
                    .doc('Todays_Schedule')
                    .delete();
              })
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Today_Mess_Schedule")
            .snapshots(),
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
                "There are not any schedule to show",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
          return Card(
              elevation: 5.0,
              color: Colors.black,
              margin: EdgeInsets.all(4.0),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.blue, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot food = snapshot.data.docs[index];
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 32.0),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.free_breakfast_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10.0),
                                Text('Breakfast Time:',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 5.0),
                            _row(food['Breakfast']),
                            SizedBox(height: 20.0),
                            Row(
                              children: [
                                Icon(
                                  Icons.lunch_dining,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10.0),
                                Text('Lunch Time:',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 5.0),
                            _row(food['Lunch']),
                            SizedBox(height: 20.0),
                            Row(
                              children: [
                                Icon(
                                  Icons.dinner_dining,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10.0),
                                Text('Dinner Time:',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 5.0),
                            _row(food['Dinner']),
                          ],
                        )),
                      ),
                    );
                  }));
        },
      ),
    );
  }
}
