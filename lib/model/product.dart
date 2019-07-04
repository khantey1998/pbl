import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Product {
  String keyword;
  int id;
  String detail;
  String productName;
  int stock;
  double unitPrice;
  String productUrl;

  Product({this.keyword,this.id,this.detail, this.productName, this.productUrl, this.stock});
  factory Product.fromJson(Map<String, dynamic> parsedJson) {
    return Product(
        keyword: parsedJson['keyword'] as String,
        id: parsedJson['id'],
        detail: parsedJson['detail'] as String,
        productName: parsedJson['name'] as String,
        productUrl: parsedJson['image_url'],
        stock: parsedJson['stock']
    );
  }
}



//  static List<Product> products;
//  static Future loadProducts() async {
//    try {
//      products = List<Product>();
//      String jsonString = await rootBundle.loadString('assets/products.json');
////      http.Response response = await http.get(
////        Uri.encodeFull("http://10.0.2.2:8000/api/products"),
////        headers: {
////          "Accepts": "application/json"
////        }
////      );
//      Map parsedJson = json.decode(jsonString);
//      var categoryJson = parsedJson['products'] as List;
//      for (int i = 0; i < categoryJson.length; i++) {
//        products.add( Product.fromJson(categoryJson[i]));
//      }
////      final data = json.decode(response.body);
////      products = data.map((j) => Product.fromJson(j)).toList();
//////      print(products);
//    } catch (e) {
//      print(e);
//    }
//  }


//import 'package:flutter/material.dart';
//import 'dart:convert';
//import 'package:flutter/services.dart';
//import 'package:flutter/cupertino.dart';
//
//class Product extends StatelessWidget{
//  String keyword;
//  int id;
//  String autocompleteTerm;
//  String productName;
//  int amount;
//  double unitPrice;
//  String productUrl;
//
//  Product({this.keyword,this.id,this.autocompleteTerm, this.productName, this.productUrl});
//  factory Product.fromJson(Map<String, dynamic> parsedJson) {
//    return Product(
//        keyword: parsedJson['keyword'] as String,
//        id: parsedJson['id'],
//        autocompleteTerm: parsedJson['autocompleteTerm'] as String,
//        productName: parsedJson['productName'] as String,
//        productUrl: parsedJson['productUrl']
//    );
//  }
//  @override
//  Widget build(BuildContext context) {
//    return GestureDetector(
//      onTap: (){
//        showDialog(
//          context: context,
//          barrierDismissible: false,
//          builder: (BuildContext context){
//            return CupertinoAlertDialog(
//              title: Row(
//                children: <Widget>[
//                  Text(this.productName),
//                  Icon(
//                    Icons.add,
//                    color: Color(0xffa78066),
//                  ),
//                ],
//              ),
//              content: Material(
//                child: Column(
//                  children: <Widget>[
//                    TextField(
//                      style: TextStyle(color: Colors.black45),
//                      keyboardType: TextInputType.text,
//                      cursorColor: Color(0xffa78066),
//                      decoration: InputDecoration(
//                        labelText: 'Name',
//                        labelStyle: TextStyle(
//                          color: Colors.black45,
//                        ),
//                        focusedBorder: OutlineInputBorder(
//                          borderSide: BorderSide(color: Colors.white),
//                          borderRadius: BorderRadius.circular(20),
//                        ),
//                        enabledBorder: OutlineInputBorder(
//                          borderSide: BorderSide(color: Colors.white),
//                          borderRadius: BorderRadius.circular(20),
//                        ),
//                        border: OutlineInputBorder(
//                          borderSide: BorderSide(color: Colors.white),
//                          borderRadius: BorderRadius.circular(20),
//                        ),
//                      ),
//                    ),
//                    TextField(
//                      style: TextStyle(color: Colors.black45),
//                      keyboardType: TextInputType.phone,
//                      cursorColor: Color(0xffa78066),
//                      decoration: InputDecoration(
//                        labelText: 'Phone',
//                        labelStyle: TextStyle(
//                          color: Colors.black45,
//                        ),
//                        focusedBorder: OutlineInputBorder(
//                          borderSide: BorderSide(color: Colors.white),
//                          borderRadius: BorderRadius.circular(20),
//                        ),
//                        enabledBorder: OutlineInputBorder(
//                          borderSide: BorderSide(color: Colors.white),
//                          borderRadius: BorderRadius.circular(20),
//                        ),
//                        border: OutlineInputBorder(
//                          borderSide: BorderSide(color: Colors.white),
//                          borderRadius: BorderRadius.circular(20),
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              actions: <Widget>[
//                FlatButton(
//                  onPressed: (){
//                    Navigator.of(context).pop();
//                  },
//                  child: Text("Cancel"),
//                ),
//                FlatButton(
//                  onPressed: (){
//                    Navigator.of(context).pop();
//                  },
//                  child: Text("OK"),
//                ),
//              ],
//            );
//          },
//        );
//      },
//      child: ListTile(
//        title: Text(this.productName),
//        leading: CircleAvatar(
//          backgroundImage: AssetImage(this.productUrl),
//        ),
//      ),
//    );
//  }
//}
//class ProductViewModel{
//  static List<Product> products;
//  static Future loadProducts() async {
//    try {
//      products = new List<Product>();
//      String jsonString = await rootBundle.loadString('assets/products.json');
//      Map parsedJson = json.decode(jsonString);
//      var categoryJson = parsedJson['products'] as List;
//      for (int i = 0; i < categoryJson.length; i++) {
//        products.add( Product.fromJson(categoryJson[i]));
//      }
//    } catch (e) {
//      print(e);
//    }
//  }
//}