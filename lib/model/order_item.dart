class OrderItem{
  int productID;
  int quantity;
  int unitPrice;
  String name;

  OrderItem({this.productID, this.quantity, this.unitPrice, this.name});

  factory OrderItem.fromJson(Map<String, dynamic> parsedJson) {
    return OrderItem(
        productID: parsedJson['product_id'],
        quantity: parsedJson['quantity'],
        name: parsedJson['name'] as String,
        unitPrice: parsedJson['unit_price']
    );
  }
  Map toMap(){
    var map = Map<String, dynamic>();
    map["quantity"] = quantity;
    map["product_id"] = productID;
    map["unit_price"] = unitPrice;
    return map;
  }
}