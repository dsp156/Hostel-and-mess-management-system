import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateMessMenu extends StatefulWidget {
  @override
  _UpdateMessMenuState createState() => _UpdateMessMenuState();
}

class _UpdateMessMenuState extends State<UpdateMessMenu> {
  String _breakfast;
  String _lunch;
  String _dinner;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Mess Menu"),
        actions: [IconButton(icon: Icon(Icons.delete), onPressed: () => {})],
      ),
      body: StreamBuilder<QuerySnapshot>(
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
                    DocumentSnapshot food = snapshot.data.docs[index];
                    return Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Enter Breakfast",
                            prefixIcon: Icon(
                              Icons.account_circle,
                              size: 30,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          validator: (value) {
                            if (value.toString().length == 0) {
                              return "Breakfast can not be empty!";
                            }
                          },
                          onChanged: (value) => {
                            setState(() {
                              _breakfast = value;
                            })
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Enter Lunch",
                            prefixIcon: Icon(
                              Icons.account_circle,
                              size: 30,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          validator: (value) {
                            if (value.toString().length == 0) {
                              return "Lunch can not be empty!";
                            }
                          },
                          onChanged: (value) => {
                            setState(() {
                              _lunch = value;
                            })
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Enter Dinner",
                            prefixIcon: Icon(
                              Icons.account_circle,
                              size: 30,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          validator: (value) {
                            if (value.toString().length == 0) {
                              return "Dinner can not be empty!";
                            }
                          },
                          onChanged: (value) => {
                            setState(() {
                              _dinner = value;
                            })
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        FlatButton(
                            color: Colors.blue,
                            splashColor: Colors.white,
                            highlightColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.blue, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 40.0,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Update Menu",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Icon(
                                  Icons.person_add_outlined,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection("Today_Mess_Menu")
                                  .doc("Todays_Menu")
                                  .update({
                                "Breakfast": _breakfast,
                                "Lunch": _lunch,
                                "Dinner": _dinner
                              }).then((value) => {print("Data Updated")});
                            }),
                      ],
                    );
                  }));
        },
      ),
    );
  }
}
