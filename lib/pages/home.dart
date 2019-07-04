import 'package:flutter/material.dart';
import 'customers.dart';
import 'order.dart';
import 'report_list.dart';
import 'products.dart';
import 'deliveries.dart';

class HomePage extends StatefulWidget {
  final drawerItems = [
    DrawerItem("Home", Icons.home),
    DrawerItem("Customer List", Icons.list),
    DrawerItem("Delivery", Icons.add_shopping_cart),
    DrawerItem("Stock", Icons.account_balance),
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
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return home(context);
      case 1:
        return CustomerListsPage();
      case 2:
        return Text('hello');
//      case 3:
//        return ProductListsPage();
      case 4:
        return ReportList();

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.drawerItems[_selectedDrawerIndex].title,),
        backgroundColor: Color(0xffa78066),

      ),
        //appBar: false ? AppBar(title: Text(widget.drawerItems[_selectedDrawerIndex].title,),) : null,
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('khantey'),
              accountEmail: Text('longchendakhantey@gmail.com'),
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
