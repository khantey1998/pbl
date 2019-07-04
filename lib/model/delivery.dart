import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

class Delivery {
  String status;
  String customer;
  String address;
  Delivery({this.status,this.customer, this.address});
  factory Delivery.fromJson(Map<String, dynamic> parsedJson) {
    return Delivery(
        status: parsedJson['status'] as String,
        customer: parsedJson['customer'] as String,
        address: parsedJson['address'] as String
    );
  }

}
class DeliveryViewModel{
  static List<Delivery> deliveries;
  static Future loadDeliveries() async {
    try {
      deliveries = new List<Delivery>();
      String jsonString = await rootBundle.loadString('assets/deliveries.json');
      Map parsedJson = json.decode(jsonString);
      var categoryJson = parsedJson['deliveries'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        deliveries.add( Delivery.fromJson(categoryJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }
}