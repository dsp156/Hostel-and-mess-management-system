import 'package:cloud_firestore/cloud_firestore.dart';
import 'helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessScheduleAdd extends StatefulWidget {
  @override
  _MessScheduleAddState createState() => _MessScheduleAddState();
}

class _MessScheduleAddState extends State<MessScheduleAdd> {
  bool valuefirst = false;
  Helper _helper = Helper();
  final _formKey = GlobalKey<FormState>();
  String _breakFast, _lunch, _dinner;

  Future<bool> _addData() async {
    Map<String, dynamic> data = {
      'Breakfast': _breakFast,
      'Lunch': _lunch,
      'Dinner': _dinner,
    };
    await FirebaseFirestore.instance
        .collection('Today_Mess_Schedule')
        .doc("Todays_Schedule")
        .set(data)
        .then((value) async {
      print("Data added");
    }).catchError((e) {
      print(e);
      _helper.show("Opps!! Some error occured. Try again");
      _helper.flushbar..show(context);
      return false;
    });
    return true;
  }

  Widget _body() {
    return Card(
      elevation: 5.0,
      color: Colors.black,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.blue, width: 1.0),
          borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 32.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Breakfast Time",
                        labelStyle: TextStyle(backgroundColor: Colors.white),
                        filled: true,
                        hintText: "Enter breakfast time",
                        prefixIcon: Icon(
                          Icons.add,
                          size: 30.0,
                        ),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(8.0)))),
                    validator: (value) {
                      if (value.toString().length == 0) {
                        return "Breakfast time not be zero";
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _breakFast = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Lunch Time",
                        labelStyle: TextStyle(backgroundColor: Colors.white),
                        filled: true,
                        hintText: "Enter Lunch Time",
                        prefixIcon: Icon(
                          Icons.add,
                          size: 30.0,
                        ),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(8.0)))),
                    validator: (value) {
                      if (value.toString().length == 0) {
                        return "Lunch time not be zero";
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _lunch = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Dinner time",
                        labelStyle: TextStyle(backgroundColor: Colors.white),
                        filled: true,
                        hintText: "Enter Dinner Time",
                        prefixIcon: Icon(
                          Icons.add,
                          size: 30.0,
                        ),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(8.0)))),
                    validator: (value) {
                      if (value.toString().length == 0) {
                        return "Dinner time not be zero";
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _dinner = value;
                      });
                    },
                  ),
                  FlatButton(
                      color: Colors.blue,
                      splashColor: Colors.white,
                      highlightColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0)),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          FocusScope.of(context).unfocus();
                          _addData().then((_) {
                            Navigator.of(context).pop("Your Menu  is uploaded");
                          });
                        }
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Upload Schedule",
                            style: TextStyle(
                              color: Colors.white,
                              // backgroundColor: Colors.blueGrey
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Icon(
                            Icons.upload_sharp,
                            color: Colors.white,
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Mess Schedule"),
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: SingleChildScrollView(
            child: _body(),
          ),
        ));
  }
}
