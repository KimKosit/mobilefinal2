import 'package:flutter/material.dart';
import 'package:mobilefinal2/model/db.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  List<User> allUser = new List();
  TodoProvider user = TodoProvider();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController userId = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  @override
  void initState() {
    super.initState();
    user.openDB().then((open) {
      getAllUser();
    });
  }

  void getAllUser() {
    user.getAllUser().then((myList) {
      setState(() {
        allUser = myList;
        print(allUser.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(top: 30),
                child: TextFormField(
                  controller: userId,
                  decoration: InputDecoration(
                      icon: Icon(Icons.person), hintText: "User Id"),
                  validator: (value) {
                    if (value.isEmpty)
                      return "Please enter User Id";
                    else if (value.length < 6 || value.length > 12)
                      return "User Id must be 6-12 characters long";
                    for (int i = 0; i < allUser.length; i++) {
                      if (allUser[i].userId == value) return "This id already taken";
                    }
                  },
                ),
              ),
             Container( 
                margin: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                      icon: Icon(Icons.account_circle), hintText: "Name"),
                  validator: (value) {
                    var check = value.split(" ");
                    if (value.isEmpty)
                      return "Please enter Name";
                    else if (check.length != 2)
                      return "Name and surname must be seperate by space";
                  },
                ),
              ),
            Container(
                margin: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: age,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today), hintText: "Age"),
                  validator: (value) {
                    if (value.isEmpty)
                      return "Please enter age";
                    else if (int.parse(value) < 10 || int.parse(value) > 80)
                      return "Age must be 10-80";
                  },
                ),
              ),
            Container(
                margin: const EdgeInsets.only(top: 20),
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
              child: Text("CONTINUE"),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  User data = User(
                      userId: userId.text,
                      password: password.text,
                      name: name.text,
                      age: int.parse(age.text));
                  user.insert(data).then((result) {
                    Navigator.pushNamed(context, '/');
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
