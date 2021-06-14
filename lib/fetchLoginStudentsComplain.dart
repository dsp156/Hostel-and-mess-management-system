import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_and_mess/helper.dart';

class FetchComplain extends StatefulWidget {
  final String uid;
  FetchComplain({
    this.uid,
  });

  @override
  _FetchComplainState createState() => _FetchComplainState(uid);
}

class _FetchComplainState extends State<FetchComplain> {
  final String uid;
  _FetchComplainState(this.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Complain")),
      backgroundColor: Colors.black,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Complains').snapshots(),
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
                          side: BorderSide(color: Colors.white, width: 3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: student['uid'] == uid
                            ? Column(
                                children: [
                                  SizedBox(height: 10.0),
                                  student['Is done'] == true
                                      ? Text(
                                          "Your complain is executed succesfully",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          "Your complain is not succesfully yet",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                  SizedBox(height: 15.0),
                                  Text(
                                    'Complain-Type : ' +
                                        student['Complain-Type'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    'Complain : ' + student['Complain'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10.0),
                                ],
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

                    // ? ListTile(
                    //     title: Text('Enrollment No:' +
                    //         student['Enrollment No']),
                    //     subtitle: Text('Block:' +
                    //         student['Block'] +
                    //         " " +
                    //         'Name:' +
                    //         student['name']),
                    //
                  }));
        },
      ),
    );
  }
}
