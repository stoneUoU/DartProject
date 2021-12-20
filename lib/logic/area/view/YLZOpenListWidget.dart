import 'package:DartProject/base/config/YLZStyle.dart';
import 'package:DartProject/logic/area/model/YLZAreaModel.dart';
import 'package:flutter/material.dart';

class YLZOpenListWidget extends StatelessWidget {
  final OpenList openList;

  const YLZOpenListWidget({Key? key, required this.openList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 42,
            height: 42,
            child: FadeInImage.assetNetwork(
              placeholder: "assets/images/ylz_blank_circular.jpg",
              image: openList.iconUrl ?? "",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              openList.areaName ?? "",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Color(YLZColorTitleTwo), fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
