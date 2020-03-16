import 'package:pbl/model/order_item.dart';

class OrderModel {
  int customerID;
  int saleID;
  int id;
  int status;
  String note;
  List<OrderItem> orderItems;

  OrderModel({this.customerID, this.status, this.orderItems, this.note, this.saleID});

  factory OrderModel.fromJson(Map<String, dynamic> parsedJson) {
    return OrderModel(
        customerID: parsedJson['customer_id'],
        status: parsedJson['status'],
        orderItems: parsedJson['order_items'],
        note: parsedJson['note'] as String,
        saleID: parsedJson['sale_id']
    );
  }

  Map toMap(){
    var map = Map<String, dynamic>();
    map["customer_id"] = this.customerID;
    map["status"] = this.status;
    map["order_items"] = orderItems.map((a) => a.toMap()).toList();
    map["note"] = this.note;
    map["sale_id"] = this.saleID;
    return map;
  }

}