import 'package:flutter/material.dart';
import 'package:mobilefinal2/model/db.dart';
import 'package:mobilefinal2/ui/home.dart';

class Profile extends StatefulWidget {
  final User user;
  Profile({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController userId = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController quote = TextEditingController();
  List<User> allUser = new List();
  TodoProvider user = TodoProvider();

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
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    User thisUser = widget.user;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
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
                      if (allUser[i].userId == value && thisUser.userId != value) return "This id already taken";
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
           Container(
                margin: const EdgeInsets.only(top: 20),
                child: TextField(
                  controller: quote,
                  maxLines: 5,
                  decoration: InputDecoration(
                      icon: Icon(Icons.format_quote), hintText: "Quote"),
                ),
              ),
            RaisedButton(
              child: Text("Save"),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  thisUser.userId = userId.text;
                  thisUser.name = name.text;
                  thisUser.age = int.parse(age.text);
                  thisUser.password = password.text;
                  thisUser.quote = quote.text;
                  user.update(thisUser).then((value) {
                    Navigator.pop(context);
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


