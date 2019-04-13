import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:pbl/model/product.dart';

class Order extends StatefulWidget{
  Order({Key key}) : super(key:key);
  @override
  _OrderState createState() => _OrderState();
}
class _OrderState extends State<Order>{

  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  List<Product> _list;
  bool _isSearching;
  String _searchText = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}