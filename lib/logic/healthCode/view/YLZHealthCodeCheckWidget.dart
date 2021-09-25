import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:flutter/material.dart';

class YLZHealthCodeCheckWidget extends StatelessWidget {
  const YLZHealthCodeCheckWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenW(context) - 32,
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
      ),
      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
      height: 96,
      child: Stack(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(16, 16, 0, 0),
                  child: Text(
                    "通行大数据行程卡",
                    style:
                        TextStyle(color: Color(YLZColorTitleOne), fontSize: 18),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(16, 12, 0, 0),
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  decoration: new BoxDecoration(
                    color: Color(YLZColorMZTCheckView),
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(3.0)),
                  ),
                  child: Text(
                    "今日未核验",
                    style: TextStyle(
                        color: Color(YLZColorTitleThree), fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: InkWell(
              child: Container(
                width: 96,
                height: 36,
                decoration: new BoxDecoration(
                  color: Color(YLZColorMZTBlueView),
                  borderRadius: new BorderRadius.all(new Radius.circular(18.0)),
                ),
                child: Center(
                  child: Text(
                    "点击核验",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
            top: 30,
            right: 16,
          )
        ],
      ),
    );
  }
}
