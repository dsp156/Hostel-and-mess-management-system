import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FetchAllComplains extends StatefulWidget {
  @override
  _FetchAllComplainsState createState() => _FetchAllComplainsState();
}

class _FetchAllComplainsState extends State<FetchAllComplains> {
  @override
  Widget build(BuildContext context) {
    CollectionReference students =
        FirebaseFirestore.instance.collection('Complains');
    return Scaffold(
      appBar: AppBar(title: Text("All Complains")),
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
                child: Card(
                  color: Colors.black,
                  elevation: 5.0,
                  margin: EdgeInsets.all(4.0),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Complain-Type : ' + document.data()['Complain-Type'],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Complain : ' + document.data()['Complain'],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        document.data()['Is done'] == false
                            ? FlatButton(
                                color: Colors.blue,
                                splashColor: Colors.white,
                                highlightColor: Colors.white,
                                padding:
                                    EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
                                shape: RoundedRectangleBorder(
                                  // side: BorderSide(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "Done",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0,
                                      fontStyle: FontStyle.normal),
                                ),
                                onPressed: () async {
                                  FirebaseFirestore.instance
                                      .collection('Complains')
                                      .doc(document.data()['uid'])
                                      .update({'Is done': true});
                                },
                              )
                            : Text(
                                'you reviewed this complain',
                                style: TextStyle(color: Colors.green),
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
