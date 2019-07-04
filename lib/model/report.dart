import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

class Report {
  final String itemName;
  final int soldAmount;
  String importDate;

  Report({this.itemName, this.soldAmount, this.importDate});
  factory Report.fromJson(Map<String, dynamic> parsedJson) {
    return Report(
        itemName: parsedJson['itemName'] as String,
        soldAmount: parsedJson['soldAmount'],
        importDate: parsedJson['importDate'] as String);
  }
}

class ReportViewModel {
  static List<Report> reports;
  static Future loadReports() async {
    try {
      reports = new List<Report>();
      String jsonString = await rootBundle.loadString('assets/reports.json');
      Map parsedJson = json.decode(jsonString);
      var categoryJson = parsedJson['reports'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        reports.add(Report.fromJson(categoryJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }
}
