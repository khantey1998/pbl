import 'dart:async';
import 'package:pbl/utils/auth_utils.dart';
import 'package:pbl/utils/network_utils.dart';
import 'package:flutter/material.dart';
import 'package:pbl/pages/deliveries.dart';
import 'package:pbl/pages/products.dart';
import 'package:pbl/pages/report_list.dart';
import 'package:pbl/pages/orders.dart';
import 'package:pbl/pages/customers.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  static final String routeName = 'home';
//  String userUrl = "http://pdo.pblcnt.com/api/auth/user";
//  final User user;
//  HomePage({Key key, this.user}): super(key:key);
  final drawerItems = [
    DrawerItem("Home", Icons.home),
    DrawerItem("Customer List", Icons.list),
    DrawerItem("Delivery", Icons.add_shopping_cart),
    DrawerItem("Stock", Icons.account_balance),
    DrawerItem("Log Out", Icons.exit_to_app),
  ];

  @override
  _HomePageState createState() => _HomePageState();
}

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}
Widget home(BuildContext context){
  return  Container(
    //  color: Colors.lightBlueAccent,
    child: GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20.0),
      crossAxisSpacing: 20.0,
      mainAxisSpacing: 50,
      crossAxisCount: 2,
      children: <Widget>[

        GestureDetector(
          onTap: (){Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Order(),
            ),
          );},
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            elevation: 10,
            color: Color(0xffa78066),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/shopping_cart.png',
                  width: 100,
                ),
                Text(
                  'PDO',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: (){Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => DeliveryStatus(),
            ),
          );},
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            elevation: 10,
            color: Color(0xffa78066),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/delivery_truck_free_icon.png',
                    width: 100),
                Text(
                  'Delivery',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: (){Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ProductListsPage(),
            ),
          );},
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            elevation: 10,
            color: Color(0xffa78066),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/stock.png', width: 100),
                Text(
                  'Stock',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: (){Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ReportList(),
            ),
          );},
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            elevation: 10,
            color: Color(0xffa78066),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/report-icon.png', width: 100),
                Text(
                  'Report',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class _HomePageState extends State<HomePage> {

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  SharedPreferences _sharedPreferences;
  var _authToken, _id, _name, _homeResponse;
  int _selectedDrawerIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchSessionAndNavigate();
  }
  _fetchSessionAndNavigate() async {
    _sharedPreferences = await _prefs;
    String authToken = AuthUtils.getToken(_sharedPreferences);
    var id = _sharedPreferences.getInt(AuthUtils.userIdKey);
    var name = _sharedPreferences.getString(AuthUtils.nameKey);

    print("authtoken: $authToken");

    _fetchProfile(authToken);

    setState(() {
      _authToken = authToken;
      _id = id;
      _name = name;
    });

    if(_authToken == null) {
      _logout();
    }
  }
  _fetchProfile(String authToken) async {
    var responseJson = await NetworkUtils.fetch(authToken, '/api/auth/user');

    if(responseJson == null) {

      NetworkUtils.showSnackBar(_scaffoldKey, 'Something went wrong!');

    } else if(responseJson == 'NetworkError') {

      NetworkUtils.showSnackBar(_scaffoldKey, null);

    } else if(responseJson['errors'] != null) {

      _logout();

    }

    setState(() {
      _homeResponse = responseJson.toString();
    });
  }
  _logout() {
    NetworkUtils.logoutUser(_scaffoldKey.currentContext, _sharedPreferences);
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return home(context);
      case 1:
        return CustomerListsPage();
      case 2:
        return DeliveryStatus();
      case 3:
        return ProductListsPage();
      case 4:
        return _logout();

      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {

    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
        ListTile(
          leading: Icon(d.icon),
          title: Text(d.title),
          selected: i == _selectedDrawerIndex,
          onTap: () => _onSelectItem(i),
        ),
      );
    }
    print("$_homeResponse");
    print(_name);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        //title: Text(widget.drawerItems[_selectedDrawerIndex].title,),
        backgroundColor: Color(0xffa78066),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: _logout,),
        ],

      ),
      //appBar: false ? AppBar(title: Text(widget.drawerItems[_selectedDrawerIndex].title,),) : null,
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              //accountName: Text(_name),
              //accountEmail: Text(_authToken),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/default.png"),
              ),
            ),
            Column(
              children: drawerOptions,
            )
          ],
        ),
      ),
      body:_getDrawerItemWidget(_selectedDrawerIndex),

    );
  }
}
