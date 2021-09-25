import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:flutter/material.dart';

import 'YLZHealthCodeServiceCellWidget.dart';

class YLZHealthCodeServiceWidget extends StatelessWidget {
  const YLZHealthCodeServiceWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenW(context),
      height: 308,
      child: Container(
          width: ScreenW(context),
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
          ),
          margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(16, 16, 0, 16),
                child: Text(
                  "相关服务",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Color(YLZColorTitleOne),
                  ),
                ),
              ),
              Expanded(child: YLZHealthCodeServiceCellWidget())
            ],
          )),
    );
  }
}
