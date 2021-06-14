import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_and_mess/helper.dart';
// import 'package:hostel_and_mess/updateMessMenu.dart';

import 'UpdateMessSchedule.dart';

class FetchMessScheduleForStudent extends StatefulWidget {
  @override
  _FetchMessScheduleForStudentState createState() =>
      _FetchMessScheduleForStudentState();
}

class _FetchMessScheduleForStudentState
    extends State<FetchMessScheduleForStudent> {
  Helper _helper = Helper();
  bool _isLoading = false;
  String _breakfastTime, _lunchTime, _dinnerTime;

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
