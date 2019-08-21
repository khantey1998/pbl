//import 'package:flutter/material.dart';
//import '../blocs/bloc.dart';
//import '../blocs/provider.dart';
//
//class LogInPage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    final bloc = Provider.of(context);
//
//    return Scaffold(
//      body: SingleChildScrollView(
//        child: Container(
//          height: MediaQuery.of(context).size.height,
//          margin: EdgeInsets.all(16.0),
//          child: Column(
//            mainAxisSize: MainAxisSize.max,
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Image.asset(
//                'assets/logo.png',
//                width: 300,
//              ),
//              emailField(bloc),
//              SizedBox(height: 20,),
//              passwordField(bloc),
//              Container(margin: EdgeInsets.only(top: 30.0)),
//              submitButton(bloc),
//            ],
//          ),
//        ),
//      )
//    );
//  }
//
//  Widget emailField(bloc) {
//    return StreamBuilder(
//      stream: bloc.email,
//      builder: (context, snapshot) {
//        return TextField(
//          onChanged: bloc.changeEmail,
//          keyboardType: TextInputType.emailAddress,
//          decoration: InputDecoration(
//            border: OutlineInputBorder(),
//            hintText: 'you@example.com',
//            labelText: 'Email Address',
//            errorText: snapshot.error,
//          ),
//        );
//      },
//    );
//  }
//
//  Widget passwordField(bloc) {
//    return StreamBuilder(
//      stream: bloc.password,
//      builder: (context, snapshot) {
//        return TextField(
//          onChanged: bloc.changePassword,
//          decoration: InputDecoration(
//              border: OutlineInputBorder(),
//              hintText: 'Must contain 8 characters',
//              labelText: 'Password',
//              errorText: snapshot.error
//          ),
//          obscureText: true,
//        );
//      },
//    );
//  }
//
//  Widget submitButton(bloc) {
//    return StreamBuilder(
//      stream: bloc.submitValid,
//      builder: (context, snapshot) {
//        return RaisedButton(
//          child: Text('Login'),
//          color: Color(0xffa78066),
//          textColor: Colors.white,
//          onPressed: snapshot.hasData
//              ? bloc.submit
//              : null,
//        );
//      },
//    );
//  }
//}


import 'dart:async';
import 'package:pbl/pages/home.dart';
import 'package:pbl/utils/auth_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pbl/utils/network_utils.dart';
import 'package:pbl/validators/email_validator.dart';
import 'package:pbl/components/error_box.dart';
import 'package:pbl/components/email_field.dart';
import 'package:pbl/components/password_field.dart';
import 'package:pbl/components/login_button.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences _sharedPreferences;
  bool _isError = false;
  bool _obscureText = true;
  bool _isLoading = false;
  TextEditingController _emailController, _passwordController;
  String _errorText, _emailError, _passwordError;

  @override
  void initState() {
    super.initState();
    _fetchSessionAndNavigate();
    _emailController = new TextEditingController();
    _passwordController = new TextEditingController();
  }

  _fetchSessionAndNavigate() async {
    _sharedPreferences = await _prefs;
    String authToken = AuthUtils.getToken(_sharedPreferences);
    print(authToken);
    if(authToken != null) {
//      Navigator.of(_scaffoldKey.currentContext)
//          .pushReplacementNamed(HomePage.routeName);
      Navigator.pushReplacement(_scaffoldKey.currentContext, MaterialPageRoute(builder: (context)=> HomePage()));
    }
  }

  _showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  _hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  _authenticateUser() async {
    _showLoading();
    if(_valid()) {
      var responseJson = await NetworkUtils.authenticateUser(
          _emailController.text, _passwordController.text
      );

      print(responseJson);

      if(responseJson == null) {
        NetworkUtils.showSnackBar(_scaffoldKey, 'Something went wrong!');
      } else if(responseJson == 'NetworkError') {
        NetworkUtils.showSnackBar(_scaffoldKey, 'NetworkError');
      } else if(responseJson['errors'] != null) {
        NetworkUtils.showSnackBar(_scaffoldKey, 'Invalid Email/Password');
      } else {
        AuthUtils.insertDetails(_sharedPreferences, responseJson);
        /**
         * Removes stack and start with the new page.
         * In this case on press back on HomePage app will exit.
         * **/
        Navigator.of(_scaffoldKey.currentContext)
            .pushReplacementNamed(HomePage.routeName);
      }
      _hideLoading();
    } else {
      setState(() {
        _isLoading = false;
        _emailError;
        _passwordError;
      });
    }
  }
  _valid() {
    bool valid = true;
    if(_emailController.text.isEmpty) {
      valid = false;
      _emailError = "Email can't be blank!";
    } else if(!_emailController.text.contains(EmailValidator.regex)) {
      valid = false;
      _emailError = "Enter valid email!";
    }
    if(_passwordController.text.isEmpty) {
      valid = false;
      _passwordError = "Password can't be blank!";
    } else if(_passwordController.text.length < 6) {
      valid = false;
      _passwordError = "Password is invalid!";
    }
    return valid;
  }
  Widget _loginScreen() {
    return new Container(
      child: new ListView(
        padding: const EdgeInsets.only(
            top: 100.0,
            left: 16.0,
            right: 16.0
        ),
        children: <Widget>[
          Image.asset('assets/logo.png'),
          new ErrorBox(
              isError: _isError,
              errorText: _errorText
          ),
          new EmailField(
              emailController: _emailController,
              emailError: _emailError
          ),
          new PasswordField(
            passwordController: _passwordController,
            obscureText: _obscureText,
            passwordError: _passwordError,
            togglePassword: _togglePassword,
          ),
          new LoginButton(onPressed: _authenticateUser)
        ],
      ),
    );
  }
  _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  Widget _loadingScreen() {
    return new Container(
        margin: const EdgeInsets.only(top: 100.0),
        child: new Center(
            child: new Column(
              children: <Widget>[
                new CircularProgressIndicator(
                    strokeWidth: 4.0
                ),
                new Container(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    'Please Wait',
                    style: new TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 16.0
                    ),
                  ),
                )
              ],
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        body: _isLoading ? _loadingScreen() : _loginScreen()
    );
  }
}
