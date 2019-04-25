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

  void _loadData() async{
    ProductViewModel.loadProducts();
    await CustomerViewModel.loadCustomers();
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
      appBar: AppBar(
        title: Text('Order'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
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
                  itemSubmitted: (item){
                    setState(() =>
                    productTextField.textField.controller.text = item.autocompleteTerm
                    );
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
                  itemSubmitted: (item){
                    setState(() =>
                    customerTextField.textField.controller.text = item.autocompleteTerm
                    );
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
              ],
            )
          ],
        ),
      ),
    );
  }
}
