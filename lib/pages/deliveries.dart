import 'package:flutter/material.dart';
import 'package:pbl/model/delivery.dart';

class DeliveryStatus extends StatefulWidget{
  DeliveryStatus({Key key}) : super(key: key);
  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<DeliveryStatus>{
  List<Delivery> _list;
  final key = GlobalKey<ScaffoldState>();

  void _loadData() async {
    DeliveryViewModel.loadDeliveries();
  }
  @override
  void initState() {
    _loadData();
    _list = List();
    _list = DeliveryViewModel.deliveries;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: key,
      appBar: AppBar(title: Text("Delivery"),),
      body: Column(
        children: <Widget>[
          dataBody()
        ],
      ),
    );
  }

  SingleChildScrollView dataBody(){

        return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(

                  columns: [
                    DataColumn(label: Text("Clients", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),)),
                    DataColumn(label: Text("Addresses", style: TextStyle(fontWeight: FontWeight.bold,  fontSize: 14))),
                    DataColumn(label: Text("Status", style: TextStyle(fontWeight: FontWeight.bold,  fontSize: 14)))
                  ],
                  rows: _list.map((delivery)=>DataRow(cells: [
                    DataCell(Text(delivery.customer)),
                    DataCell(Text(delivery.address)),
                    DataCell(Text(delivery.status))
                  ])).toList()
                  ),

        );

    }
}
