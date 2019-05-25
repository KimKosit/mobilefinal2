import 'package:flutter/material.dart';
import 'package:mobilefinal2/model/db.dart';
import 'friends.dart';
import 'todo.dart';

class FriendInfo extends StatefulWidget {
  int id;
  String name;
  final User user;
  FriendInfo({Key key, this.id, this.name, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return FriendInfoState();
  }
}

class FriendInfoState extends State<FriendInfo> {
  @override
  Widget build(BuildContext context) {
    int id = widget.id;
    String name = widget.name;
    User user = widget.user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Info'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${id} : ${name}",
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: RaisedButton(
                child: Container(
                  child: Center(child: Text("TODOS")),
                  width: double.infinity,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TodoPage(
                                id: id,
                                name: name,
                                user: user,
                              )));
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: RaisedButton(
                child: Container(
                  child: Center(child: Text("POST")),
                  width: double.infinity,
                ),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute());
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: RaisedButton(
                child: Container(
                  child: Center(child: Text("ALBUMS")),
                  width: double.infinity,
                ),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute());
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: RaisedButton(
                child: Container(
                  child: Center(child: Text("BACK")),
                  width: double.infinity,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Friend(user: user)));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
