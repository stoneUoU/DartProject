import 'package:DartProject/base/config/YLZMacros.dart';
import 'package:DartProject/base/config/YLZStyle.dart';
import 'package:flutter/material.dart';

class MGHomeNavigatorWidget extends StatefulWidget {
  final Key key;

  const MGHomeNavigatorWidget(Key this.key) : super(key: key);

  @override
  MGHomeNavigatorWidgetState createState() => MGHomeNavigatorWidgetState();
}

class MGHomeNavigatorWidgetState extends State<MGHomeNavigatorWidget> {
  int index = 0;
  void generateIndex(int index) {
    setState(() {
      this.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: ScreenW(context),
      height: StatusH(context) + NaviH,
      child: Column(
        children: [
          Container(width: ScreenW(context), height: StatusH(context)),
          Container(
              width: ScreenW(context),
              height: NaviH,
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
                          width: ScreenW(context) - (44 + 80),
                          height: 32,
                          alignment: Alignment.center,
                          child: Text(
                            "Mac Pro",
                            style: TextStyle(color: Color(YLZColorTitleOne)),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              border: new Border.all(
                                color: Color(MGColorLightBlueView),
                                width: 1.0,
                              ))),
                      Positioned(
                          child: Container(
                            width: 22,
                            height: 22,
                            child: Image.asset(
                              'assets/images/mg_search.png',
                            ),
                          ),
                          right: 6,
                          top: 5)
                    ],
                  ),
                  _buildRightContainer(this.index)
                ],
              ))
        ],
      ),
    );
  }

  Container _buildRightContainer(int index) {
    if (index == 0) {
      return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
        width: 44 + 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 22,
              height: 22,
              margin: EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11.0),
                color: Colors.greenAccent,
              ),
              child: Image.asset(
                'assets/images/mg_watch_history.png',
              ),
            ),
            Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11.0),
                  color: Colors.greenAccent,
                ))
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
        width: 44 + 32,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          border: Border.all(color: Color(MGColorHomeViewPurple), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 6),
              child: Text(
                "筛选",
                style:
                    TextStyle(color: Color(YLZColorTitleThree), fontSize: 16),
              ),
            ),
            Container(
              width: 22,
              height: 22,
              child: Image.asset(
                'assets/images/mg_filter.png',
              ),
            ),
          ],
        ),
      );
    }
  }
}
