import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:flutter/material.dart';

class MGFooterFeedBackWidget extends StatelessWidget {
  const MGFooterFeedBackWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenW(context),
      height: 78,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(MGColorHomeViewPurple),
            Color(MGColorHomeViewPink),
          ],
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/mg_watch_history.png',
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Text(
              "想看的没有？现在就去留言求片",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Image.asset(
            'assets/images/ylz_arrow_right.png',
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
