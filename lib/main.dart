import 'package:flutter/material.dart';
import 'ui/login.dart';
import 'ui/register.dart';
import 'ui/home.dart';
import './ui/profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        "/": (context) => LoginPage(),
        "/home": (context) => HomePage(),
        "/register": (context) => RegisterPage(),
        "/profile": (context) => Profile()
      },
    );
  }
}
