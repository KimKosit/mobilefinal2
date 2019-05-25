import 'package:flutter/material.dart';
import 'package:mobilefinal2/model/friends.dart';
import 'package:mobilefinal2/model/db.dart';
import 'package:mobilefinal2/ui/todo.dart';

class Friend extends StatefulWidget {
  final User user;
  Friend({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FriendState();
  }
}

class FriendState extends State<Friend> {
  FriendProvider friend = FriendProvider();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('BACK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            
            FutureBuilder(
              future: friend
                  .loadDatas("https://jsonplaceholder.typicode.com/users"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return friendList(context, snapshot);
                } else {
                  return Center(
                    child: Text("You've got no friends!"),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget friendList(BuildContext context, AsyncSnapshot snapshot) {
    List<MyFriend> friendList = snapshot.data;
    User myUser = widget.user;
    return Expanded(
      child: ListView.builder(
        itemCount: friendList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Container(
              child: InkWell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("${friendList[index].id} : ${friendList[index].name}"),
                    Text("${friendList[index].email}"),
                    Text("${friendList[index].phone}"),
                    Text("${friendList[index].website}"),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TodoPage(
                                id: friendList[index].id,
                                name: friendList[index].name,
                                user: myUser,
                              )));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
