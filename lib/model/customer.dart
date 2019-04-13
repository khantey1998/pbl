import 'package:flutter/material.dart';

class Customer extends StatelessWidget{

  final String username;
  final String profileUrl;
  String email;
  int phoneNumber;

  Customer(this.username, this.profileUrl);
  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(this.username), leading: Image.asset(profileUrl, width: 50,),);
  }
}