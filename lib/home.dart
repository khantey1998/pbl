import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
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
//            ListTile(
//              title: Text('Customer Lists'),
//              onTap: () {
//
//                Navigator.pop(context);
//              },
//              trailing: Icon(Icons.format_list_numbered),
//            ),
//            Divider(),
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
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20.0),
        crossAxisSpacing: 10.0,
        crossAxisCount: 2,
        children: <Widget>[
          const Text('He\'d have you all unravel at the'),
          const Text('Heed not the rabble'),
          const Text('Sound of screams but the'),
          const Text('Who scream'),
          const Text('Revolution is coming...'),
          const Text('Revolution, they...'),
        ],
      ),
    );
  }
}