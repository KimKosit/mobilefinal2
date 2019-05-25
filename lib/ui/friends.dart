import 'package:flutter/material.dart';
import 'package:mobilefinal2/model/friends.dart';
import 'package:mobilefinal2/model/db.dart';
import 'friendsinfo.dart';
import 'home.dart';

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
  FriendProvider friendPv = FriendProvider();
  @override
  Widget build(BuildContext context) {
    User user = widget.user;
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('BACK'),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(user: user)));
              },
            ),
            FutureBuilder(
              future: friendPv
                  .loadDatas("https://plumbr.io/app/uploads/2015/01/thread-lock.jpeg"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return frinedList(context, snapshot);
                } else {
                  return Center(
                    child: Text("..."),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget frinedList(BuildContext context, AsyncSnapshot snapshot) {
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
                    SizedBox(
                      height: 20,
                    ),
                    Text("${friendList[index].email}"),
                    SizedBox(
                      height: 10,
                    ),
                    Text("${friendList[index].phone}"),
                    SizedBox(
                      height: 10,
                    ),
                    Text("${friendList[index].website}"),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FriendInfo(
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
