import 'package:DartProject/base/config/YLZMacros.dart';
import 'package:DartProject/base/config/YLZStyle.dart';
import 'package:DartProject/logic/rainBow/model/YLZReportModel.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//flutter闭包与android类似的

typedef void OnYLZReportListCellClickListener(int reportId);

class YLZReportListCell extends StatelessWidget {
  final OnYLZReportListCellClickListener onYLZReportListCellClickListener;

  final YLZReportModel model;

  const YLZReportListCell(
      {Key? key,
      required this.onYLZReportListCellClickListener,
      required this.model})
      : super(key: key);

  void _launchURL(String url, BuildContext context) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 按下
        this.onYLZReportListCellClickListener(model.reportId ?? 0);
      },
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            new Container(
                height: 265,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                width: ScreenW(context), //- 30.0,
                child: new FadeInImage.assetNetwork(
                  placeholder: "assets/images/ylz_blank_rectangle.png",
                  fadeInDuration: const Duration(seconds: 1), // 持续时间，默认 700 ms
                  image: model.cover ?? "",
                  fit: BoxFit.cover,
                )),
            new Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              width: ScreenW(context),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(15.0, 8.0, 0.0, 8.0),
                    width: ScreenW(context) - 30.0 - 80.0,
                    child: Text(
                      model.title ?? "",
                      style: TextStyle(color: Colors.black, fontSize: 15.0),
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0.0, 8.0, 15.0, 8.0),
//										color:Colors.greenAccent,
                    width: 80.0,
                    child: Text(
                      "￥${model.salePrice}/元",
                      style: TextStyle(color: Colors.red, fontSize: 15.0),
                      maxLines: 1,
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15.0, 0, 15.0, 8.0),
              width: ScreenW(context) - 30.0,
              child: Text(
                model.description ?? "",
                style: TextStyle(color: Colors.black54, fontSize: 12.0),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
                width: ScreenW(context),
                height: 10,
                color: Color(YLZColorTableSeparatorView))
          ],
        ),
      ),
    );
  }
}
