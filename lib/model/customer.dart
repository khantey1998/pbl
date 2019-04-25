import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class Customer extends StatelessWidget{

  final String username;
  final String profileUrl;
  final String keyword;
  final String autocompleteTerm;
  final int id;
//  final int phoneNumber;
//  final String email;

  Customer({this.keyword,this.id,this.autocompleteTerm, this.username, this.profileUrl});
  Customer.createCustomer(this.username, this.profileUrl, this.autocompleteTerm, this.keyword, this.id);
  factory Customer.fromJson(Map<String, dynamic> parsedJson) {
    return Customer(
        keyword: parsedJson['keyword'] as String,
        id: parsedJson['id'],
        autocompleteTerm: parsedJson['autocompleteTerm'] as String,
        username: parsedJson['name'] as String
    );
  }
  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(this.username), leading: Image.asset(profileUrl, width: 50,),);
  }
}
class CustomerViewModel{
  static List<Customer> customers;
  static Future loadCustomers() async {
    try {
      customers = new List<Customer>();
      String jsonString = await rootBundle.loadString('assets/customers.json');
      Map parsedJson = json.decode(jsonString);
      var categoryJson = parsedJson['customers'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        customers.add( Customer.fromJson(categoryJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }
}