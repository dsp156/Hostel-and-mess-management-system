// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'helper.dart';
// import 'package:flutter/material.dart';

// class AddMessMenu extends StatefulWidget {
//   @override
//   _AddMessMenuState createState() => _AddMessMenuState();
// }

// class _AddMessMenuState extends State<AddMessMenu> {
//   bool valuefirst = false;
//   Helper _helper = Helper();
//   final _formKey = GlobalKey<FormState>();
//   String _chefName,
//       _messManagerName,
//       _messManagerPhone,
//       _foodCordiName,
//       _foodCordiPhone_typesOfRoom,
//       _fees,
//       _rectorName,
//       _rectorPhone,
//       _peonName1,
//       _peonPhone1,
//       _peonName2,
//       _peonPhone2,
//       _peonName3,
//       _peonPhone3;

//   Future<bool> _addData() async {
//     Map<String, dynamic> data = {};
//     await FirebaseFirestore.instance
//         .collection('Hostel Mess Info')
//         .doc("Info")
//         .set(data)
//         .then((value) async {
//       print("Data added");
//     }).catchError((e) {
//       print(e);
//       _helper.show("Opps!! Some error occured. Try again");
//       _helper.flushbar..show(context);
//       return false;
//     });
//     return true;
//   }

//   Widget _body() {
//     return Card(
//       elevation: 5.0,
//       color: Colors.black,
//       shape: RoundedRectangleBorder(
//           side: BorderSide(color: Colors.blue, width: 1.0),
//           borderRadius: BorderRadius.circular(10.0)),
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         child: Padding(
//           padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 32.0),
//           child: Center(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     decoration: InputDecoration(
//                         labelText: "Breakfast",
//                         labelStyle: TextStyle(backgroundColor: Colors.white),
//                         filled: true,
//                         hintText: "Enter breakfast",
//                         prefixIcon: Icon(
//                           Icons.add,
//                           size: 30.0,
//                         ),
//                         fillColor: Colors.white,
//                         border: OutlineInputBorder(
//                             borderRadius: const BorderRadius.all(
//                                 const Radius.circular(8.0)))),
//                     validator: (value) {
//                       if (value.toString().length == 0) {
//                         return "Breakfast not be zero";
//                       }
//                     },
//                     onChanged: (value) {
//                       setState(() {
//                         _breakFast = value;
//                       });
//                     },
//                   ),
//                   TextFormField(
//                     decoration: InputDecoration(
//                         labelText: "Lunch",
//                         labelStyle: TextStyle(backgroundColor: Colors.white),
//                         filled: true,
//                         hintText: "Enter Lunch",
//                         prefixIcon: Icon(
//                           Icons.person,
//                           size: 30.0,
//                         ),
//                         fillColor: Colors.white,
//                         border: OutlineInputBorder(
//                             borderRadius: const BorderRadius.all(
//                                 const Radius.circular(8.0)))),
//                     validator: (value) {
//                       if (value.toString().length == 0) {
//                         return "Lunch not be zero";
//                       }
//                     },
//                     onChanged: (value) {
//                       setState(() {
//                         _lunch = value;
//                       });
//                     },
//                   ),
//                   TextFormField(
//                     decoration: InputDecoration(
//                         labelText: "Dinner",
//                         labelStyle: TextStyle(backgroundColor: Colors.white),
//                         filled: true,
//                         hintText: "Enter Dinner",
//                         prefixIcon: Icon(
//                           Icons.lock,
//                           size: 30.0,
//                         ),
//                         fillColor: Colors.white,
//                         border: OutlineInputBorder(
//                             borderRadius: const BorderRadius.all(
//                                 const Radius.circular(8.0)))),
//                     validator: (value) {
//                       if (value.toString().length == 0) {
//                         return "Dinner not be zero";
//                       }
//                     },
//                     onChanged: (value) {
//                       setState(() {
//                         _dinner = value;
//                       });
//                     },
//                   ),
//                   FlatButton(
//                       color: Colors.blue,
//                       splashColor: Colors.white,
//                       highlightColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                           side: BorderSide(color: Colors.blue, width: 1.0),
//                           borderRadius: BorderRadius.circular(10.0)),
//                       onPressed: () {
//                         if (_formKey.currentState.validate()) {
//                           FocusScope.of(context).unfocus();
//                           _addData().then((_) {
//                             Navigator.of(context).pop("Your Menu  is uploaded");
//                           });
//                         }
//                       },
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Upload Menu",
//                             style: TextStyle(
//                               color: Colors.white,
//                               // backgroundColor: Colors.blueGrey
//                             ),
//                           ),
//                           SizedBox(
//                             width: 10.0,
//                           ),
//                           Icon(
//                             Icons.upload_sharp,
//                             color: Colors.white,
//                           ),
//                         ],
//                       )),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Add Mess Menu"),
//       ),
//       body: _body(),
//     );
//   }
// }
