import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'helper.dart';

class AddStudent extends StatefulWidget {
  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent>
    with SingleTickerProviderStateMixin {
  Helper _helper = Helper();
  String _enNo;
  String _pass;
  String _email;
  String _name;
  String _block;
  String _roomNo;
  String _moNo;
  bool _eyeClosed = true, _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _register() async {
    setState(() {
      _isLoading = true;
    });
    print(_isLoading);

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: _email, password: _pass)
        .then((_user) async {
      await _user.user.sendEmailVerification().then((_) async {
        await FirebaseFirestore.instance
            .collection('En No')
            .doc(_user.user.uid)
            .set({
          'name': _name,
          'email': _email,
          'Enrollment No': _enNo,
          'Block': _block,
          'Room No': _roomNo,
          'Mobile No': _moNo,
          'uid': _user.user.uid
        }).then((_) async {
          // SharedPreferences preferences = await SharedPreferences.getInstance();
          // preferences.setString('En_No', _enNo);
          print("Successfully added to Enrollment database");
        });
        await FirebaseFirestore.instance
            .collection('students')
            .doc(_block)
            .collection(_roomNo)
            .doc(_user.user.uid)
            .set({
          'name': _name,
          'email': _email,
          'Enrollment No': _enNo,
          'Block': _block,
          'Room No': _roomNo,
          'Mobile No': _moNo,
          'uid': _user.user.uid
        }).then((_) {
          print("Successfully added to database");
          setState(() {
            _isLoading = false;
          });
        }).catchError((e) {
          print(e);
          _helper.show("something went wrong!!");
          _helper.flushbar.show(context);
        });
      }).catchError((e) {
        print("An error occured while trying to send email verification");
        print(e.message);
        _helper
            .show("An error occured while trying to send email verification");
        _helper.flushbar.show(context);
      });
    }).catchError((signUpError) {
      print(signUpError.code.toString());
      if (signUpError.code.toString() == "email-already-in-use") {
        print(signUpError.code.toString());
        _helper.show("The account already exists for that email.");
        _helper.flushbar.show(context);
      } else if (signUpError.code.toString() == "weak-password") {
        _helper.show("The password provided is too weak.!!");
        _helper.flushbar.show(context);
      } else if (signUpError.code.toString() == "invalid-email") {
        _helper.show("The email provided is invalid!!");
        _helper.flushbar.show(context);
      } else {
        _helper.show("something went wrong!!");
        _helper.flushbar.show(context);
      }
    });
    print(_isLoading);
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
                    Icons.account_circle,
                    color: Colors.white,
                    size: 100,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter Name",
                      prefixIcon: Icon(
                        Icons.account_circle,
                        size: 30,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value.toString().length == 0) {
                        return "Name can not be empty!";
                      }
                    },
                    onChanged: (value) => {
                      setState(() {
                        _name = value;
                      })
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter Email",
                      prefixIcon: Icon(
                        Icons.email,
                        size: 30,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (value) {
                      if (EmailValidator.validate(value) == false) {
                        return "Enter correct email";
                      }
                    },
                    onChanged: (value) => {
                      setState(() {
                        _email = value;
                      })
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter Block",
                      prefixIcon: Icon(
                        Icons.apartment,
                        size: 30,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value.toString().length == 0) {
                        return "Name can not be empty!";
                      }
                    },
                    onChanged: (value) => {
                      setState(() {
                        _block = value;
                      })
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter Room number",
                      prefixIcon: Icon(
                        Icons.room,
                        size: 30,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value.toString().length == 0) {
                        return "Name can not be empty!";
                      }
                    },
                    onChanged: (value) => {
                      setState(() {
                        _roomNo = value;
                      })
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter Number",
                      prefixIcon: Icon(
                        Icons.phone,
                        size: 30,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value.toString().length == 0) {
                        return "Name can not be empty!";
                      }
                    },
                    onChanged: (value) => {
                      setState(() {
                        _moNo = value;
                      })
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    // controller: _enController,
                    decoration: InputDecoration(
                      hintText: "Enter Enrollment Number",
                      prefixIcon: Icon(
                        Icons.engineering_outlined,
                        size: 30,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value.toString().length == 0) {
                        return "Name can not be empty!";
                      }
                    },
                    onChanged: (value) => {
                      setState(() {
                        _enNo = value;
                        _pass = value;
                      })
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    // controller: _enController,
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      prefixIcon: Icon(
                        Icons.lock,
                        size: 30,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value.toString().length <= 8) {
                        return "Password length can't be less than 8";
                      }
                    },
                    onChanged: (value) => {
                      setState(() {
                        _pass = value;
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
                            "Add Student",
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
                        // if (_formKey.currentState.validate()) {
                        //   FocusScope.of(context).unfocus();
                        _register().then((_) {
                          // print(_isLoading);
                          // if(_isLoading==false)
                          // {
                          //   print(_isLoading);
                          Navigator.of(context).pop(
                              "Hey, verify your email via link sent in the mail and the login");
                          // }
                          // else
                          // {
                          //   setState(() {
                          //     _isLoading=false;
                          //   });
                          // }
                        });
                        // FirebaseFirestore.instance.collection("Hostel").doc(_enNo).set(
                        // {
                        //   'name': _name,
                        //   'email': _email,
                        //   'Enrollment No':_enNo,
                        //   'Block':_block,
                        //   'Room No':_roomNo,
                        //   'Mobile No':_moNo,
                        //   }
                        // ).then((value){
                        //   print("Successfully added to database");
                        // });
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
          title: Text(
            "Register",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blue),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: SingleChildScrollView(
            child: _body(),
          ),
        ));
  }
}
