import 'package:dart_demo/base/config/YLZMacros.dart';
import 'package:dart_demo/base/config/YLZStyle.dart';
import 'package:dart_demo/logic/mguo/model/mg_home_model.dart';
import 'package:flutter/material.dart';

class MGHomeHeaderWidget extends StatelessWidget {
  final Video video;

  const MGHomeHeaderWidget({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 44,
      color: Color(MGColorMainView),
      child: Padding(
        padding: EdgeInsets.only(left: 16),
        child: Text(
          "${video.name}",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}