import 'package:flutter/material.dart';
import 'package:pbl/model/delivery.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DeliveryStatus extends StatefulWidget{
  DeliveryStatus({Key key}) : super(key: key);
  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<DeliveryStatus>{
  List<Delivery> _list;
  final key = GlobalKey<ScaffoldState>();

  var isLoading = false;
  String url = "http://pdo.pblcnt.com/api/orders";
  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
      _list = (json.decode(response.body) as List)
          .map((data) => Delivery.fromJson(data))
          .toList();


      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception(response.statusCode);
    }
  }
  @override
  void initState() {
    _list = List();
    _fetchData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: key,
      appBar: AppBar(title: Text("Delivery"),),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          :Container(
        child:
          dataBody()
        ,
      ),
    );
  }

  SingleChildScrollView dataBody(){

        return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(

                  columns: [
                    DataColumn(label: Text("Clients", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),)),
                    DataColumn(label: Text("Status", style: TextStyle(fontWeight: FontWeight.bold,  fontSize: 14)))
                  ],
                  rows: _list.map((delivery)=>DataRow(cells: [
                    DataCell(Text(delivery.customer)),
                    DataCell(Text(delivery.status))
                  ])).toList()
                  ),

        );

    }
}
