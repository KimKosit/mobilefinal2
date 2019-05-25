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
  SharedPreferences sharePref;
  @override
  Widget build(BuildContext context) {
    User user = widget.user;
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Container(child: ListTile(
                title: Center(child: Text('Hello ${user.name}'),),
                subtitle: Center(child:Text('this is my quote  "${user.quote}"')),
              ),),
                  RaisedButton(
                    child: Text('PROFILE SETUP'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Profile(user: user)));
                    },
                  ),
                  RaisedButton(
                    child: Text('My FRIENDS'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Friend(user: user)));
                    },
                  ),
                  RaisedButton(
                    child: Text('SIGN OUT'),
                    onPressed: () async {
                      Navigator.pushNamed(context, '/');
                      sharePref = await SharedPreferences.getInstance();
                      sharePref.setString("username", null);
                      sharePref.setString("password", null);
                      Navigator.pushReplacementNamed(context, '/');
                    },
                  )
            ],
          ),
        ));
  }
}
