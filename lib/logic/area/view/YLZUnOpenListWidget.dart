import 'package:dart_demo/base/config/YLZStyle.dart';
import 'package:dart_demo/logic/area/model/YLZAreaModel.dart';
import 'package:flutter/material.dart';

class YLZUnOpenListWidget extends StatelessWidget {
  final UnOpenList unOpenList;
  final bool isMore;
  const YLZUnOpenListWidget(
      {Key? key, required this.unOpenList, required this.isMore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Color(YLZColorPlace),
              borderRadius: BorderRadius.all(Radius.circular(21.0)),
            ),
            alignment: Alignment.center,
            child: _buildWidget(),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              isMore ? "更多" : unOpenList.areaName ?? "",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Color(YLZColorTitleTwo), fontSize: 14),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWidget() {
    if (isMore) {
      return Image.asset('assets/images/ylz_elec_code_dot.png',
          fit: BoxFit.fill);
    } else {
      return Text(
        unOpenList.iconUrl ?? "",
        style: TextStyle(color: Color(YLZColorTitleTwo), fontSize: 16),
      );
    }
  }
}
