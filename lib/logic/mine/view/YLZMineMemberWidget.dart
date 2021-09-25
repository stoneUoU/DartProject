import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:flutter/material.dart';

import 'YLZMineMemberCellImageWidget.dart';
import 'YLZMineMemberCellLabelWidget.dart';

class YLZMineMemberWidget extends StatefulWidget {
  const YLZMineMemberWidget({Key? key}) : super(key: key);

  @override
  _YLZMineMemberWidgetState createState() => _YLZMineMemberWidgetState();
}

class _YLZMineMemberWidgetState extends State<YLZMineMemberWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text("我的家庭成员   ",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(YLZColorTitleOne),
                          fontSize: 16,
                        )),
                    Text("(1/5)",
                        style: TextStyle(
                          color: Color(YLZColorLightBlueView),
                          fontSize: 16,
                        ))
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '管理亲情账户  ',
                      style: const TextStyle(
                        color: Color(YLZColorTitleTwo),
                      ),
                    ),
                    Image.asset(
                      'assets/images/ylz_arrow_right.png',
                      width: 12,
                      height: 12,
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 96,
            margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return YLZMineMemberCellLabelWidget();
                } else if (index == 1) {
                  return YLZMineMemberCellImageWidget(
                    isPlace: false,
                  );
                } else {
                  return YLZMineMemberCellImageWidget(
                    isPlace: true,
                  );
                }
              },
              itemCount: 5,
            ),
          )
        ],
      ),
    );
  }
}
