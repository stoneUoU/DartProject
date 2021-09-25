import 'dart:convert';

import 'package:FlutterProject/logic/rainBow/YLZRainBowPage.dart';
import 'package:FlutterProject/logic/rainBow/YLZReportDetailPage.dart';
import 'package:FlutterProject/logic/rainBow/YLZReportListPage.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

var rootHandler = new Handler(handlerFunc: (context, params) {
  return new YLZRainBowPage();
});

var reportViewHandler = new Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return new YLZReportListPage();
});

var reportDetailViewHandler = new Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  print("${json.decode(params["data"]![0])["reportId"]}");
  int reportId = int.parse("${json.decode(params["data"]![0])["reportId"]}");
  return new YLZReportDetailPage(reportId: reportId);
});
