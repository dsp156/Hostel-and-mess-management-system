import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_and_mess/helper.dart';
import 'package:hostel_and_mess/updateMessMenu.dart';

class FetchMessMenuForStudent extends StatefulWidget {
  @override
  _FetchMessMenuForStudentState createState() =>
      _FetchMessMenuForStudentState();
}

class _FetchMessMenuForStudentState extends State<FetchMessMenuForStudent> {
  Helper _helper = Helper();
  bool _isLoading = false;
  String _breakfast, _lunch, _dinner;
  Future<void> _updateName() async {
    setState(() {
      _isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('Today_Mess_Menu')
        .doc('Todays_Menu')
        .update({
      'Breakfast': _breakfast,
      'Lunch': _lunch,
      'Dinner': _dinner,
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
                    labelText: "New Breakfast",
                    hintText: "Enter breakfast menu",
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
                      return "breakfast should not be empty";
                    }
                  },
                ),
                TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    enabledBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black)),
                    labelText: "New Lunch",
                    hintText: "Enter lunch menu",
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
                      return "Lunch should not be empty";
                    }
                  },
                ),
                TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    enabledBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black)),
                    labelText: "New Dinner",
                    hintText: "Enter dinner menu",
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
                      return "Dinner should not be empty";
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
                    _breakfast = value1;
                    _lunch = value2;
                    _dinner = value3;
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
        title: Text("Mess Menu"),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Today_Mess_Menu")
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
                  "There are not any menu to show",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }
            return Card(
                color: Colors.black,
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
                                  Text('Breakfast:',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(height: 5.0),
                              _row(food['Breakfast Liquid']),
                              SizedBox(height: 5.0),
                              _row(food['Breakfast Solid']),
                              SizedBox(height: 20.0),
                              Row(
                                children: [
                                  Icon(
                                    Icons.lunch_dining,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10.0),
                                  Text('Lunch:',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(height: 5.0),
                              _row(food['Lunch Liquid']),
                              SizedBox(height: 5.0),
                              _row(food['Lunch Veg1']),
                              SizedBox(height: 5.0),
                              _row(food['Lunch Veg2']),
                              SizedBox(height: 5.0),
                              _row(food['Lunch Roti']),
                              SizedBox(height: 5.0),
                              _row(food['Lunch Rice']),
                              SizedBox(height: 20.0),
                              Row(
                                children: [
                                  Icon(
                                    Icons.dinner_dining,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10.0),
                                  Text('Dinner:',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(height: 5.0),
                              _row(food['Dinner Liquid']),
                              SizedBox(height: 5.0),
                              _row(food['Dinner Veg']),
                              SizedBox(height: 5.0),
                              _row(food['Dinner Roti']),
                              SizedBox(height: 5.0),
                              _row(food['Dinner Rice']),
                            ],
                          )),
                        ),
                      );
                    }));
          },
        ),
      ),
    );
  }
}
