import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:pbl/model/product.dart';
import 'package:pbl/model/customer.dart';

class Order extends StatefulWidget {
//  Order({Key key}) : super(key: key);
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  _OrderState();

  AutoCompleteTextField productTextField;
  AutoCompleteTextField customerTextField;
  GlobalKey<AutoCompleteTextFieldState<Product>> key = GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<Customer>> customerKey = GlobalKey();
  TextEditingController controller = TextEditingController();

  void _loadData() async {
    CustomerViewModel.loadCustomers();
    await ProductViewModel.loadProducts();
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
//      appBar: AppBar(
//        title: Text('Order'),
//      ),
      body: Column(
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
                  contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                  filled: true,
                  hintText: 'Enter Customer Name',
                  hintStyle: TextStyle(color: Colors.black),
                ),
                itemSubmitted: (item) {
                  setState(() => customerTextField.textField.controller.text =
                      item.autocompleteTerm);
                },
                itemBuilder: (context, item) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        item.autocompleteTerm,
                        style: TextStyle(fontSize: 16),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                      ),
                      Text(
                        item.username,
                      ),
                    ],
                  );
                },
                itemFilter: (item, query) {
                  return item.autocompleteTerm
                      .toLowerCase()
                      .startsWith(query.toLowerCase());
                },
                itemSorter: (a, b) {
                  return a.autocompleteTerm.compareTo(b.autocompleteTerm);
                },
                suggestions: CustomerViewModel.customers,
                clearOnSubmit: false,
                key: customerKey,
              ),
              productTextField = AutoCompleteTextField<Product>(
                style: TextStyle(color: Colors.black, fontSize: 16.0),
                decoration: InputDecoration(
                  suffixIcon: Container(
                    width: 85.0,
                    height: 60.0,
                  ),
                  contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                  filled: true,
                  hintText: 'Enter Product Name',
                  hintStyle: TextStyle(color: Colors.black),
                ),
                itemSubmitted: (item) {
                  setState(() => productTextField.textField.controller.text =
                      item.autocompleteTerm);
                },
                itemBuilder: (context, item) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        item.autocompleteTerm,
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
                  return item.autocompleteTerm
                      .toLowerCase()
                      .startsWith(query.toLowerCase());
                },
                itemSorter: (a, b) {
                  return a.autocompleteTerm.compareTo(b.autocompleteTerm);
                },
                suggestions: ProductViewModel.products,
                clearOnSubmit: false,
                key: key,
              ),
            ],
          ),
          Expanded(
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 1,
              crossAxisCount: 2,
              children: <Widget>[
                Card(
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        "assets/stock.png",
                        width: 50,
                      ),
                      Text("First Poducts"),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        "assets/stock.png",
                        width: 50,
                      ),
                      Text("First Poducts"),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        "assets/stock.png",
                        width: 50,
                      ),
                      Text("First Poducts"),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        "assets/stock.png",
                        width: 50,
                      ),
                      Text("First Poducts"),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        "assets/stock.png",
                        width: 50,
                      ),
                      Text("First Poducts"),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        "assets/stock.png",
                        width: 50,
                      ),
                      Text("First Poducts"),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        "assets/stock.png",
                        width: 50,
                      ),
                      Text("First Poducts"),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        "assets/stock.png",
                        width: 50,
                      ),
                      Text("First Poducts"),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        "assets/stock.png",
                        width: 50,
                      ),
                      Text("First Poducts"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 350,
            child: FlatButton(
              color: Colors.red,
              disabledColor: Colors.grey,
              onPressed: () {
                /*...*/
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
