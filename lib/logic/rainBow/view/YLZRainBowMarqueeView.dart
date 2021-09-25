import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:FlutterProject/logic/rainBow/model/YLZRainBowRotationModel.dart';
import 'package:flutter/material.dart';

class YLZRainBowMarqueeView extends StatefulWidget {
  List newLists = [];
  YLZRainBowMarqueeView({Key? key, required this.newLists}) : super(key: key);
  @override
  _YLZRainBowMarqueeView createState() => _YLZRainBowMarqueeView();
}

class _YLZRainBowMarqueeView extends State<YLZRainBowMarqueeView> {
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        width: ScreenW(context) - 30.0,
        height: 30.0,
        decoration: new BoxDecoration(
          color: Color(YLZColorTableSeparatorView),
          border: new Border.all(
            color: Color(YLZColorTableSeparatorView),
            width: 1.0,
          ),
          borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
        ),
        child: new Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: new Image.asset('assets/images/fastReport.png'),
            ),
            Container(
                height: 30,
                //这个跑马灯我看很强:
                child: Container()
                // FlutterMarquee(
                //     children: _makeMarquee(widget.newLists),
                //     onChange: (i) {
                //       print(i);
                //     },
                //     duration: 4),
                )
          ],
        ));
  }

  List<Widget> _makeMarquee(List newLists) {
    List<Widget> widgetList = [];
    for (var i = 0; i < newLists.length; i++) {
      NewsList newsList = newLists[i];
      widgetList.add(Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          width: ScreenW(context) - 30.0 - 45.0 - 30,
          alignment: Alignment.centerLeft,
          child: Text(
            newsList.news!,
            style: TextStyle(color: Colors.black, fontSize: 14),
            textAlign: TextAlign.left,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )));
    }
    return widgetList;
  }
}
