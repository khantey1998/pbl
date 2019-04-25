import 'package:flutter/material.dart';
import 'package:pbl/pages/customers.dart';
import './home.dart';
import './order.dart';

class LogInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
              child: Image.asset(
                'assets/logo.png',
                width: 300,
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  ),
                  Container(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      obscureText: true,
                    ),
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  ),
                  Container(
                    color: Colors.transparent,
                    width: 200,
                    height: 60,
                    child: FlatButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => Order(),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.white),
                      ),
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              height: 350,
              padding: EdgeInsets.all(8),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Text(
                  'Need Help?',
                  style: TextStyle(fontSize: 20, color: Colors.lightBlue),
                ),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
