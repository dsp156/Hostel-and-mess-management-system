import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController _nameController;
  bool _eyeClosed = true;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _nameController = TextEditingController();
    super.initState();
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
                    obscureText: _eyeClosed,
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: "Enter Admin Secret Key",
                      prefixIcon: Icon(
                        Icons.lock,
                        size: 30,
                      ),
                      suffixIcon: IconButton(
                          icon: Icon(
                            _eyeClosed == true
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_eyeClosed == true) {
                                _eyeClosed = false;
                              } else {
                                _eyeClosed = true;
                              }
                            });
                          }),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value.toString().length == 0) {
                        return "Secret key can not be empty!";
                      }
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
                            "Submit",
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
                        addAdmin();
                        setState(() {
                          _nameController.text = '';
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
          title: Text("Admin Login page"),
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: SingleChildScrollView(
            child: _body(),
          ),
        ));
  }

  void addAdmin() {
    String name = _nameController.text;
    if (name == 'adminlogin') {
      Navigator.of(context).pushNamed('/adminPage');
    }
  }
}
