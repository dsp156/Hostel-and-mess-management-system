// import 'package:hostel_mess/showRoom.dart';
import 'package:hostel_and_mess/AddMessItem.dart';
import 'package:hostel_and_mess/Details.dart';
import 'package:hostel_and_mess/FetchAllComplains.dart';
import 'package:hostel_and_mess/FetchDetail.dart';
import 'package:hostel_and_mess/MessScheduleAdd.dart';
import 'package:hostel_and_mess/addStudent.dart';
import 'package:hostel_and_mess/fetchAllStudents.dart';
import 'package:hostel_and_mess/fetchLoginStudentsComplain.dart';
import 'package:hostel_and_mess/fetchMessMenu.dart';
import 'package:hostel_and_mess/showStudent.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';

import 'FetchMessSchedule.dart';

class AdminAdd extends StatefulWidget {
  @override
  _AdminAddState createState() => _AdminAddState();
}

class _AdminAddState extends State<AdminAdd> {
  var arr = [
    'ADD',
    'SHOW',
    'ADD MESS',
    'SHOW MESS',
    'ADD MESS',
    'SHOW MESS',
    'SHOW ALL',
    'SHOW ALL',
    'SHOW',
    'ADD',
  ];

  var arra = [
    'STUDENTS',
    'STUDENTS',
    'MENU',
    'MENU',
    'SCHEDULE',
    'SCHEDULE',
    'STUDENTS',
    'COMPLAINS',
    'HOSTEL INFO',
    'Hostel info'
  ];

  var image = [
    'https://images.unsplash.com/photo-1513258496099-48168024aec0?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80',
    'https://images.unsplash.com/photo-1515168985652-8454bcc8fcaf?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8c2hvdyUyMHN0dWRlbnR8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1599250300435-b9693f21830d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YWRkJTIwbWVzcyUyMG1lbnV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1565895405139-e188df996e0b?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8Zm9vZCUyMG1lbnV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1456324504439-367cee3b3c32?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fHNjaGVkdWxlfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1506485338023-6ce5f36692df?ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8c2NoZWR1bGV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1492538368677-f6e0afe31dcc?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8ZmV0Y2glMjBhbGwlMjBzdHVkZW50c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1596300919209-8aca632f3730?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8Y29tcGxhaW5zfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1552858725-a019f14f0cec?ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8aG9zdGVsfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1596300919209-8aca632f3730?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8Y29tcGxhaW5zfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
  ];

  // TextEditingController _nameController,
  //     _enController,
  //     _moNoController,
  //     _blockController;
  // DatabaseReference _ref;
  // @override
  // void initState() {
  //   super.initState();
  //   _nameController = TextEditingController();
  //   _enController = TextEditingController();
  //   _moNoController = TextEditingController();
  //   _blockController = TextEditingController();
  //   _ref = FirebaseDatabase.instance.reference().child('Students');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Admin Page",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blue),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.black,
        body: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
          padding: EdgeInsets.all(10.0),
          children: List.generate(10, (index) {
            return InkWell(
                splashColor: Colors.white,
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Card(
                  margin: EdgeInsets.all(2.0),
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 0.5),
                      image: DecorationImage(
                        image: NetworkImage(image[index]),
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.5), BlendMode.darken),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: [
                            Text(
                              arr[index],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              arra[index],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.keyboard_arrow_right_rounded,
                          color: Colors.white,
                          size: 30.0,
                        )
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  if (index == 0) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AddStudent()));
                  } else if (index == 1) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ShowStudents()));
                  } else if (index == 2) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AddMessMenu()));
                  } else if (index == 3) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FetchMessMenu()));
                  } else if (index == 4) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MessScheduleAdd()));
                  } else if (index == 5) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FetchMessSchedule()));
                  } else if (index == 6) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FetchAllStudents()));
                  } else if (index == 7) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FetchAllComplains()));
                  } else if (index == 8) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FetchDetail()));
                  } else if (index == 9) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Details()));
                  }
                });
          }),
        ));
  }
}
