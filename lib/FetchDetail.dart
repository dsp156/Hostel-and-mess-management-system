import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FetchDetail extends StatefulWidget {
  @override
  _FetchDetailState createState() => _FetchDetailState();
}

class _FetchDetailState extends State<FetchDetail> {
  @override
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
        title: Text("Hostel And Mess Info"),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Hostel Mess Info")
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
                      DocumentSnapshot data = snapshot.data.docs[index];
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
                                  Text("Chef Name : " + data['Chef Name'],
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
                                  Text(
                                      "MessManagerName : " +
                                          data['MessManagerName'],
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
                                  Text(
                                      "MessManagerPhone : " +
                                          data['MessManagerPhone'],
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
                                  Text(
                                      "FoodCordinateName : " +
                                          data['FoodCordinateName'],
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
                                  Text(
                                      "FoodCordinatePhone : " +
                                          data['FoodCordinatePhone'],
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
                                  Text("TypesOfRoom : " + data['TypesOfRoom'],
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
                                  Text("Fees : " + data['Fees'],
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
                                  Text("RectorName : " + data['RectorName'],
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
                                  Text("RectorPhone : " + data['RectorPhone'],
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
                                  Text("PeonName1 : " + data['PeonName1'],
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
                                  Text("PeonPhone1 : " + data['PeonPhone1'],
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
                                  Text("PeonName2 : " + data['PeonName2'],
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
                                  Text("PeonPhone2: " + data['PeonPhone2'],
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
                                  Text("PeonName3 : " + data['PeonName3'],
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
                                  Text("PeonPhone3 : " + data['PeonPhone3'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
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
