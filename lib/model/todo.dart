import 'package:http/http.dart' as http;
import 'dart:convert';

class Todo {
  int userId;
  int id;
  String title;
  bool completed;

  Todo({this.userId, this.id, this.title, this.completed});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return new Todo(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }
}

class TodoList {
  List<Todo> todos;
  TodoList({
    this.todos,
  });
  factory TodoList.fromJson(List<dynamic> parsedJson) {
    List<Todo> todos = new List<Todo>();
    todos = parsedJson.map((i) => Todo.fromJson(i)).toList();

    return new TodoList(
      todos: todos,
    );
  }
}

class MyTodoProvider {
  Future<List<Todo>> loadDatas(String url, int id) async {
    List<Todo> filter = List<Todo>();
    http.Response response = await http.get(url);
    final data = json.decode(response.body);
    TodoList todoList = TodoList.fromJson(data);
    for (int i = 0; i < todoList.todos.length; i++) {
      if (todoList.todos[i].userId == id) {
        filter.add(todoList.todos[i]);
      }
    }
    return filter;
  }
}
