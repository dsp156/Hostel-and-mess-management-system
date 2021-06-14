import 'package:cloud_firestore/cloud_firestore.dart';
import 'helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddMessMenu extends StatefulWidget {
  @override
  _AddMessMenuState createState() => _AddMessMenuState();
}

class _AddMessMenuState extends State<AddMessMenu> {
  bool valuefirst = false;
  Helper _helper = Helper();
  final _formKey = GlobalKey<FormState>();
  String _breakFastL,
      _breakFastS,
      _lunchL,
      _lunchR,
      _lunchV1,
      _lunchV2,
      _lunchRoti,
      _dinnerL,
      _dinnerR,
      _dinnerV1,
      _dinnerRoti;

  Future<bool> _addData() async {
    Map<String, dynamic> data = {
      'Breakfast Liquid': _breakFastL,
      'Breakfast Solid': _breakFastS,
      'Lunch Liquid': _lunchL,
      'Lunch Veg1': _lunchV1,
      'Lunch Veg2': _lunchV2,
      'Lunch Rice': _lunchR,
      'Lunch Roti': _lunchRoti,
      'Dinner Liquid': _dinnerL,
      'Dinner Veg': _dinnerV1,
      'Dinner Rice': _dinnerR,
      'Dinner Roti': _dinnerRoti
    };
    await FirebaseFirestore.instance
        .collection('Today_Mess_Menu')
        .doc("Todays_Menu")
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
      margin: EdgeInsets.all(4.0),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Tea, Coffe or milk",
                        labelStyle: TextStyle(backgroundColor: Colors.white),
                        filled: true,
                        hintText: "Enter Tea, Coffe or milk",
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
                        return "Tea or coffe not be zero";
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _breakFastL = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Breakfast",
                        labelStyle: TextStyle(backgroundColor: Colors.white),
                        filled: true,
                        hintText: "Enter Breakfast",
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
                        return "Breakfast not be zero";
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _breakFastS = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Lunch Liquid",
                        labelStyle: TextStyle(backgroundColor: Colors.white),
                        filled: true,
                        hintText: "Enter Lunch Liquid",
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
                        return "Lunch Liquid not be zero";
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _lunchL = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Lunch  Vegetable 1",
                        labelStyle: TextStyle(backgroundColor: Colors.white),
                        filled: true,
                        hintText: "Enter Vegetable 1 for Lunch",
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
                        return "Vegetable not be zero";
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _lunchV1 = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Lunch Vegetable 2",
                        labelStyle: TextStyle(backgroundColor: Colors.white),
                        filled: true,
                        hintText: "Enter Vegetable 2 for Lunch",
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
                        return "Vegetable not be zero";
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _lunchV2 = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Lunch Rice, Dal",
                        labelStyle: TextStyle(backgroundColor: Colors.white),
                        filled: true,
                        hintText: "Enter Rice, Dal for Lunch",
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
                        return "Rice dal not be zero";
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _lunchR = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Lunch Roti",
                        labelStyle: TextStyle(backgroundColor: Colors.white),
                        filled: true,
                        hintText: "Enter Roti for Lunch",
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
                        return "Roti not be zero";
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _lunchRoti = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Dinner Luquid",
                        labelStyle: TextStyle(backgroundColor: Colors.white),
                        filled: true,
                        hintText: "Enter Dinner Luquid",
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
                        return "Dinner Luquid not be zero";
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _dinnerL = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Dinner Roti",
                        labelStyle: TextStyle(backgroundColor: Colors.white),
                        filled: true,
                        hintText: "Enter Dinner Roti",
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
                        return "Dinner Roti not be zero";
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _dinnerRoti = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Dinner Vegetable",
                        labelStyle: TextStyle(backgroundColor: Colors.white),
                        filled: true,
                        hintText: "Enter Vegetable for Dinner",
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
                        return "Vegetable not be zero";
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _dinnerV1 = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Dinner Rice",
                        labelStyle: TextStyle(backgroundColor: Colors.white),
                        filled: true,
                        hintText: "Enter Dinner Rice",
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
                        return "Rice not be zero";
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _dinnerR = value;
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
                            "Upload Menu",
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
          title: Text("Add Mess Menu"),
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: SingleChildScrollView(
            child: _body(),
          ),
        ));
  }
}
