import 'package:flutter/material.dart';
import 'package:mobilefinal2/model/db.dart';
import 'package:mobilefinal2/model/db.dart';
import 'home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TodoProvider user = TodoProvider();
  List<User> allUser = new List();
  SharedPreferences sharePref;

  @override
  void initState() {
    super.initState();
    user.openDB().then((open) {
      getAllUser();
    });
  }

  void getAllUser() {
    user.getAllUser().then((myList) async {
      setState(() {});
      allUser = myList;
      sharePref = await SharedPreferences.getInstance();
      String username = sharePref.getString('username');
      String password = sharePref.getString('password');
      if (username != "") {
        for (int i = 0; i < allUser.length; i++) {
          if (allUser[i].userId == username &&
              allUser[i].password == password) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(user: allUser[i])));
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.only(top: 70),
          child: ListView(
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              Image.network(
                "https://plumbr.io/app/uploads/2015/01/thread-lock.jpeg", height: 200,
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: TextFormField(
                  controller: username,
                  decoration: InputDecoration(
                      icon: Icon(Icons.person), hintText: "User Id"),
                  validator: (value) {
                    if (value.isEmpty)
                      return "Please enter User Id";
                    else if (value.length < 6 || value.length > 12)
                      return "User Id must be 6-12 characters long";
                  },
                ),
              ),
              Container(
                margin:  EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                      icon: Icon(Icons.lock), hintText: "Password"),
                  validator: (value) {
                    if (value.isEmpty)
                      return "Please enter Password";
                    else if (value.length < 6)
                      return "Password must be more than 6 characters long";
                  },
                ),
              ),
              RaisedButton(
                child: Text("LOGIN"),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    for (int i = 0; i < allUser.length; i++) {
                      if (allUser[i].userId == username.text &&
                          allUser[i].password == password.text) {
                        sharePref = await SharedPreferences.getInstance();
                        sharePref.setString("username", allUser[i].userId);
                        sharePref.setString("password", allUser[i].password);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomePage(user: allUser[i])));
                      }
                    }
                    if (username.text.length > 0 &&
                        password.text.length > 0) {
                      return showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Alert"),
                            content:
                                 Text("Incorrect User Id or Password"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
              ),
              Container(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  child: Text(
                    "Register New Account",
                    style: TextStyle(color: Colors.teal),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/register");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
