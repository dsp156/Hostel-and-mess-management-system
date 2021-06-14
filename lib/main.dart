import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostel_and_mess/AddMessItem.dart';
import 'package:hostel_and_mess/FetchDetail.dart';
import 'package:hostel_and_mess/FetchMessScheduleForStudents.dart';
import 'package:hostel_and_mess/addStudent.dart';
import 'package:hostel_and_mess/complain.dart';
import 'package:hostel_and_mess/fetchLoginStudentsComplain.dart';
import 'package:hostel_and_mess/fetchMessMenuForStudents.dart';
import 'package:hostel_and_mess/helper.dart';
import 'package:hostel_and_mess/profile.dart';
// import 'package:hostel_mess/showStudent.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'adminLogin.dart';
import 'package:hostel_and_mess/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'adminPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  GestureBinding.instance.resamplingEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      routes: <String, WidgetBuilder>{
        'landingpage': (BuildContext context) => MyApp(),
        '/login': (BuildContext context) => Login(),
        '/addStudent': (BuildContext context) => AddStudent(),
        '/adminLogin': (BuildContext context) => AdminLogin(),
        // '/dashboard': (BuildContext context) => Dashboard(),
        '/adminPage': (BuildContext context) => AdminAdd(),
        '/addMessMenu': (BuildContext context) => AddMessMenu(),
      },
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      darkTheme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.black,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: "Lato"),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String enNo, _uid, _name, _email, _url;
  User _user;
  Helper _helper = Helper();
  bool _isLoading = false;
  // @override
  // void initState() {
  //   super.initState();
  //   checkingLogOutOrNot();
  // }

  // Future<void> checkingLogOutOrNot() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     enNo = preferences.getString('En_No');
  //   });
  // }

  void _signIn() {
    Navigator.of(context).pop();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Login()))
        .then((value) {
      if (value != null) {
        if (mounted)
          setState(() {
            _user = FirebaseAuth.instance.currentUser;
          });
        _getDetails().then((_) {
          _profileUrl();
        });
        _helper.show(value);
        _helper.flushbar.show(context);
      }
    });
  }

  Future<void> _signOut() async {
    Navigator.of(context).pop();
    await FirebaseAuth.instance.signOut().then((value) {
      print("User logged out");
      _helper.show("You are logged out:)");
      _helper.flushbar.show(context);
      setState(() {
        _user = null;
      });
      _getDetails().then((_) {
        _profileUrl();
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> _getDetails() async {
    if (_user != null && _user.emailVerified) {
      await FirebaseFirestore.instance
          .collection('En No')
          .doc(_user.uid)
          .get()
          .then((value) {
        setState(() {
          _name = value.data()['name'];
          _email = _user.email;
          _uid = _user.uid;
        });
        print(_name);
        print(_email);
      }).catchError((e) {
        print(e);
      });
    } else {
      setState(() {
        _name = null;
        _email = null;
        _uid = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    _user = FirebaseAuth.instance.currentUser;
    if (_user == null || _user.emailVerified == false) {
      setState(() {
        _user = null;
      });
    }
    _getDetails().then((_) async {
      await _profileUrl();
      setState(() {
        _isLoading = false;
      });
    }).catchError((e) {
      setState(() {
        _isLoading = false;
      });
    });
    // print(_name);
    // print(_email);
    // print(_uid);
  }

  Future<void> _profileUrl() async {
    if (_user != null && _user.emailVerified) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_uid)
          .get()
          .then((value) {
        // print(value.data().containsKey('profileUrl'));
        if (value.data().containsKey('profileUrl') == true) {
          setState(() {
            _url = value.data()['profileUrl'].toString();
          });
        }
        print(_url);
      });
    } else {
      setState(() {
        _url =
            "https://png.pngitem.com/pimgs/s/506-5067022_sweet-shap-profile-placeholder-hd-png-download.png";
      });
    }
  }

  Widget _drawer() {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: ListView(
          children: <Widget>[
            _uid != null
                ? UserAccountsDrawerHeader(
                    accountName: Text(
                      _name,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    accountEmail: Text(
                      _email,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    currentAccountPicture: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 2.0),
                          color: Colors.black,
                        ),
                        child: ClipOval(
                          child: Hero(
                            tag: "profilepic",
                            child: FlutterLogo(
                              size: 100,
                            ),
                          ),
                        )),
                  )
                : Container(),
            _uid != null
                ? ListTile(
                    title: Text(
                      "My Profile",
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => Profile(
                                    uid: _uid,
                                  )))
                          .then((_) {
                        _profileUrl();
                        _getDetails();
                      });
                    },
                  )
                : ListTile(
                    title: Text(
                      "Admin Login",
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Icon(
                      Icons.login,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AdminLogin()));
                    },
                  ),
            Divider(
              color: Colors.blue,
              height: 0.0,
            ),
            ListTile(
                title: Text(
                  _uid != null ? "Logout" : "Login",
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.account_box,
                  color: Colors.white,
                ),
                onTap: () {
                  // Navigator.of(context).pop();
                  _uid == null ? _signIn() : _signOut();
                }),
            Divider(
              color: Colors.blue,
              height: 0.0,
            ),
            ListTile(
              title: Text(
                "Close",
                style: TextStyle(color: Colors.white),
              ),
              leading: Icon(
                Icons.close,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            Divider(
              color: Colors.blue,
              height: 0.0,
            ),
          ],
        ),
      ),
    );
  }

  var arr = ['Add', 'Show', 'Today', 'Mess', 'Hostel & Mess'];
  var arra = ['Complains', 'Complains', 'Menu', 'Schedule', 'Info'];
  var xyz = ['Admin Login', 'Login'];
  var images = [
    'https://images.unsplash.com/photo-1488190211105-8b0e65b80b4e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=750&q=80',
    'https://images.unsplash.com/photo-1427504494785-3a9ca7044f45?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',
  ];
  var image = [
    'https://images.unsplash.com/photo-1484480974693-6ca0a78fb36b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=752&q=80',
    'https://images.unsplash.com/photo-1596300919209-8aca632f3730?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8Y29tcGxhaW5zfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1565895405139-e188df996e0b?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8Zm9vZCUyMG1lbnV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1506485338023-6ce5f36692df?ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8c2NoZWR1bGV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1552858725-a019f14f0cec?ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8aG9zdGVsfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Home Page",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blue),
          ),
          centerTitle: true,
        ),
        drawer: _drawer(),
        backgroundColor: Colors.black,
        body: _uid != null
            ? GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
                padding: EdgeInsets.all(10.0),
                children: List.generate(5, (index) {
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
                                  Colors.black.withOpacity(0.5),
                                  BlendMode.darken),
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Complain(uid: _uid)));
                        } else if (index == 1) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FetchComplain(uid: _uid)));
                        } else if (index == 2) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FetchMessMenuForStudent()));
                        } else if (index == 3) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  FetchMessScheduleForStudent()));
                        } else if (index == 4) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FetchDetail()));
                        }
                      });
                }),
              )
            : GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
                padding: EdgeInsets.all(10.0),
                children: List.generate(2, (index) {
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
                              image: NetworkImage(images[index]),
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.5),
                                  BlendMode.darken),
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
                                    xyz[index],
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AdminLogin()));
                        } else if (index == 1) {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) => Login()))
                              .then((value) {
                            if (value != null) {
                              if (mounted)
                                setState(() {
                                  _user = FirebaseAuth.instance.currentUser;
                                });
                              _getDetails().then((_) {
                                _profileUrl();
                              });
                              _helper.show(value);
                              _helper.flushbar.show(context);
                            }
                          });
                        }
                      });
                }),
              ));
  }
}
