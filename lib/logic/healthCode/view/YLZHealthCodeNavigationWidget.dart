import 'package:DartProject/base/config/YLZMacros.dart';
import 'package:DartProject/base/config/YLZStyle.dart';
import 'package:flutter/material.dart';

typedef void YLZHealthCodeNavigationWidgetClickListener(int index);

class YLZHealthCodeNavigationWidget extends StatelessWidget {
  final YLZHealthCodeNavigationWidgetClickListener clickListener;

  const YLZHealthCodeNavigationWidget({Key? key, required this.clickListener})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenW(context),
      height: kBottomNavigationBarHeight + StatusH(context),
      child: Column(
        children: [
          Container(
              width: ScreenW(context),
              height: StatusH(context),
              color: Colors.white),
          Stack(children: [
            Container(
              width: ScreenW(context),
              height: kBottomNavigationBarHeight,
              color: Colors.white,
              child: Center(
                  child: Text(
                "福建八闽健康码",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(YLZColorTitleOne),
                ),
              )),
            ),
            Positioned(
                child: Container(
                  width: 80,
                  height: 30,
                  decoration: new BoxDecoration(
                    border: new Border.all(
                      color: Color(YLZColorTitleThree),
                      width: 1.0,
                    ),
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(15.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Image.asset(
                          'assets/images/ylz_mirco_more.png',
                        ),
                      ),
                      Container(
                        width: 1.0,
                        height: 16,
                        color: Color(YLZColorTitleThree),
                      ),
                      InkWell(
                        child: Container(
                          child: Image.asset(
                            'assets/images/ylz_mirco_shut.png',
                          ),
                        ),
                        onTap: () {
                          if (this.clickListener != null) {
                            this.clickListener(0);
                          }
                        },
                      )
                    ],
                  ),
                ),
                right: 16,
                top: 13)
          ])
        ],
      ),
    );
  }
}
