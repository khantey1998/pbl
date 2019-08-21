import 'package:flutter/material.dart';
import 'package:pbl/model/report.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'report_detail.dart';

class ReportList extends StatefulWidget{
  ReportList({Key key}) : super(key: key);
  @override
  _ReportListState createState() => _ReportListState();

}
class _ReportListState extends State<ReportList> {
  DateTime date = DateTime.now();
  List<Report> reportList;
  final key = GlobalKey<ScaffoldState>();
  var isLoading = false;
  String url = "http://pdo.pblcnt.com/api/orders";
  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
      reportList = (json.decode(response.body) as List)
          .map((data) => Report.fromJson(data))
          .toList();


      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception(response.statusCode);
    }
  }

  @override
  void initState() {
    _fetchData();
    reportList = List();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reports"),),
      key: key,
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      ):Container(
          child:
//            Row(
//              children: <Widget>[
//                RaisedButton(
//                  child: Text("From:"),
//                  onPressed: (){
//                    _selectDate(context);
//                  },
//                ),
//                SizedBox(width: 10,),
//                Text("${date.day}-${date.month}-${date.year}"),
//                SizedBox(width: 10,),
//                RaisedButton(
//                  child: Text("To:"),
//                  onPressed: (){
//                    _selectDate(context);
//                  },
//                ),
//                SizedBox(width: 10,),
//                Text("${date.day}-${date.month}-${date.year}"),
//              ],
//            ),
            dataBody()
      )
    );
  }
  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
          columns: [
            DataColumn(label: Text("Customers",
              )),
            DataColumn(label: Text("Total Price",
                )),
          ],
          rows: reportList.map((report) =>
              DataRow(
                  cells: [
                    DataCell(Text(report.customer),onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReportDetail(report: report),
                        ),
                      );
                    }),
                    DataCell(Text(report.totalPrice.toString()),onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReportDetail(report: report),
                        ),
                      );
                    })
                ])).toList()
      ),
    );
  }
}