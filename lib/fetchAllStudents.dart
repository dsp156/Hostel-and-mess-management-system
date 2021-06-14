import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_and_mess/EditStudent.dart';

class FetchAllStudents extends StatefulWidget {
  @override
  _FetchAllStudentsState createState() => _FetchAllStudentsState();
}

class _FetchAllStudentsState extends State<FetchAllStudents> {
  @override
  Widget build(BuildContext context) {
    CollectionReference students =
        FirebaseFirestore.instance.collection('En No');
    return Scaffold(
      appBar: AppBar(title: Text("All Students")),
      backgroundColor: Colors.black,
      body: StreamBuilder<QuerySnapshot>(
        stream: students.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return SingleChildScrollView(
            child: Column(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          EditStudent(uid: document.data()['uid'])));
                },
                child: Card(
                  color: Colors.black,
                  elevation: 5.0,
                  margin: EdgeInsets.all(4.0),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.blue, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'Name:-  ' + document.data()['name'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
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
                            Text('Email:-  ' + document.data()['email'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                )),
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
                              'Mobile No:-  ' + document.data()['Mobile No'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
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
                            Text('Block:-  ' + document.data()['Block'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                )),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text('Room No:-  ' + document.data()['Room No'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                )),
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
                              'Enrollment No:- ' +
                                  document.data()['Enrollment No'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList()),
          );
        },
      ),
    );
  }
}
