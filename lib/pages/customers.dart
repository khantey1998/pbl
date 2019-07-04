import 'package:flutter/material.dart';
import 'package:pbl/model/customer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';

class CustomerListsPage extends StatefulWidget{
  //CustomerListsPage({Key key}) : super(key: key);
  @override
  _SearchListState createState() => _SearchListState();
}
class _SearchListState extends State<CustomerListsPage>{

  List<Customer> list = List();
  var isLoading = false;
  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get("http://10.0.2.2:8000/api/customers");
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new Customer.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load Customers');
    }
  }

  @override
  void initState() {
    _fetchData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text("Products in Stock"),
//      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: Row(
                        children: <Widget>[
                          Text(list[index].name),
                        ],
                      ),
                      content: Material(
                        child: Column(
                          children: <Widget>[
                            TextField(
                              style: TextStyle(color: Colors.black45),
                              keyboardType: TextInputType.text,
                              cursorColor: Color(0xffa78066),
                              decoration: InputDecoration(
                                labelText: 'Name',
                                labelStyle: TextStyle(
                                  color: Colors.black45,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancel"),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                  });
            },
            contentPadding: EdgeInsets.all(10.0),
            title: Text(list[index].name),
            trailing: Text(list[index].address),
          );

        },
      ),
    );
  }
}

//import 'package:flutter/material.dart';
//import 'package:pbl/model/customer.dart';
//
//class CustomerListsPage extends StatefulWidget {
//  CustomerListsPage({Key key}) : super(key: key);
//  @override
//  _SearchListState createState() => _SearchListState();
//}
//
//class _SearchListState extends State<CustomerListsPage> {
//  Widget appBarTitle = Text(
//    "Customers",
//    style: TextStyle(color: Colors.white),
//  );
//  Icon actionIcon = Icon(
//    Icons.search,
//    color: Colors.white,
//  );
//  final key = GlobalKey<ScaffoldState>();
//  final TextEditingController _searchQuery = TextEditingController();
//  List<Customer> _list;
//  bool _isSearching;
//  String _searchText = "";
//
//  _SearchListState() {
//    _searchQuery.addListener(() {
//      if (_searchQuery.text.isEmpty) {
//        setState(() {
//          _isSearching = false;
//          _searchText = "";
//        });
//      } else {
//        setState(() {
//          _isSearching = true;
//          _searchText = _searchQuery.text;
//        });
//      }
//    });
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    _isSearching = false;
//    init();
//  }
//
//  void init() {
//    _list = List();
//
//    Customer cus2 =
//        Customer.createCustomer('monyneth', 'assets/default.png', '', '', 1);
//    Customer cus3 = Customer.createCustomer('dalin', 'assets/default.png', '', '', 2);
//    Customer cus4 =
//        Customer.createCustomer('vicheka', 'assets/default.png', '', '', 3);
//    Customer cus5 = Customer.createCustomer('leo', 'assets/default.png', '', '', 4);
//
//    _list.add(cus2);
//    _list.add(cus3);
//    _list.add(cus4);
//    _list.add(cus5);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      key: key,
//      appBar: buildBar(context),
//      body: ListView(
//        padding: EdgeInsets.symmetric(vertical: 8.0),
//        children: _isSearching ? _buildSearchList() : _buildList(),
//      ),
//    );
//  }
//
//  List<Customer> _buildList() {
//    return _list
//        .map(
//          (customer) => Customer.createCustomer(
//              customer.username,
//              customer.profileUrl,
//              customer.autocompleteTerm,
//              customer.keyword,
//              customer.id),
//        )
//        .toList();
//  }
//
//  List<Customer> _buildSearchList() {
//    if (_searchText.isEmpty) {
//      return _list
//          .map(
//            (customer) => Customer.createCustomer(
//                customer.username,
//                customer.profileUrl,
//                customer.autocompleteTerm,
//                customer.keyword,
//                customer.id),
//          )
//          .toList();
//    } else {
//      List<Customer> _searchList = List();
//      for (int i = 0; i < _list.length; i++) {
//        //String name = _list.elementAt(i).username;
//        Customer customer = _list.elementAt(i);
//        if (customer.username
//            .toLowerCase()
//            .contains(_searchText.toLowerCase())) {
//          print(_searchList);
//          _searchList.add(customer);
//
//          print(_searchList);
//        }
//      }
//      return _searchList
//          .map(
//            (searchCustomer) => Customer.createCustomer(
//                searchCustomer.username,
//                searchCustomer.profileUrl,
//                searchCustomer.autocompleteTerm,
//                searchCustomer.keyword,
//                searchCustomer.id),
//          )
//          .toList();
//    }
//  }
//
//  Widget buildBar(BuildContext context) {
//    return AppBar(
//      title: appBarTitle,
//      centerTitle: true,
//      actions: <Widget>[
//        IconButton(
//          icon: actionIcon,
//          onPressed: () {
//            setState(() {
//              if (this.actionIcon.icon == Icons.search) {
//                this.actionIcon = Icon(
//                  Icons.close,
//                  color: Colors.white,
//                );
//                this.appBarTitle = TextField(
//                  controller: _searchQuery,
//                  style: TextStyle(
//                    color: Colors.white,
//                  ),
//                  decoration: InputDecoration(
//                    //prefixIcon: Icon(Icons.search, color: Colors.white),
//                    hintText: "Search...",
//                    hintStyle: TextStyle(color: Colors.white),
//                  ),
//                );
//                _handleSearchStart();
//              } else {
//                _handleSearchEnd();
//              }
//            });
//          },
//        ),
//      ],
//    );
//  }
//
//  void _handleSearchStart() {
//    setState(() {
//      _isSearching = true;
//    });
//  }
//
//  void _handleSearchEnd() {
//    setState(() {
//      this.actionIcon = Icon(
//        Icons.search,
//        color: Colors.white,
//      );
//      this.appBarTitle = Text(
//        "Customers",
//        style: TextStyle(color: Colors.white),
//      );
//      _isSearching = false;
//      _searchQuery.clear();
//    });
//  }
//}
////
////class ChildItem extends StatelessWidget {
////  final String name;
////  final String url;
////  ChildItem(this.name, this.url);
////  @override
////  Widget build(BuildContext context) {
////    return ListTile(
////      title: Text(this.name), leading: Image.asset(url, width: 50,),
////    );
////  }
////}