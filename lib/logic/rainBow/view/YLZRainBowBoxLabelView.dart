import 'package:DartProject/base/config/YLZStyle.dart';
import 'package:flutter/material.dart';

class YLZRainBowBoxLabelView extends StatefulWidget {
  String boxStr = "";
  YLZRainBowBoxLabelView({Key? key, required this.boxStr}) : super(key: key);

  @override
  _YLZRainBowBoxLabelViewState createState() => _YLZRainBowBoxLabelViewState();
}

class _YLZRainBowBoxLabelViewState extends State<YLZRainBowBoxLabelView> {
  @override
  Widget build(BuildContext context) {
    return _makeBoxView(widget.boxStr);
  }

  Widget _makeBoxView(String boxStr) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: new Row(
        children: <Widget>[
          Container(
            width: 4.0,
            height: 18.0,
            color: Color(YLZColorTitleThree),
          ),
          Container(
            height: 18.0,
            padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
            decoration: new BoxDecoration(
                color: Color(white),
                border: new Border.all(
                  color: Color(YLZColorTitleThree),
                  width: 1.0,
                )),
            child: Center(
              child: Text(
                boxStr,
                style:
                    TextStyle(color: Color(YLZColorTitleThree), fontSize: 11),
              ),
            ),
          )
        ],
      ),
    );
  }
}
