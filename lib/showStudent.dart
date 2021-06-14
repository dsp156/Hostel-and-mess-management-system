import 'package:hostel_and_mess/showRoom.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// import 'showRooms1.dart';
// import 'showStudent.dart';

class ShowStudents extends StatefulWidget {
  @override
  _ShowStudentsState createState() => _ShowStudentsState();
}

class _ShowStudentsState extends State<ShowStudents> {
  final _roomNoController = TextEditingController();
  final _blockController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _value = 'A';
  var _roomNo;
  @override
  void dispose() {
    // TODO: implement dispose
    _blockController.dispose();
    _roomNoController.dispose();
    super.dispose();
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
                    controller: _blockController,
                    decoration: InputDecoration(
                        labelText: "Enter Block A or B",
                        labelStyle: TextStyle(backgroundColor: Colors.white),
                        filled: true,
                        hintText: "Enter Block",
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
                        return "Block number can't be null";
                      }
                    },
                  ),
                  TextFormField(
                    controller: _roomNoController,
                    decoration: InputDecoration(
                        labelText: "Enter Room No",
                        labelStyle: TextStyle(backgroundColor: Colors.white),
                        filled: true,
                        hintText: "Enter Room No",
                        prefixIcon: Icon(
                          Icons.person,
                          size: 30.0,
                        ),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(8.0)))),
                    validator: (value) {
                      if (value.toString().length == 0) {
                        return "Room No can't be null";
                      }
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
                        final String block = _blockController.text.toString();
                        final String room = _roomNoController.text.toString();
                        setState(() {
                          _blockController.text = '';
                          _roomNoController.text = '';
                        });
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ShowRooms(block, room)));
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Find Students",
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
          title: Text("Show Rooms"),
        ),
        backgroundColor: Colors.black,
        body: Center(
            child: SingleChildScrollView(
          child: _body(),
        )));
  }
}
