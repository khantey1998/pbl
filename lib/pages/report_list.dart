import 'package:flutter/material.dart';
import 'package:fragment/fragment.dart';

class ReportList extends StatefulWidget{
  @override
  _ReportListState createState() => _ReportListState();

}
class _ReportListState extends State<ReportList> with Fragments{
  String text = 'khantey';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        fragment( // use fragment method to cache a subtree
              () => Container(),
          deps: [text],
        ),

      ],
    );
  }

}