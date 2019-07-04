import 'package:flutter/material.dart';
import 'package:pbl/model/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';


//class ProductListsPage extends StatefulWidget {
//  ProductListsPage({Key key}) : super(key: key);
//  @override
//  _SearchListState createState() => _SearchListState();
//}
//
//class _SearchListState extends State<ProductListsPage> {
//  Widget appBarTitle = Text(
//    "Products",
//    style: TextStyle(color: Colors.white),
//  );
//  Icon actionIcon = Icon(
//    Icons.search,
//    color: Colors.white,
//  );
//  final key = GlobalKey<ScaffoldState>();
//  final TextEditingController _searchQuery = TextEditingController();
//  List<Product> _list;
//  bool _isSearching;
//  String _searchText = "";
//
//  void _loadData() async {
//    ProductViewModel.loadProducts();
//  }
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
//    _loadData();
//    super.initState();
//    _isSearching = false;
//    init();
//  }
//
//  void init() {
//    _list = List();
//    _list = ProductViewModel.products;
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
//  List<Product> _buildList() {
//    return _list.map((product) => Product(productName: product.productName, productUrl: product.productUrl)).toList();
//  }
//
//  List<Product> _buildSearchList() {
//    if (_searchText.isEmpty) {
//      return _list.map((product) => Product(productName: product.productName, productUrl: product.productUrl)).toList();
//    } else {
//      List<Product> _searchList = List();
//      for (int i = 0; i < _list.length; i++) {
//        //String name = _list.elementAt(i).username;
//        Product product = _list.elementAt(i);
//        if (product.productName
//            .toLowerCase()
//            .contains(_searchText.toLowerCase())) {
//          print(_searchList);
//          _searchList.add(product);
//          print(_searchList);
//        }
//      }
//      return _searchList.map((searchProduct) =>
//            Product(productName: searchProduct.productName, productUrl: searchProduct.productUrl)).toList();
//    }
//  }
//
//  Widget buildBar(BuildContext context) {
//    return
//      AppBar(
//        title: appBarTitle,
//        centerTitle: true,
//        actions: <Widget>[
//        IconButton(
//        icon: actionIcon,
//        onPressed: () {
//          setState(() {
//            if (this.actionIcon.icon == Icons.search) {
//              this.actionIcon = Icon(
//                Icons.close,
//                color: Colors.white,
//              );
//              this.appBarTitle = TextField(
//                controller: _searchQuery,
//                style: TextStyle(
//                  color: Colors.white,
//                ),
//                decoration: InputDecoration(
//                  //prefixIcon: Icon(Icons.search, color: Colors.white),
//                  hintText: "Search...",
//                  hintStyle: TextStyle(color: Colors.white),
//                ),
//              );
//              _handleSearchStart();
//            } else {
//              _handleSearchEnd();
//            }
//          });
//        },
//      ),
//    ],
//      );
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
//        "All Products",
//        style: TextStyle(color: Colors.white),
//      );
//      _isSearching = false;
//      _searchQuery.clear();
//    });
//  }
//}
//
//class ChildItem extends StatelessWidget {
//  final String name;
//  final String url;
//  ChildItem(this.name, this.url);
//  @override
//  Widget build(BuildContext context) {
//    return ListTile(
//      title: Text(this.name), leading: Image.asset(url, width: 50,),
//    );
//  }
//}
class ProductListsPage extends StatefulWidget {
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<ProductListsPage> {
  List<Product> list = List();
  var isLoading = false;
  //final Future<Product> product = fetchPost();
  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get("http://10.0.2.2:8000/api/products");
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new Product.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load Product');
    }
  }

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Products in Stock"),
      ),
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
                                Text(list[index].productName),
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
                  title: Text(list[index].productName),
                  trailing: Text(list[index].stock.toString()),
                );

              },
            ),
    );
  }
}

//GestureDetector(
//      onTap: (){
//        showDialog(
//          context: context,
//          barrierDismissible: false,
//          builder: (BuildContext context){
//            return CupertinoAlertDialog(
//              title: Row(
//                children: <Widget>[
//                  Text(this.productName),
//                  Icon(
//                    Icons.add,
//                    color: Color(0xffa78066),
//                  ),
//                ],
//              ),
//              content: Material(
//                child: Column(
//                  children: <Widget>[
//                    TextField(
//                      style: TextStyle(color: Colors.black45),
//                      keyboardType: TextInputType.text,
//                      cursorColor: Color(0xffa78066),
//                      decoration: InputDecoration(
//                        labelText: 'Name',
//                        labelStyle: TextStyle(
//                          color: Colors.black45,
//                        ),
//                        focusedBorder: OutlineInputBorder(
//                          borderSide: BorderSide(color: Colors.white),
//                          borderRadius: BorderRadius.circular(20),
//                        ),
//                        enabledBorder: OutlineInputBorder(
//                          borderSide: BorderSide(color: Colors.white),
//                          borderRadius: BorderRadius.circular(20),
//                        ),
//                        border: OutlineInputBorder(
//                          borderSide: BorderSide(color: Colors.white),
//                          borderRadius: BorderRadius.circular(20),
//                        ),
//                      ),
//                    ),
//                    TextField(
//                      style: TextStyle(color: Colors.black45),
//                      keyboardType: TextInputType.phone,
//                      cursorColor: Color(0xffa78066),
//                      decoration: InputDecoration(
//                        labelText: 'Phone',
//                        labelStyle: TextStyle(
//                          color: Colors.black45,
//                        ),
//                        focusedBorder: OutlineInputBorder(
//                          borderSide: BorderSide(color: Colors.white),
//                          borderRadius: BorderRadius.circular(20),
//                        ),
//                        enabledBorder: OutlineInputBorder(
//                          borderSide: BorderSide(color: Colors.white),
//                          borderRadius: BorderRadius.circular(20),
//                        ),
//                        border: OutlineInputBorder(
//                          borderSide: BorderSide(color: Colors.white),
//                          borderRadius: BorderRadius.circular(20),
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              actions: <Widget>[
//                FlatButton(
//                  onPressed: (){
//                    Navigator.of(context).pop();
//                  },
//                  child: Text("Cancel"),
//                ),
//                FlatButton(
//                  onPressed: (){
//                    Navigator.of(context).pop();
//                  },
//                  child: Text("OK"),
//                ),
//              ],
//            );
//          },
//        );
//      },
//      child: ListTile(
//        title: Text(this.productName),
//        leading: CircleAvatar(
//          backgroundImage: AssetImage(this.productUrl),
//        ),
//      ),
//    );
