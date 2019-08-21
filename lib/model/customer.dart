class Customer{

  final String name;
  String profileUrl;
  final String phone;
  final String address;
  int saleID;
  int id;

//  final String email;

  Customer({this.name,this.phone, this.address, this.saleID, this.id});
  factory Customer.fromJson(Map<String, dynamic> parsedJson) {
    return Customer(
        name: parsedJson['name'] as String,
        phone: parsedJson['phone'],
        address: parsedJson['address'] as String,
        saleID: parsedJson['sale_id'],
        id: parsedJson['id']
    );
  }
  Map toMap(){
    var map = Map<String, dynamic>();
    map["name"] = name;
    map["phone"] = phone;
    map["address"] = address;
    map["sale_id"] = saleID;
    map["id"] = id;
    return map;
  }
//  @override
//  Widget build(BuildContext context) {
//    return GestureDetector(
//      onTap: (){
//        showDialog(
//          context: context,
//          barrierDismissible: false,
//          builder: (BuildContext context){
//            return CupertinoAlertDialog(
//              title: Row(
//                children: <Widget>[
//                  Text(this.username),
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
//        title: Text(this.username),
//        leading: CircleAvatar(
//          backgroundImage: AssetImage(this.profileUrl),
//        ),
//      ),
//    );
//  }
}
//class CustomerViewModel{
//  static List<Customer> customers;
//  static Future loadCustomers() async {
//    try {
//      customers = new List<Customer>();
//      String jsonString = await rootBundle.loadString('assets/customers.json');
//      Map parsedJson = json.decode(jsonString);
//      var categoryJson = parsedJson['customers'] as List;
//      for (int i = 0; i < categoryJson.length; i++) {
//        customers.add( Customer.fromJson(categoryJson[i]));
//      }
//    } catch (e) {
//      print(e);
//    }
//  }
//}