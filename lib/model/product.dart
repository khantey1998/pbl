import 'dart:convert';
import 'package:flutter/services.dart';

class Product{
  String keyword;
  int id;
  String autocompleteTerm;
  String productName;
  int amount;
  double unitPrice;

  Product({this.keyword,this.id,this.autocompleteTerm, this.productName});
  factory Product.fromJson(Map<String, dynamic> parsedJson) {
    return Product(
        keyword: parsedJson['keyword'] as String,
        id: parsedJson['id'],
        autocompleteTerm: parsedJson['autocompleteTerm'] as String,
        productName: parsedJson['productName'] as String
    );
  }
}
class ProductViewModel{
  static List<Product> products;
  static Future loadProducts() async {
    try {
      products = new List<Product>();
      String jsonString = await rootBundle.loadString('assets/products.json');
      Map parsedJson = json.decode(jsonString);
      var categoryJson = parsedJson['products'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        products.add( Product.fromJson(categoryJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }
}