import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:flutter/material.dart';

class MGFooterButtonWidget extends StatelessWidget {
  const MGFooterButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 16, 0, 16),
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(MGColorMainViewTwo),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            alignment: Alignment.center,
            width: (ScreenW(context) - 42) / 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/mg_watch_history.png',
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "更多精彩剧集",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(MGColorMainViewTwo),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            alignment: Alignment.center,
            width: (ScreenW(context) - 42) / 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/mg_watch_history.png',
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "换一换",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
