import 'package:dart_demo/base/config/YLZMacros.dart';
import 'package:dart_demo/base/config/YLZStyle.dart';
import 'package:flutter/material.dart';

class YLZMineMemberCellLabelWidget extends StatelessWidget {
  const YLZMineMemberCellLabelWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      width: (ScreenW(context) - 32) / 5,
      child: Column(
        children: [
          Image.asset(
            'assets/images/ylz_mine_baby_avater.png',
          ),
          Padding(
            padding: EdgeInsets.only(top: 6),
            child: Text(
              'iOS工程师',
              style: const TextStyle(
                color: Color(YLZColorTitleTwo),
              ),
            ),
          )
        ],
      ),
    );
  }
}
