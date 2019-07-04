import 'package:flutter/material.dart';
import 'package:pbl/model/report.dart';
import 'package:fragment/fragment.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';

class ReportList extends StatefulWidget{
  ReportList({Key key}) : super(key: key);
  @override
  _ReportListState createState() => _ReportListState();

}
class _ReportListState extends State<ReportList> {
  DateTime date = DateTime.now();
  List<Report> _list;
  final key = GlobalKey<ScaffoldState>();

  void _loadData() async {
    ReportViewModel.loadReports();
  }
  Future<Null> _selectDate(BuildContext context) async{
    final DateTime picked = await showDatePicker(context: context, initialDate: date, firstDate: DateTime(2018), lastDate: date);
    if(picked != null && picked != date){
      setState(() {
        date = picked;

      });
    }
  }
  @override
  void initState() {
    _loadData();
    _list = List();
    _list = ReportViewModel.reports;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reports"),),
      key: key,
      body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                RaisedButton(
                  child: Text("From:"),
                  onPressed: (){
                    _selectDate(context);
                  },
                ),
                SizedBox(width: 10,),
                Text("${date.day}-${date.month}-${date.year}"),
                SizedBox(width: 10,),
                RaisedButton(
                  child: Text("To:"),
                  onPressed: (){
                    _selectDate(context);
                  },
                ),
                SizedBox(width: 10,),
                Text("${date.day}-${date.month}-${date.year}"),
              ],
            ),
            dataBody()
          ],

      )
    );
  }
  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(

          columns: [
            DataColumn(label: Text("Product",
              )),
            DataColumn(label: Text("Import",
                )),
            DataColumn(label: Text("Sold",
                ))
          ],
          rows: _list.map((report) =>
              DataRow(cells: [
                DataCell(Text(report.itemName)),
                DataCell(Text(report.importDate)),
                DataCell(Text(report.soldAmount.toString()))
              ])).toList()
      ),

    );
  }
}