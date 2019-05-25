import 'package:flutter/material.dart';
import 'package:mobilefinal2/model/todo.dart';
import 'package:mobilefinal2/model/db.dart';

class TodoPage extends StatefulWidget {
  final int id;
  String name;
  final User user;
  TodoPage({Key key, this.id, this.name, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TodoPageState();
  }
}

class TodoPageState extends State<TodoPage> {
  MyTodoProvider db = MyTodoProvider();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    int id = widget.id;
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
              future: db.loadDatas(
                  "https://jsonplaceholder.typicode.com/todos?userId=$id", id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return todoList(context, snapshot);
                } else {
                  return Center(
                    child: Text("No todo found!"),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget todoList(BuildContext context, AsyncSnapshot snapshot) {
    List<Todo> todoList = snapshot.data;
    return Expanded(
      child: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("${todoList[index].id}"),
                    Text("${todoList[index].title}"),
                    Text(
                        "${todoList[index].completed}" == "true" ? "Completed" : ""),
                  ],
                ),
            ),
          );
        },
      ),
    );
  }
}
