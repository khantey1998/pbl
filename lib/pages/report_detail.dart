import 'package:flutter/material.dart';
import 'package:pbl/model/report.dart';
import 'package:pbl/model/order_item.dart';

class ReportDetail extends StatelessWidget {
  // Declare a field that holds the Todo.
  final Report report;

  // In the constructor, require a Todo.
  ReportDetail({Key key, @required this.report}) : super(key: key);


  SingleChildScrollView dataBody() {

    List<OrderItem> orderItemList = report.orderItems;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(
              label: Text(
            "Product",
            style: new TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          )),
          DataColumn(
              label: Text(
            "Amount",
            style: new TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          )),
          DataColumn(
              label: Text(
                "Unit Price",
                style: new TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ))
        ],


          rows: orderItemList
              .map((orderItem) => DataRow(cells: [
            DataCell(Text(orderItem.name)),
            DataCell(Text(orderItem.quantity.toString())),
            DataCell(Text(orderItem.unitPrice.toString()))

          ]))
              .toList()
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String dateTime = report.orderDate;
    DateTime time = DateTime.parse(dateTime);
    // Use the Todo to create the UI.
    return Scaffold(
        appBar: AppBar(
          title: Text(report.customer),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                "Order ID: " + report.id.toString(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  "Order Date: ${time.day}/${time.month}/${time.year}"),
                            ],
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                          Text("Status: ${report.status}")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                "Customer: " + report.customer,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Contact Number: ${report.contactNo}"),
                            ],
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              "Delivery Address: " + report.address,
                            ),
                          ),
                        ],
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                "Order Information:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Container(
                                height: 1,
                                width: 120,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              dataBody(),
                            ],
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
