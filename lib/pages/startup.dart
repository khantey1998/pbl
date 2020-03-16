import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pbl/pages/login.dart';

class Greeting extends StatefulWidget {
  @override
  _GreetingState createState() => _GreetingState();
}
class _GreetingState extends State<Greeting> {
  @override
  initState() {
    super.initState();
    Timer(const Duration(seconds: 3), onClose);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
          alignment: FractionalOffset.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

//              Text(
//                "Hello you !",
//                style: Theme.of(context).textTheme.display1,
//              ),
                  Image.asset("assets/logo.png",
                    height: 350.0,
                    width: 350.0,
                  ),
            ],
          )),
    );
  }

  void onClose() {
    Navigator.of(context).pushReplacement(PageRouteBuilder(
        maintainState: true,
        opaque: true,
        pageBuilder: (context, _, __) => LoginPage(),
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (context, anim1, anim2, child) {
          return FadeTransition(
            child: child,
            opacity: anim1,
          );
        }));
  }
}
