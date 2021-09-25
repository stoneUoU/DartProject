import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:flutter/material.dart';

//flutter闭包与android类似的

typedef void OnHorizontalViewClickListener(int index);

class YLZRainBowHorizontalView extends StatelessWidget {
  List dataList = [];

  final OnHorizontalViewClickListener onHorizontalViewClickListener;

  YLZRainBowHorizontalView(
      {Key? key,
      required this.dataList,
      required this.onHorizontalViewClickListener})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenW(context),
        height: 70.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: dataList.length,
          itemBuilder: (BuildContext context, int position) {
            return _makeContainer(context, dataList[position]["picStr"],
                dataList[position]["textStr"], dataList[position]["index"]);
          },
        ));
  }

  GestureDetector _makeContainer(
      BuildContext context, String picStr, String textStr, int index) {
    return GestureDetector(
      onTap: () {
        this.onHorizontalViewClickListener(index);
      },
      child: Container(
          width: ScreenW(context) / 5,
          height: 70.0,
          child: new Center(
              child: Column(
            children: <Widget>[
              new Container(
                margin: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                child: new Image.asset('assets/$picStr'),
              ),
              new Text(textStr,
                  style: new TextStyle(
                      fontSize: 12.0, color: Color(YLZColorTitleThree)),
                  textAlign: TextAlign.left),
            ],
          ))),
    );
  }

//找设计师   设计报告   主题元素   作品私馆   看策划案  设计干货  贸易对接  设计课
}
