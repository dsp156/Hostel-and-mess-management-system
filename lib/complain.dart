import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_and_mess/helper.dart';

class Complain extends StatefulWidget {
  final String uid;
  Complain({this.uid});
  @override
  _ComplainState createState() => _ComplainState(uid);
}

class _ComplainState extends State<Complain> {
  final String uid;
  _ComplainState(this.uid);
  final _formKey = GlobalKey<FormState>();
  String _complainType, _complain;
  Helper _helper = Helper();

  Future<void> _register() async {
    FirebaseFirestore.instance.collection('Complains').doc(uid).set({
      'uid': uid,
      'Complain-Type': _complainType,
      'Complain': _complain,
      'Is done': false,
    }).then((_) async {
      print("Complain is successfully added");
    });
  }

  Widget _body() {
    return Card(
      elevation: 5.0,
      color: Colors.black,
      margin: EdgeInsets.all(4.0),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.blue, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 32.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.insert_comment,
                    color: Colors.white,
                    size: 100,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter Complain Type",
                      prefixIcon: Icon(
                        Icons.add_circle,
                        size: 30,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value.toString().length == 0) {
                        return "Complain type can not be empty!";
                      }
                    },
                    onChanged: (value) => {
                      setState(() {
                        _complainType = value;
                      })
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter Complain",
                      prefixIcon: Icon(
                        Icons.add_circle,
                        size: 30,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value.toString().length == 0) {
                        return "Complain can not be empty!";
                      }
                    },
                    onChanged: (value) => {
                      setState(() {
                        _complain = value;
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
                            "Add Complain",
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
                        _register().then((_) {
                          Navigator.of(context).pop();
                        });
                      }),
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
          title: Text("Complain Box"),
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: SingleChildScrollView(
            child: _body(),
          ),
        ));
  }
}
