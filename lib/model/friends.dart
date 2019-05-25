import 'package:http/http.dart' as http;
import 'dart:convert';

class MyFriend {
  int id;
  String email;
  String name;
  String phone;
  String website;

  MyFriend({this.id, this.name, this.email, this.phone, this.website});

  factory MyFriend.fromJson(Map<String, dynamic> json) {
    return new MyFriend(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      website: json['website'],
    );
  }
}

class FriendList {
  final List<MyFriend> friends;
  FriendList({
    this.friends,
  });
  factory FriendList.fromJson(List<dynamic> parsedJson) {
    List<MyFriend> friends = new List<MyFriend>();
    friends = parsedJson.map((i) => MyFriend.fromJson(i)).toList();

    return new FriendList(
      friends: friends,
    );
  }
}

class FriendProvider {
  Future<List<MyFriend>> loadDatas(String url) async {
    http.Response response = await http.get(url);
    final data = json.decode(response.body);
    FriendList friendList = FriendList.fromJson(data);
    return friendList.friends;
  }
}

