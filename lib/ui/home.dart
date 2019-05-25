import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobilefinal2/model/db.dart';
import 'friends.dart';
import 'profile.dart';


class HomePage extends StatefulWidget {
  final User user;
  HomePage({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  SharedPreferences sprefer;
  @override
  Widget build(BuildContext context) {
    User user = widget.user;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Home'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text('HELLO ${user.name}',
                    style: new TextStyle(fontSize: 20)),
                subtitle: Text('this is my quote  "${user.quote}"'),
              ),
              Column(
                children: <Widget>[
                  RaisedButton(
                    child: Text('PROFILE SETUP'),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Profile(user: user)));
                    },
                  ),
                  RaisedButton(
                    child: Text('My FRIENDS'),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Friend(user: user)));
                    },
                  ),
                  RaisedButton(
                    child: Text('SIGN OUT'),
                    onPressed: () async {
                      Navigator.pushNamed(context, '/');
                      sprefer = await SharedPreferences.getInstance();
                      sprefer.setString("username", null);
                      sprefer.setString("password", null);
                      Navigator.pushReplacementNamed(context, '/');
                    },
                  )
                ],
              )
            ],
          ),
        ));
  }
}
