import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:FlutterProject/logic/rainBow/model/YLZRainBowModel.dart';
import 'package:FlutterProject/logic/rainBow/view/YLZRainBowBoxLabelView.dart';
import 'package:flutter/material.dart';

class YLZRainBowPurchaseNoPhotoCell extends StatefulWidget {
  Rs rs;

  YLZRainBowPurchaseNoPhotoCell({Key? key, required this.rs}) : super(key: key);
  @override
  _YLZRainBowPurchaseNoPhotoCellState createState() =>
      _YLZRainBowPurchaseNoPhotoCellState();
}

class _YLZRainBowPurchaseNoPhotoCellState
    extends State<YLZRainBowPurchaseNoPhotoCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenW(context) - 30,
      margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: new Stack(
        children: <Widget>[
          Container(
            width: ScreenW(context) - 30,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  width: ScreenW(context) - 30 - 100,
                  child: Text(
                    "${widget.rs.title}",
                    style:
                        TextStyle(color: Color(YLZColorTitleTwo), fontSize: 16),
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                _buildMidView(widget.rs),
                Container(child: YLZRainBowBoxLabelView(boxStr: "采购需求")),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMidView(Rs rs) {
    return Container(
      width: ScreenW(context) - 30,
      margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Row(
        children: <Widget>[
          new Expanded(
              child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: "项目预算:",
                    style: TextStyle(
                      color: Color(YLZColorTitleThree),
                      fontSize: 14,
                    )),
                TextSpan(
                  text: "${widget.rs.budget}元左右",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )),
          new Expanded(
            child: Text(
              "${widget.rs.time}截止报名",
              style: TextStyle(color: Color(YLZColorTitleThree), fontSize: 14),
              textAlign: TextAlign.right,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
