import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:flutter/material.dart';

class YLZMineMemberCellImageWidget extends StatelessWidget {
  bool isPlace = true;

  YLZMineMemberCellImageWidget({Key? key, required this.isPlace})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: 88,
      width: (ScreenW(context) - 32) / 5,
      child: Image.asset(
        this.isPlace
            ? 'assets/images/ylz_mine_circle_add_place.png'
            : 'assets/images/ylz_mine_circle_add.png',
      ),
    );
  }
}
