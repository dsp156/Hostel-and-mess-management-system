// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:hostel_and_mess/complain.dart';
// import 'package:hostel_and_mess/fetchLoginStudentsComplain.dart';
// import 'package:hostel_and_mess/login.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:hostel_and_mess/profile.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// class Dashboard extends StatefulWidget {
//   final String enNo;
//   Dashboard({this.enNo});
//   @override
//   _DashboardState createState() => _DashboardState(enNo: enNo);
// }

// class _DashboardState extends State<Dashboard> {
//   final String enNo;
//   _DashboardState({this.enNo});
//   Future<void> signOut(BuildContext context) async {
//     try {
//       await FirebaseAuth.instance.signOut().then((value) {
//         print("User logged out");
//         Navigator.of(context).pushReplacement(
//             MaterialPageRoute(builder: (BuildContext context) => Login()));
//       });
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }

//   Widget _drawer() {
//     return Drawer(
//       child: Container(
//         color: Colors.black,
//         child: ListView(
//           children: <Widget>[
//             UserAccountsDrawerHeader(
//               accountName: Text(
//                 enNo,
//                 style: TextStyle(
//                   color: Colors.black,
//                 ),
//               ),
//               currentAccountPicture: FlutterLogo(),
//               accountEmail: null,
//             ),
//             ListTile(
//               title: Text(
//                 "My Profile",
//                 style: TextStyle(color: Colors.white),
//               ),
//               leading: Icon(
//                 Icons.account_box_sharp,
//                 color: Colors.white,
//               ),
//               onTap: () {
//                 Navigator.of(context).pop();
//                 Navigator.of(context).push(new MaterialPageRoute(
//                     builder: (BuildContext context) => Profile(
//                           enNo: enNo,
//                         )));
//               },
//             ),
//             Divider(
//               color: Colors.blue,
//               height: 0.0,
//             ),
//             ListTile(
//                 title: Text(
//                   "Complain",
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 leading: Icon(
//                   Icons.logout,
//                   color: Colors.white,
//                 ),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                   Navigator.of(context).push(new MaterialPageRoute(
//                       builder: (BuildContext context) => Complain(
//                             enNo: enNo,
//                           )));
//                 }),
//             Divider(
//               color: Colors.blue,
//               height: 0.0,
//             ),
//             ListTile(
//                 title: Text(
//                   "Your Complains",
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 leading: Icon(
//                   Icons.logout,
//                   color: Colors.white,
//                 ),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                   Navigator.of(context).push(new MaterialPageRoute(
//                       builder: (BuildContext context) => FetchComplain(
//                             enNo: enNo,
//                           )));
//                 }),
//             Divider(
//               color: Colors.blue,
//               height: 0.0,
//             ),
//             ListTile(
//               title: Text(
//                 "Logout",
//                 style: TextStyle(color: Colors.white),
//               ),
//               leading: Icon(
//                 Icons.logout,
//                 color: Colors.white,
//               ),
//               onTap: () => signOut(context),
//             ),
//             Divider(
//               color: Colors.blue,
//               height: 0.0,
//             ),
//             ListTile(
//               title: Text(
//                 "Close",
//                 style: TextStyle(color: Colors.white),
//               ),
//               leading: Icon(
//                 Icons.close,
//                 color: Colors.white,
//               ),
//               onTap: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             Divider(
//               color: Colors.blue,
//               height: 0.0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//    @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("DashBoard"),
//         ),
//         drawer: _drawer(),
//         body: _uid != null
//             ? Column(
//                 children: [
//                   Text('Add Complains'),
//                   RaisedButton(
//                       onPressed: () => Navigator.of(context).push(
//                           MaterialPageRoute(
//                               builder: (context) => Complain(uid: _uid))),
//                       child: Text("Add Complains")),
//                   Text('Show your Complains'),
//                   RaisedButton(
//                       onPressed: () => Navigator.of(context).push(
//                           MaterialPageRoute(
//                               builder: (context) => FetchComplain(uid: _uid))),
//                       child: Text("Show complains")),
//                   Text('Todays menu'),
//                   RaisedButton(
//                       onPressed: () => Navigator.of(context).push(
//                           MaterialPageRoute(
//                               builder: (context) => FetchMessMenuForStudent())),
//                       child: Text("Todays menu")),
//                   Text('Todays Mess Schedule'),
//                   RaisedButton(
//                       onPressed: () => Navigator.of(context).push(
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   FetchMessScheduleForStudent())),
//                       child: Text("Mess Schedule")),
//                   Text('Hostel info'),
//                   RaisedButton(
//                       onPressed: () => Navigator.of(context).push(
//                           MaterialPageRoute(
//                               builder: (context) => FetchDetail())),
//                       child: Text("Hoste Info")),
//                 ],
//               )
//             : Container());
//   }

// }
