import 'package:DartProject/base/config/YLZMacros.dart';
import 'package:DartProject/base/config/YLZStyle.dart';
import 'package:DartProject/logic/rainBow/model/YLZRainBowModel.dart';
import 'package:DartProject/logic/rainBow/view/YLZRainBowBoxLabelView.dart';
import 'package:flutter/material.dart';

typedef void OnYLZRainBowPrivateSchoolCellClickListener(int idStr);

class YLZRainBowPrivateSchoolCell extends StatefulWidget {
  Rs rs;
  final OnYLZRainBowPrivateSchoolCellClickListener
      onYLZRainBowPrivateSchoolCellClickListener;
  YLZRainBowPrivateSchoolCell(
      {Key? key,
      required this.rs,
      required this.onYLZRainBowPrivateSchoolCellClickListener})
      : super(key: key);

  @override
  _YLZRainBowPrivateSchoolCellState createState() =>
      _YLZRainBowPrivateSchoolCellState();
}

class _YLZRainBowPrivateSchoolCellState
    extends State<YLZRainBowPrivateSchoolCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this
            .widget
            .onYLZRainBowPrivateSchoolCellClickListener(widget.rs.dataID ?? 0);
      },
      child: Container(
        width: ScreenW(context) - 30,
        margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: _makeCol(widget.rs),
      ),
    );
  }

  Column _makeCol(Rs rs) {
    return Column(
      children: <Widget>[
        Container(
          width: ScreenW(context) - 30.0,
          height: _makePhotoHeight(rs),
          child: new FadeInImage.assetNetwork(
            placeholder: "assets/images/ylz_blank_rectangle.png",
            fadeInDuration: const Duration(seconds: 1), // 持续时间，默认 700 ms
            image: "${rs.bigImg}",
            fit: BoxFit.cover,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
          width: ScreenW(context) - 30.0,
          child: Text(
            "${rs.title}",
            style: TextStyle(color: Color(YLZColorTitleTwo), fontSize: 16),
            textAlign: TextAlign.left,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
            margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: YLZRainBowBoxLabelView(boxStr: _makeBoxStr(widget.rs))),
      ],
    );
  }

  double _makePhotoHeight(Rs rs) {
    if (rs.type == 1 && rs.type == 2) {
      return (ScreenW(context) - 30) * rs.imgWidth! / rs.imgHeight!;
    } else if (rs.type == 11) {
      return (ScreenW(context) - 30) * 265 / 375;
    }
    {
      return (ScreenW(context) - 30) * 3 / 5;
    }
  }

  String _makeBoxStr(Rs rs) {
    if (rs.type == 1) {
      return "设计作品";
    } else if (rs.type == 2) {
      return "设计案例";
    } else if (rs.type == 5) {
      return "策划案";
    } else if (rs.type == 6) {
      return "作品私馆";
    } else if (rs.type == 10) {
      return "主题元素";
    } else {
      return "设计报告";
    }
  }
}
