import 'package:flutter/material.dart';
import 'package:pbl/model/customer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';

class CustomerListsPage extends StatefulWidget {
  //CustomerListsPage({Key key}) : super(key: key);
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<CustomerListsPage> {
  int saleID = 1;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String url = "http://10.0.2.2:8000/api/customers";
  List<Customer> allCustomers = List();
  var isLoading = false;
  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(url);
    if (response.statusCode == 200) {
      allCustomers = (json.decode(response.body) as List)
          .map((data) => Customer.fromJson(data))
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
  Future<Customer> addCustomer(String url, {String body})  {
    return  http.post(Uri.encodeFull(url), body: body,  headers: {"Accept":"application/json", "Content-Type":"application/json","Authorization":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImUzNjY3NjBiMTc1NDc3ZDYxYzUyMjc3MjdmYmJiZjEzODExMWFjYWYxNDMyNTJjZGJiM2NiNWUxYWI4ODdiOTNiZTYxODE3YzA3NjYwZjRiIn0.eyJhdWQiOiIyIiwianRpIjoiZTM2Njc2MGIxNzU0NzdkNjFjNTIyNzcyN2ZiYmJmMTM4MTExYWNhZjE0MzI1MmNkYmIzY2I1ZTFhYjg4N2I5M2JlNjE4MTdjMDc2NjBmNGIiLCJpYXQiOjE1NTg5MjQ1OTEsIm5iZiI6MTU1ODkyNDU5MSwiZXhwIjoxNTkwNTQ2OTkxLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.al4kz1xkC-CN93Ehfz8twYu-qRDxIaCx-pb8FkD4Nxo__QR6LJ4Gs8-T2t2jyftMfq0LmMpWYfUHXGCtgNsT4xGV5IVcF_XCkZDL83-NdYQ9UciDevAqUEGW9aN6qpZJB6e62tD-WQCU9AYbwx5OIZEnXpv1uUVxhU2v6m04Jff9isgXsyEcBUzZD5Iq5dYigl7hYrEfEiqKed3ZT5zacVEfnbsnTKEqVH8P7DmBhWlgZU55ts5_uCSiMKsnk6r2tTc5vhFIZDUu-yBoSNcCrQahl5z8d806WkYo4J7zhIcLo4h_zmqFd3c7-NUG8MsxbEz7ENnvBnSYfLczBh-RJRdd2rlSCa8_pU6W2smFZaqMLzEcHyIPmZKG-VyX49HDSjQuDaVkbpid-AlWdCzId3HaKw3bJH-4uFCHczULbHBVBCYp61Yu94-4f_NqfW0DHDHdYGPo8uPxIeQUBeqmHMv6E0pPwOd2zvnQ5GHaBmV2_RGSzk_uQfpamJxXGPxCERv752OaMtuK0DOlwHRt8FIWzbwKoF5X-ZN-yOx9sfUlBjsJjg870v9tQYVMR7odbmYruCMZv1VgysugpmJJhpN5msc6f7gXKg6PQW8_mSkv2G7o2JCsUe4dIlCwxq0dLTfhNRcG0-8U4A95VR9jqKw9dzGvhzPo2amGLddIR6w"}).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error Code: $statusCode");
      }
      return Customer.fromJson(json.decode(response.body));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      //appBar: AppBar(title: Text("Customer List"),),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          :Column(
        children: <Widget>[dataBody()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: Row(
                    children: <Widget>[
                      Text("Add new Customer:"),
                    ],
                  ),
                  content: Material(
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: nameController,
                          style: TextStyle(color: Colors.black45),
                          keyboardType: TextInputType.text,
                          cursorColor: Color(0xffa78066),
                          decoration: InputDecoration(
                            labelText: 'Name',
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
                          controller: phoneController,
                          style: TextStyle(color: Colors.black45),
                          keyboardType: TextInputType.number,
                          cursorColor: Color(0xffa78066),
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
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
                          controller: addressController,
                          style: TextStyle(color: Colors.black45),
                          keyboardType: TextInputType.text,
                          cursorColor: Color(0xffa78066),
                          decoration: InputDecoration(
                            labelText: 'Address',
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
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel"),
                    ),
                    FlatButton(
                      onPressed: () async{
                        int phone = int.parse(phoneController.text);
                        Customer newCustomer = Customer(name: nameController.text.toString(), address: addressController.text);
                        print(json.encode(newCustomer.toMap()));
                        await addCustomer(url, body: json.encode(newCustomer.toMap()));
                        
                        Navigator.of(context).pop();
                      },
                      child: Text("OK"),
                    ),
                  ],
                );
              });
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xffa78066),
      ),
    );
  }

  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
          columns: [
            DataColumn(
                label: Text(
              "Name",
              style: new TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            )),
            DataColumn(
                label: Text(
              "Address",
              style: new TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ))
          ],
          rows: allCustomers.where((customer)=>customer.saleID == saleID)
              .map((customer) => DataRow(cells: [
                    DataCell(Text(customer.name)),
                    DataCell(Text(customer.address))
                  ]))
              .toList()),
    );
  }
}
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
////      appBar: AppBar(
////        title: Text("Products in Stock"),
////      ),
//      body: isLoading
//          ? Center(
//        child: CircularProgressIndicator(),
//      )
//          : ListView.builder(
//        itemCount: list.length,
//        itemBuilder: (BuildContext context, int index) {
//          return ListTile(
//            onTap: () {
//              showDialog(
//                  context: context,
//                  barrierDismissible: false,
//                  builder: (BuildContext context) {
//                    return CupertinoAlertDialog(
//                      title: Row(
//                        children: <Widget>[
//                          Text(list[index].name),
//                        ],
//                      ),
//                      content: Material(
//                        child: Column(
//                          children: <Widget>[
//                            TextField(
//                              style: TextStyle(color: Colors.black45),
//                              keyboardType: TextInputType.text,
//                              cursorColor: Color(0xffa78066),
//                              decoration: InputDecoration(
//                                labelText: 'Name',
//                                labelStyle: TextStyle(
//                                  color: Colors.black45,
//                                ),
//                                focusedBorder: OutlineInputBorder(
//                                  borderSide:
//                                  BorderSide(color: Colors.white),
//                                  borderRadius: BorderRadius.circular(20),
//                                ),
//                                enabledBorder: OutlineInputBorder(
//                                  borderSide:
//                                  BorderSide(color: Colors.white),
//                                  borderRadius: BorderRadius.circular(20),
//                                ),
//                                border: OutlineInputBorder(
//                                  borderSide:
//                                  BorderSide(color: Colors.white),
//                                  borderRadius: BorderRadius.circular(20),
//                                ),
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
//                      actions: <Widget>[
//                        FlatButton(
//                          onPressed: () {
//                            Navigator.of(context).pop();
//                          },
//                          child: Text("Cancel"),
//                        ),
//                        FlatButton(
//                          onPressed: () {
//                            Navigator.of(context).pop();
//                          },
//                          child: Text("OK"),
//                        ),
//                      ],
//                    );
//                  });
//            },
//            contentPadding: EdgeInsets.all(10.0),
//            title: Text(list[index].name),
//            trailing: Text(list[index].address),
//          );
//
//        },
//      ),
//    );
//  }
//}

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

//import 'package:flutter/material.dart';
//import 'package:pbl/model/customer.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';
//import 'package:flutter/cupertino.dart';
//
//class CustomerListsPage extends StatefulWidget{
//  CustomerListsPage({Key key}) : super(key: key);
//  @override
//  _SearchListState createState() => _SearchListState();
//}
//class _SearchListState extends State<CustomerListsPage>{
//  String customerUrl = "http://10.0.2.2:8000/api/customers";
//
//  List<Customer> list = List();
//  var isLoading = false;
//
//
//  _fetchData() async {
//    setState(() {
//      isLoading = true;
//    });
//    final response = await http.get(customerUrl);
//    if (response.statusCode == 200) {
//      list = (json.decode(response.body) as List)
//          .map((data) => new Customer.fromJson(data))
//          .toList();
//      setState(() {
//        isLoading = false;
//      });
//    } else {
//      throw Exception('Failed to load Customers');
//    }
//  }
//
//  @override
//  void initState() {
//    _fetchData();
//    super.initState();
//  }
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
////      appBar: AppBar(
////        title: Text("Products in Stock"),
////      ),
//      body: isLoading
//          ? Center(
//        child: CircularProgressIndicator(),
//      )
//          : ListView.builder(
//        itemCount: list.length,
//        itemBuilder: (BuildContext context, int index) {
//          return ListTile(
//            onTap: () {
//              showDialog(
//                  context: context,
//                  barrierDismissible: false,
//                  builder: (BuildContext context) {
//                    return CupertinoAlertDialog(
//                      title: Row(
//                        children: <Widget>[
//                          Text(list[index].name),
//                        ],
//                      ),
//                      content: Material(
//                        child: Column(
//                          children: <Widget>[
//                            TextField(
//                              style: TextStyle(color: Colors.black45),
//                              keyboardType: TextInputType.text,
//                              cursorColor: Color(0xffa78066),
//                              decoration: InputDecoration(
//                                labelText: 'Name',
//                                labelStyle: TextStyle(
//                                  color: Colors.black45,
//                                ),
//                                focusedBorder: OutlineInputBorder(
//                                  borderSide:
//                                  BorderSide(color: Colors.white),
//                                  borderRadius: BorderRadius.circular(20),
//                                ),
//                                enabledBorder: OutlineInputBorder(
//                                  borderSide:
//                                  BorderSide(color: Colors.white),
//                                  borderRadius: BorderRadius.circular(20),
//                                ),
//                                border: OutlineInputBorder(
//                                  borderSide:
//                                  BorderSide(color: Colors.white),
//                                  borderRadius: BorderRadius.circular(20),
//                                ),
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
//                      actions: <Widget>[
//                        FlatButton(
//                          onPressed: () {
//                            Navigator.of(context).pop();
//                          },
//                          child: Text("Cancel"),
//                        ),
//                        FlatButton(
//                          onPressed: () {
//                            Navigator.of(context).pop();
//                          },
//                          child: Text("OK"),
//                        ),
//                      ],
//                    );
//                  });
//            },
//            contentPadding: EdgeInsets.all(10.0),
//            title: Text(list[index].name),
//            trailing: Text(list[index].address),
//          );
//
//        },
//      ),
//    );
//  }
//}
//
////import 'package:flutter/material.dart';
////import 'package:pbl/model/customer.dart';
////
////class CustomerListsPage extends StatefulWidget {
////  CustomerListsPage({Key key}) : super(key: key);
////  @override
////  _SearchListState createState() => _SearchListState();
////}
////
////class _SearchListState extends State<CustomerListsPage> {
////  Widget appBarTitle = Text(
////    "Customers",
////    style: TextStyle(color: Colors.white),
////  );
////  Icon actionIcon = Icon(
////    Icons.search,
////    color: Colors.white,
////  );
////  final key = GlobalKey<ScaffoldState>();
////  final TextEditingController _searchQuery = TextEditingController();
////  List<Customer> _list;
////  bool _isSearching;
////  String _searchText = "";
////
////  _SearchListState() {
////    _searchQuery.addListener(() {
////      if (_searchQuery.text.isEmpty) {
////        setState(() {
////          _isSearching = false;
////          _searchText = "";
////        });
////      } else {
////        setState(() {
////          _isSearching = true;
////          _searchText = _searchQuery.text;
////        });
////      }
////    });
////  }
////
////  @override
////  void initState() {
////    super.initState();
////    _isSearching = false;
////    init();
////  }
////
////  void init() {
////    _list = List();
////
////    Customer cus2 =
////        Customer.createCustomer('monyneth', 'assets/default.png', '', '', 1);
////    Customer cus3 = Customer.createCustomer('dalin', 'assets/default.png', '', '', 2);
////    Customer cus4 =
////        Customer.createCustomer('vicheka', 'assets/default.png', '', '', 3);
////    Customer cus5 = Customer.createCustomer('leo', 'assets/default.png', '', '', 4);
////
////    _list.add(cus2);
////    _list.add(cus3);
////    _list.add(cus4);
////    _list.add(cus5);
////  }
////
////  @override
////  Widget build(BuildContext context) {
////    return Scaffold(
////      key: key,
////      appBar: buildBar(context),
////      body: ListView(
////        padding: EdgeInsets.symmetric(vertical: 8.0),
////        children: _isSearching ? _buildSearchList() : _buildList(),
////      ),
////    );
////  }
////
////  List<Customer> _buildList() {
////    return _list
////        .map(
////          (customer) => Customer.createCustomer(
////              customer.username,
////              customer.profileUrl,
////              customer.autocompleteTerm,
////              customer.keyword,
////              customer.id),
////        )
////        .toList();
////  }
////
////  List<Customer> _buildSearchList() {
////    if (_searchText.isEmpty) {
////      return _list
////          .map(
////            (customer) => Customer.createCustomer(
////                customer.username,
////                customer.profileUrl,
////                customer.autocompleteTerm,
////                customer.keyword,
////                customer.id),
////          )
////          .toList();
////    } else {
////      List<Customer> _searchList = List();
////      for (int i = 0; i < _list.length; i++) {
////        //String name = _list.elementAt(i).username;
////        Customer customer = _list.elementAt(i);
////        if (customer.username
////            .toLowerCase()
////            .contains(_searchText.toLowerCase())) {
////          print(_searchList);
////          _searchList.add(customer);
////
////          print(_searchList);
////        }
////      }
////      return _searchList
////          .map(
////            (searchCustomer) => Customer.createCustomer(
////                searchCustomer.username,
////                searchCustomer.profileUrl,
////                searchCustomer.autocompleteTerm,
////                searchCustomer.keyword,
////                searchCustomer.id),
////          )
////          .toList();
////    }
////  }
////
////  Widget buildBar(BuildContext context) {
////    return AppBar(
////      title: appBarTitle,
////      centerTitle: true,
////      actions: <Widget>[
////        IconButton(
////          icon: actionIcon,
////          onPressed: () {
////            setState(() {
////              if (this.actionIcon.icon == Icons.search) {
////                this.actionIcon = Icon(
////                  Icons.close,
////                  color: Colors.white,
////                );
////                this.appBarTitle = TextField(
////                  controller: _searchQuery,
////                  style: TextStyle(
////                    color: Colors.white,
////                  ),
////                  decoration: InputDecoration(
////                    //prefixIcon: Icon(Icons.search, color: Colors.white),
////                    hintText: "Search...",
////                    hintStyle: TextStyle(color: Colors.white),
////                  ),
////                );
////                _handleSearchStart();
////              } else {
////                _handleSearchEnd();
////              }
////            });
////          },
////        ),
////      ],
////    );
////  }
////
////  void _handleSearchStart() {
////    setState(() {
////      _isSearching = true;
////    });
////  }
////
////  void _handleSearchEnd() {
////    setState(() {
////      this.actionIcon = Icon(
////        Icons.search,
////        color: Colors.white,
////      );
////      this.appBarTitle = Text(
////        "Customers",
////        style: TextStyle(color: Colors.white),
////      );
////      _isSearching = false;
////      _searchQuery.clear();
////    });
////  }
////}
//////
//////class ChildItem extends StatelessWidget {
//////  final String name;
//////  final String url;
//////  ChildItem(this.name, this.url);
//////  @override
//////  Widget build(BuildContext context) {
//////    return ListTile(
//////      title: Text(this.name), leading: Image.asset(url, width: 50,),
//////    );
//////  }
//////}
