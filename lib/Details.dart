import 'package:cloud_firestore/cloud_firestore.dart';
import 'helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool valuefirst = false;
  Helper _helper = Helper();
  final _formKey = GlobalKey<FormState>();
  String _chefName,
      _messManagerName,
      _messManagerPhone,
      _foodCordiName,
      _foodCordiPhone,
      _typesOfRoom,
      _fees,
      _rectorName,
      _rectorPhone,
      _peonName1,
      _peonPhone1,
      _peonName2,
      _peonPhone2,
      _peonName3,
      _peonPhone3;

  Future<bool> _addData() async {
    Map<String, dynamic> data = {
      "Chef Name": _chefName,
      "MessManagerName": _messManagerName,
      "MessManagerPhone": _messManagerPhone,
      "FoodCordinateName": _foodCordiName,
      "FoodCordinatePhone": _foodCordiPhone,
      "TypesOfRoom": _typesOfRoom,
      "Fees": _fees,
      "RectorName": _rectorName,
      "RectorPhone": _rectorPhone,
      "PeonName1": _peonName1,
      "PeonPhone1": _peonPhone1,
      "PeonName2": _peonName2,
      "PeonPhone2": _peonPhone2,
      "PeonName3": _peonName3,
      "PeonPhone3": _peonPhone3,
    };
    await FirebaseFirestore.instance
        .collection('Hostel Mess Info')
        .doc("Info")
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
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.circular(10.0)),
        child: SingleChildScrollView(
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
                        decoration: InputDecoration(
                            labelText: "Chef Name",
                            labelStyle:
                                TextStyle(backgroundColor: Colors.white),
                            filled: true,
                            hintText: "Enter Chef Name",
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
                            return "Chef Name not be zero";
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            _chefName = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "MessManagerName",
                            labelStyle:
                                TextStyle(backgroundColor: Colors.white),
                            filled: true,
                            hintText: "Enter MessManagerName",
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
                            return "MessManagerName not be zero";
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            _messManagerName = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "MessManagerPhone",
                            labelStyle:
                                TextStyle(backgroundColor: Colors.white),
                            filled: true,
                            hintText: "Enter MessManagerPhone",
                            prefixIcon: Icon(
                              Icons.phone,
                              size: 30.0,
                            ),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(8.0)))),
                        validator: (value) {
                          if (value.toString().length == 0) {
                            return "MessManagerPhone not be zero";
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            _messManagerPhone = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "FoodCordinateName",
                            labelStyle:
                                TextStyle(backgroundColor: Colors.white),
                            filled: true,
                            hintText: "Enter FoodCordinateName",
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
                            return "FoodCordinateName not be zero";
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            _foodCordiName = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "FoodCordinatePhone",
                            labelStyle:
                                TextStyle(backgroundColor: Colors.white),
                            filled: true,
                            hintText: "Enter FoodCordinatePhone",
                            prefixIcon: Icon(
                              Icons.phone,
                              size: 30.0,
                            ),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(8.0)))),
                        validator: (value) {
                          if (value.toString().length == 0) {
                            return "FoodCordinatePhone not be zero";
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            _foodCordiPhone = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "TypesOfRoom",
                            labelStyle:
                                TextStyle(backgroundColor: Colors.white),
                            filled: true,
                            hintText: "Enter TypesOfRoom",
                            prefixIcon: Icon(
                              Icons.format_align_justify,
                              size: 30.0,
                            ),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(8.0)))),
                        validator: (value) {
                          if (value.toString().length == 0) {
                            return "TypesOfRoom not be zero";
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            _typesOfRoom = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "Fees",
                            labelStyle:
                                TextStyle(backgroundColor: Colors.white),
                            filled: true,
                            hintText: "Enter Fees",
                            prefixIcon: Icon(
                              Icons.attach_money,
                              size: 30.0,
                            ),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(8.0)))),
                        validator: (value) {
                          if (value.toString().length == 0) {
                            return "Fees not be zero";
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            _fees = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "RectorName",
                            labelStyle:
                                TextStyle(backgroundColor: Colors.white),
                            filled: true,
                            hintText: "Enter RectorName",
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
                            return "RectorName not be zero";
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            _rectorName = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "RectorPhone",
                            labelStyle:
                                TextStyle(backgroundColor: Colors.white),
                            filled: true,
                            hintText: "Enter RectorPhone",
                            prefixIcon: Icon(
                              Icons.phone,
                              size: 30.0,
                            ),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(8.0)))),
                        validator: (value) {
                          if (value.toString().length == 0) {
                            return "RectorPhone not be zero";
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            _rectorPhone = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "PeonName1",
                            labelStyle:
                                TextStyle(backgroundColor: Colors.white),
                            filled: true,
                            hintText: "Enter PeonName1",
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
                            return "PeonName1 not be zero";
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            _peonName1 = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "PeonPhone1",
                            labelStyle:
                                TextStyle(backgroundColor: Colors.white),
                            filled: true,
                            hintText: "Enter PeonPhone1",
                            prefixIcon: Icon(
                              Icons.phone,
                              size: 30.0,
                            ),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(8.0)))),
                        validator: (value) {
                          if (value.toString().length == 0) {
                            return "PeonPhone1 not be zero";
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            _peonPhone1 = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "PeonName2",
                            labelStyle:
                                TextStyle(backgroundColor: Colors.white),
                            filled: true,
                            hintText: "Enter PeonName2",
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
                            return "PeonName2 not be zero";
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            _peonName2 = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "PeonPhone2",
                            labelStyle:
                                TextStyle(backgroundColor: Colors.white),
                            filled: true,
                            hintText: "Enter PeonPhone2",
                            prefixIcon: Icon(
                              Icons.phone,
                              size: 30.0,
                            ),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(8.0)))),
                        validator: (value) {
                          if (value.toString().length == 0) {
                            return "PeonPhone2 not be zero";
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            _peonPhone2 = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "PeonName3",
                            labelStyle:
                                TextStyle(backgroundColor: Colors.white),
                            filled: true,
                            hintText: "Enter PeonName3",
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
                            return "PeonName3 not be zero";
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            _peonName3 = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "PeonPhone3",
                            labelStyle:
                                TextStyle(backgroundColor: Colors.white),
                            filled: true,
                            hintText: "Enter PeonPhone3",
                            prefixIcon: Icon(
                              Icons.phone,
                              size: 30.0,
                            ),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(8.0)))),
                        validator: (value) {
                          if (value.toString().length == 0) {
                            return "PeonPhone3 not be zero";
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            _peonPhone3 = value;
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
                                Navigator.of(context)
                                    .pop("Your Menu  is uploaded");
                              });
                            }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Upload Data",
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
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Details"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: _body(),
          ),
        ));
  }
}
