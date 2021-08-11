import 'package:dart_demo/base/config/YLZMacros.dart';
import 'package:dart_demo/base/config/YLZStyle.dart';
import 'package:flutter/material.dart';

class YLZHomeSearchWidget extends StatefulWidget {
  final Key key;

  YLZHomeSearchWidget(this.key) : super(key: key);

  @override
  YLZHomeSearchWidgetState createState() => YLZHomeSearchWidgetState();
}

class YLZHomeSearchWidgetState extends State<YLZHomeSearchWidget> {
  double heightRatio = 0.0;
  double marginLeftRatio = 0.0;
  double marginRightRatio = 0.0;
  double marginTopRatio = 0.0;

  void changeHeightRatio(double offset) {
    setState(() {
      marginTopRatio = offset * (44 - 28) / 2;
      heightRatio = offset * (44 - 28);
      marginLeftRatio = offset * (70 - 16);
      marginRightRatio = offset * (45 - 16);

      print("marginTopRatio________________${marginTopRatio}");
      print("heightRatio________________${heightRatio}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(22.0)),
      ),
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.fromLTRB(
          16 + marginLeftRatio, marginTopRatio, 16 + marginRightRatio, 0),
      width: ScreenW(context) - (32 + marginLeftRatio + marginRightRatio),
      height: 44 - heightRatio,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Image.asset(
                    'assets/images/ylz_home_find.png',
                  )),
              Container(
                child: Text("  定点医院", style: TextStyle(color: Colors.black38)),
              )
            ],
          ),
          Container(
            child: Row(
              children: [
                Container(
                  width: 1,
                  height: 22,
                  color: Color(YLZColorLine),
                ),
                Container(
                  margin: EdgeInsets.only(right: 16),
                  child: Text(
                    "   搜索",
                    style: TextStyle(color: Color(colorC20)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
    ;
  }
}
