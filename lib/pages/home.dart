import 'package:flutter/material.dart';
import 'customers.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Today PDO'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => CustomerListsPage(),
                  ),
                );
              },
              leading: Icon(Icons.playlist_add_check),
            ),
            Divider(),
            ListTile(
              title: Text('Customer Lists'),
              onTap: () {
                Navigator.pop(context);
              },
              leading: Icon(Icons.list),
            ),
            Divider(),
            ListTile(
              title: Text('Delivery'),
              onTap: () {
                Navigator.pop(context);
              },
              leading: Icon(Icons.add_shopping_cart),
            ),
            Divider(),
            ListTile(
              title: Text('Stock'),
              onTap: () {
                Navigator.pop(context);
              },
              leading: Icon(Icons.account_balance),
            ),
          ],
        ),
      ),
      body: Container(
        //  color: Colors.lightBlueAccent,
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20.0),
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 50,
          crossAxisCount: 2,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5),),
              ),
              elevation: 10,
              color: Colors.lightBlueAccent,
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
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5),),
              ),
              elevation: 10,
              color: Colors.lightBlueAccent,
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
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5),),
              ),
              elevation: 10,
              color: Colors.lightBlueAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/stock.png', width: 100),
                  Text('Stock',style: TextStyle(color: Colors.white),),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5),),
              ),
              elevation: 10,
              color: Colors.lightBlueAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/report-icon.png', width: 100),
                  Text('Report',style: TextStyle(color: Colors.white),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
