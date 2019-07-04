import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:pbl/model/product.dart';
import 'package:pbl/model/customer.dart';
import 'package:pbl/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Order extends StatefulWidget {
  //Order({Key key}) : super(key: key);
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  List<Product> orderedProducts;
  List<Widget> myList;
  _OrderState();

  Text customerName;
  AutoCompleteTextField productTextField;
  AutoCompleteTextField customerTextField;
  GlobalKey<AutoCompleteTextFieldState<Product>> productKey = GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<Customer>> customerKey = GlobalKey();
  TextEditingController controller = TextEditingController();

//  void _loadData() async {
//    await CustomerViewModel.loadCustomers();
//    //await ProductViewModel.loadProducts();
//  }

  @override
  void initState() {
    customerName = Text('Customers:');
    myList = List();
    orderedProducts = List();
    super.initState();
  }

  void _showToast() {
    Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Order'),
      ),

      body: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
//              customerTextField = AutoCompleteTextField<Customer>(
//                style: TextStyle(color: Colors.black, fontSize: 16.0),
//                decoration: InputDecoration(
//                  suffixIcon: Container(
//                    width: 85.0,
//                    height: 60.0,
//                  ),
//                  contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
//                  filled: true,
//                  hintText: 'Enter Customer Name',
//                  hintStyle: TextStyle(color: Colors.black),
//                ),
//                itemBuilder: (context, item) {
//                  return Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Text(
//                        item.autocompleteTerm,
//                        style: TextStyle(fontSize: 16),
//                      ),
//                      Padding(
//                        padding: EdgeInsets.all(15),
//                      ),
//                      Text(
//                        item.username,
//                      ),
//                    ],
//                  );
//                },
//                itemFilter: (item, query) {
//                  return item.autocompleteTerm
//                      .toLowerCase()
//                      .startsWith(query.toLowerCase());
//                },
//                itemSorter: (a, b) {
//                  return a.autocompleteTerm.compareTo(b.autocompleteTerm);
//                },
//                itemSubmitted: (item) {
//                  setState(() {
//                    customerTextField.textField.controller.text =
//                        item.autocompleteTerm;
//                    //customerName = Text(item.username);
//                  });
//                },
//                onFocusChanged: (hasFocus) {},
//                clearOnSubmit: false,
//                key: customerKey,
//                suggestions: CustomerViewModel.customers,
//              ),
//              productTextField = AutoCompleteTextField<Product>(
//                style: TextStyle(color: Colors.black, fontSize: 16.0),
//                decoration: InputDecoration(
//                  suffixIcon: Container(
//                    width: 85.0,
//                    height: 60.0,
//                  ),
//                  contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
//                  filled: true,
//                  hintText: 'Enter Product Name',
//                  hintStyle: TextStyle(color: Colors.black),
//                ),
//                itemBuilder: (context, item) {
//                  return Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Text(
//                        item.autocompleteTerm,
//                        style: TextStyle(fontSize: 16),
//                      ),
//                      Padding(
//                        padding: EdgeInsets.all(15),
//                      ),
//                      Text(
//                        item.productName,
//                      ),
//                    ],
//                  );
//                },
//                itemFilter: (item, query) {
//                  return item.autocompleteTerm
//                      .toLowerCase()
//                      .startsWith(query.toLowerCase());
//                },
//                itemSorter: (a, b) {
//                  return a.autocompleteTerm.compareTo(b.autocompleteTerm);
//                },
//                itemSubmitted: (item) {
//                  setState(() {
//                    orderedProducts.add(item);
//                    productTextField.textField.controller.text = item.autocompleteTerm;
//                    myList.add(
//                      Card(
//                        child: Column(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            Image.asset(
//                              item.productUrl,
//                              width: 150,
//                            ),
//                            Text(item.productName),
//                          ],
//                        ),
//                      ),
//                    );
//                  });
//                },
//                onFocusChanged: (hasFocus) {},
//                suggestions: ProductViewModel.products,
//                clearOnSubmit: true,
//                key: productKey,
//              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: GridView.builder(
                itemCount: myList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: myList[index],
                    onTap: (){
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context){
                          return CupertinoAlertDialog(
                            title: Row(
                              children: <Widget>[
                                Text(orderedProducts[index].productName),
                                Icon(
                                  Icons.add,
                                  color: Color(0xffa78066),
                                ),
                              ],
                            ),
                            content: Material(
                              child: Column(
                                children: <Widget>[
                                  TextField(
                                    style: TextStyle(color: Colors.black45),
                                    keyboardType: TextInputType.number,
                                    cursorColor: Color(0xffa78066),
                                    decoration: InputDecoration(
                                      labelText: 'Amount',
                                      labelStyle: TextStyle(
                                        color: Colors.black45,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                  TextField(
                                    style: TextStyle(color: Colors.black45),
                                    keyboardType: TextInputType.number,
                                    cursorColor: Color(0xffa78066),
                                    decoration: InputDecoration(
                                      labelText: 'Unit Price',
                                      labelStyle: TextStyle(
                                        color: Colors.black45,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                                child: Text("Cancel"),
                              ),
                              FlatButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                }),
          ),
          Container(
            width: 350,
            child: FlatButton(
              color: Color(0xffa78066),
              disabledColor: Colors.grey,
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context){
                    return CupertinoAlertDialog(
                      actions: <Widget>[
                        FlatButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => HomePage(),
                              ),
                            );
                          },
                          child: Text("OK"),
                        ),
                      ],
                      content: Material(
                        child: Center(child: Text("Order has been sent!"),),
                      ),
                    );
                  }
                );
              },
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
