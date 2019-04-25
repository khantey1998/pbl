import 'package:flutter/material.dart';
import 'package:pbl/pages/startup.dart';
import 'pages/order.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PBLCNT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Order(),
    );
  }
}
