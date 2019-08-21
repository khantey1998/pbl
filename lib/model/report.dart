import 'package:pbl/model/order_item.dart';
class Report {
  String customer;
  int totalPrice;
  List<OrderItem> orderItems;
  String orderDate;
  int id;
  String status;
  String address;
  String contactNo;

  Report({this.customer, this.orderItems, this.totalPrice, this.orderDate, this.id, this.status, this.address,this.contactNo});
  factory Report.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['order_items'] as List;
    //print(list.runtimeType);
    List<OrderItem> itemList = list.map((i) => OrderItem.fromJson(i)).toList();
    return Report(
        customer: parsedJson['customer'] as String,
        orderItems: itemList,
        totalPrice: parsedJson['total_price'],
        orderDate: parsedJson['order_date'],
        id: parsedJson['id'],
        status: parsedJson['status'],
        address: parsedJson['address'],
        contactNo: parsedJson['contact_no'] as String
        );
  }
  Map toMap(){
    var map = Map<String, dynamic>();
    map["customer"] = customer;
    return map;
  }
}