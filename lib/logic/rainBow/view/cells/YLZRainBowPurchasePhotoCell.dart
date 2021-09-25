import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:FlutterProject/logic/rainBow/model/YLZRainBowModel.dart';
import 'package:FlutterProject/logic/rainBow/view/YLZRainBowBoxLabelView.dart';
import 'package:flutter/material.dart';

class YLZRainBowPurchasePhotoCell extends StatefulWidget {
  Rs rs;

  YLZRainBowPurchasePhotoCell({Key? key, required this.rs}) : super(key: key);
  @override
  _YLZRainBowPurchasePhotoCellState createState() =>
      _YLZRainBowPurchasePhotoCellState();
}

class _YLZRainBowPurchasePhotoCellState
    extends State<YLZRainBowPurchasePhotoCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenW(context) - 30,
      margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: new Stack(
        children: <Widget>[
          Container(
            width: ScreenW(context) - 30,
            child: new Container(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    width: ScreenW(context) - 30 - 100,
                    child: Text(
                      "${widget.rs.title}",
                      style: TextStyle(
                          color: Color(YLZColorTitleTwo), fontSize: 16),
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  new Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
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
                  new Container(
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: Text(
                      "${widget.rs.time}截止报名",
                      style: TextStyle(
                          color: Color(YLZColorTitleThree), fontSize: 14),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(child: YLZRainBowBoxLabelView(boxStr: "采购需求")),
                ],
              ),
            ),
          ),
          Positioned(right: 0, top: 0, child: _buildIMV(widget.rs))
        ],
      ),
    );
  }

  Widget _buildIMV(Rs rs) {
    return Container(
      width: 100.0,
      height: 75,
      child: new FadeInImage.assetNetwork(
        placeholder: "assets/images/ylz_blank_rectangle.png",
        fadeInDuration: const Duration(seconds: 1), // 持续时间，默认 700 ms
        image: "${rs.bigImg}",
        fit: BoxFit.cover,
      ),
    );
  }
}
