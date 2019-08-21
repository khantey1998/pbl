import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:pbl/model/product.dart';
import 'package:pbl/model/customer.dart';
import 'package:pbl/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:pbl/components/input_field.dart';
import 'package:pbl/components/error_box.dart';
import 'package:pbl/model/order_item.dart';
import 'package:pbl/model/order.dart';

class Order extends StatefulWidget {
  //Order({Key key}) : super(key: key);
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  List<Product> orderedProducts = List();
  List<OrderItem> orderItems = List();
  List<Product> allProducts = List();
  List<Customer> allCustomers = List();
  List<Widget> orderedProductList = List();

  bool productListIsEmpty = true;
  bool _isError = false;
  _OrderState();

  String customer;
  int customerID;
  int saleID = 1;


  AutoCompleteTextField productTextField;
  AutoCompleteTextField customerTextField;
  GlobalKey<AutoCompleteTextFieldState<Product>> productKey = GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<Customer>> customerKey = GlobalKey();
  TextEditingController controller = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  String _amountError, _errorText;

  String customerUrl = "http://pdo.pblcnt.com/api/customers";
  String productUrl = "http://pdo.pblcnt.com/api/products";
  String orderUrl = "http://pdo.pblcnt.com/api/orders";

  var isLoading = false;
  Future _fetchProducts() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(productUrl);
    final customerRes = await http.get(customerUrl);
    if (response.statusCode == 200 && customerRes.statusCode == 200) {
      allProducts = (json.decode(response.body) as List)
          .map((data) => new Product.fromJson(data))
          .toList();
      allCustomers = (json.decode(customerRes.body) as List)
          .map((data) => Customer.fromJson(data))
          .where((customer) => customer.saleID == saleID)
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load Product: ${response.statusCode}');
    }
  }

  Future<OrderModel> createOrder(String url, {String body}) {
    return http.post(Uri.encodeFull(url), body: body, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json"
    }).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        print(body);
        throw new Exception("Error Code: $statusCode");
      }
      return OrderModel.fromJson(json.decode(response.body));
    });
  }

  @override
  void initState() {
    orderedProducts = List();
    _fetchProducts();
    _valid();

    super.initState();
  }

  _valid() {
    bool valid = true;
    if (amountController.text.isEmpty) {
      valid = false;
      _amountError = "Required !";
    }
    return valid;
  }

  Map<int, int> quantities = {};

  void takeNumber(String text, int itemId) {
    try {
      int number = int.parse(text);
      quantities[itemId] = number;
      print(quantities);
    } on FormatException {}
  }
//  Widget singleItemList(int index) {
//    Product product = orderedProducts[index];
//
//  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Order'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    customerTextField = AutoCompleteTextField<Customer>(
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                      decoration: InputDecoration(
                        suffixIcon: Container(
                          width: 85.0,
                          height: 60.0,
                        ),
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                        filled: true,
                        hintText: 'Please select vendor name',
                        hintStyle: TextStyle(color: Colors.black12),
                      ),
                      itemBuilder: (context, item) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              item.name,
                              style: TextStyle(fontSize: 16),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15),
                            ),
                          ],
                        );
                      },
                      itemFilter: (item, query) {
                        return item.name
                            .toLowerCase()
                            .startsWith(query.toLowerCase());
                      },
                      itemSorter: (a, b) {
                        return a.name.compareTo(b.name);
                      },
                      itemSubmitted: (item) {
                        setState(() {
                          customerTextField.textField.controller.text =
                              item.name;
                          customerID = item.id;
                          //customerName = Text(item.username);
                        });
                      },
                      onFocusChanged: (hasFocus) {},
                      clearOnSubmit: false,
                      key: customerKey,
                      suggestions: allCustomers,
                    ),
                    productTextField = AutoCompleteTextField<Product>(
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                      decoration: InputDecoration(
                        suffixIcon: Container(
                          width: 85.0,
                          height: 60.0,
                        ),
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                        filled: true,
                        hintText: 'Enter Product Name',
                        hintStyle: TextStyle(color: Colors.black12),
                      ),
                      itemBuilder: (context, item) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              item.productName,
                              style: TextStyle(fontSize: 16),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15),
                            ),
                            Text(
                              item.productName,
                            ),
                          ],
                        );
                      },
                      itemFilter: (item, query) {
                        return item.productName
                            .toLowerCase()
                            .startsWith(query.toLowerCase());
                      },
                      itemSorter: (a, b) {
                        return a.productName.compareTo(b.productName);
                      },
                      itemSubmitted: (item) {
                        var orderItem = OrderItem();
                        orderItems.add(orderItem);
                        orderedProducts.add(item);
                        orderItem.productID = item.id;
                        orderItem.name = item.productName;
                        productTextField.textField.controller.text =
                            item.productName;
                        productListIsEmpty = false;
                        setState(() {


//                          orderedProductList.add(
//                            Card(
//                              child: Column(
//                                mainAxisAlignment: MainAxisAlignment.center,
//                                children: <Widget>[
////                            Image.asset(
////                              item.productUrl,
////                              width: 150,
////                            ),
//                                  Text(item.productName),
//                                ],
//                              ),
//                            ),
//                          );

                        });
                      },
                      onFocusChanged: (hasFocus) {},
                      suggestions: allProducts,
                      clearOnSubmit: true,
                      key: productKey,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                productListIsEmpty
                    ? Expanded(
                        child: Center(
                          child: Text("Select Products"),
                        ),
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                              columns: [
                                DataColumn(
                                  label: Text(
                                    "Products*",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "Qty*",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "Price*",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                              rows: orderItems
                                  .map(
                                    (product) => DataRow(
                                          cells: [
                                            DataCell(
                                              Text(product.name),
                                            ),
                                            DataCell(
                                              TextField(
                                                onChanged: (text){
                                                  product.unitPrice = int.parse(text);
                                                },
                                              ),
                                            ),
                                            DataCell(
                                              TextField(
                                                onChanged: (text){
                                                  product.quantity = int.parse(text);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                  )
                                  .toList()),
                        ),
//            child: ListView.builder(
//                shrinkWrap: true,
//                itemCount: orderedProducts.length,
//                itemBuilder: (BuildContext context, int index) {
//                  return Row(
//                    children: [
//                      Flexible(flex: 3,child: Text(orderedProducts[index].productName)),
//                      Flexible(flex: 2,child: SizedBox(width: 10,),),
//                      Flexible(
//                        flex: 1,
//                        child: TextFormField(
//                          decoration: const InputDecoration(
//                            labelText: 'Qty *',
//
//                          ),
//                          onSaved: (String value) {
//                            // This optional block of code can be used to run
//                            // code when the user saves the form.
//                            takeNumber(value, orderedProducts[index].id);
//                          },
//                          inputFormatters:[WhitelistingTextInputFormatter.digitsOnly],
//                          validator: (String value) {
//                            return value.contains('@') ? 'Do not use the @ char.' : null;
//                          },
//                          keyboardType: TextInputType.number,
//                        ),
////                        child: TextField(
////                          keyboardType: TextInputType.number,
////                          onChanged: (text) {
////                            takeNumber(text, orderedProducts[index].id);
////                          },
////                          decoration: InputDecoration(
////                            labelText: "Qty",
////                          ),
////                        ),
//                      ),
//                    ],
//
//                  );
////                  return Row(
////                    mainAxisSize: MainAxisSize.min,
////                    children: <Widget>[
////                      Flexible(child: ErrorBox(
////                          isError: _isError,
////                          errorText: _errorText
////                      ),),
////                      Flexible(child: Text(orderedProducts[index].productName),),
////                      Flexible(child: InputField(
////                        inputController: amountController,
////                        inputError: _amountError,
////                      ),)
////                    ],
////                  );
////                  return GestureDetector(
////                    child: orderedProductList[index],
////                    onTap: (){
////                      showDialog(
////                        context: context,
////                        barrierDismissible: false,
////                        builder: (BuildContext context){
////                          return CupertinoAlertDialog(
////                            title: Row(
////                              children: <Widget>[
////                                Text(orderedProducts[index].productName),
////                                Icon(
////                                  Icons.add,
////                                  color: Color(0xffa78066),
////                                ),
////                              ],
////                            ),
////                            content: Material(
////                              child: Column(
////                                children: <Widget>[
////                                  TextField(
////                                    controller: amountController,
////                                    style: TextStyle(color: Colors.black45),
////                                    keyboardType: TextInputType.number,
////                                    cursorColor: Color(0xffa78066),
////                                    decoration: InputDecoration(
////                                      labelText: 'Amount',
////                                      labelStyle: TextStyle(
////                                        color: Colors.black45,
////                                      ),
////                                      focusedBorder: OutlineInputBorder(
////                                        borderSide: BorderSide(color: Colors.white),
////                                        borderRadius: BorderRadius.circular(20),
////                                      ),
////                                      enabledBorder: OutlineInputBorder(
////                                        borderSide: BorderSide(color: Colors.white),
////                                        borderRadius: BorderRadius.circular(20),
////                                      ),
////                                      border: OutlineInputBorder(
////                                        borderSide: BorderSide(color: Colors.white),
////                                        borderRadius: BorderRadius.circular(20),
////                                      ),
////
////                                    ),
////                                  ),
////                                  TextField(
////                                    controller: priceController,
////                                    style: TextStyle(color: Colors.black45),
////                                    keyboardType: TextInputType.number,
////                                    cursorColor: Color(0xffa78066),
////                                    decoration: InputDecoration(
////                                      labelText: 'Unit Price',
////                                      labelStyle: TextStyle(
////                                        color: Colors.black45,
////                                      ),
////                                      focusedBorder: OutlineInputBorder(
////                                        borderSide: BorderSide(color: Colors.white),
////                                        borderRadius: BorderRadius.circular(20),
////                                      ),
////                                      enabledBorder: OutlineInputBorder(
////                                        borderSide: BorderSide(color: Colors.white),
////                                        borderRadius: BorderRadius.circular(20),
////                                      ),
////                                      border: OutlineInputBorder(
////                                        borderSide: BorderSide(color: Colors.white),
////                                        borderRadius: BorderRadius.circular(20),
////                                      ),
////                                    ),
////                                  ),
////                                ],
////                              ),
////                            ),
////                            actions: <Widget>[
////                              FlatButton(
////                                onPressed: (){
////                                  Navigator.of(context).pop();
////                                },
////                                child: Text("Cancel"),
////                              ),
////                              FlatButton(
////                                onPressed: (){
////                                  int amount = int.parse(amountController.text);
////                                  int price = int.parse(priceController.text);
////                                  OrderItem orderItem = OrderItem(productID: orderedProducts[index].id, quantity: amount, unitPrice: price);
////                                  orderItem.toMap();
////                                  orderItems.add(orderItem);
////                                  Navigator.of(context).pop();
////                                },
////                                child: Text("OK"),
////                              ),
////                            ],
////                          );
////                        },
////                      );
////                    },
////                  );
//                }),
                      ),
                Container(
                  child: TextField(
                    controller: noteController,
                    style: TextStyle(color: Colors.black45),
                    keyboardType: TextInputType.text,
                    cursorColor: Color(0xffa78066),
                    decoration: InputDecoration(
                      labelText: 'Note',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: FlatButton(
                    color: Color(0xffa78066),
                    disabledColor: Colors.grey,
                    onPressed: (){
//                      orderItems.add(orderItem);
//                      setState(() {});
                      OrderModel newOrder = OrderModel(
                          customerID: 1,
                          status: "incoming",
                          orderItems: orderItems,
                          note: noteController.text,
                          saleID: saleID);
                      print(newOrder.toMap());
                    },
//                    onPressed: () async {
//                      orderItems.add(orderItem);
//                      setState(() {});
//                      OrderModel newOrder = OrderModel(
//                          customerID: 1,
//                          status: "incoming",
//                          orderItems: orderItems,
//                          note: noteController.text,
//                          saleID: saleID);
//                      print(newOrder.toMap());
//                      await createOrder(orderUrl,
//                          body: json.encode(newOrder.toMap()));
//
//                      showDialog(
//                          context: context,
//                          barrierDismissible: false,
//                          builder: (BuildContext context) {
//                            return CupertinoAlertDialog(
//                              actions: <Widget>[
//                                FlatButton(
//                                  onPressed: () {
//                                    Route route = MaterialPageRoute(
//                                        builder: (context) => HomePage());
//                                    Navigator.pushReplacement(context, route);
//                                  },
//                                  child: Text("OK"),
//                                ),
//                              ],
//                              content: Material(
//                                child: Center(
//                                  child: Text("Order has been sent!"),
//                                ),
//                              ),
//                            );
//                          });
//                    },
                    child: Text(
                      "Order",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
