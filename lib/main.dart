import 'package:flutter/material.dart';
import 'package:pbl/pages/startup.dart';
import 'pages/order.dart';
import 'pages/home.dart';
import 'pages/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PBLCNT',
      theme: ThemeData(
        primaryColor: Color(0xffa78066),
        primarySwatch: Colors.brown,
      ),
      home: LogInPage(),
    );
  }
}
