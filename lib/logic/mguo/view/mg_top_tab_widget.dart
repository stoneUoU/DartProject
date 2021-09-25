import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:flutter/material.dart';

class MGTopTabWidget extends StatelessWidget {
  final List<Widget> tabs;
  final TabController controller;
  final double fontSize;
  final double borderWidth;
  final double insets;
  final Color unselectedLabelColor;

  const MGTopTabWidget(this.tabs,
      {Key? key,
      required this.controller,
      this.fontSize = 13,
      this.borderWidth = 2,
      this.insets = 15,
      this.unselectedLabelColor = Colors.grey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
        controller: controller,
        isScrollable: true,
        labelColor: Colors.white,
        unselectedLabelColor: unselectedLabelColor,
        labelStyle: TextStyle(fontSize: 20),
        unselectedLabelStyle: TextStyle(fontSize: fontSize),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
                color: Color(MGColorLightBlueView), width: borderWidth),
            insets: EdgeInsets.only(left: insets, right: insets)),
        tabs: tabs);
  }
}
