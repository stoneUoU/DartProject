import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:flutter/material.dart';

//flutter闭包与android类似的
enum YLZPlacHolderViewType {
  noNetwork, // 0
  noGoods, // 1
  noOrders, // 2
}

typedef void OnPlaceHolderViewClickListener(YLZPlacHolderViewType viewType);

class YLZPlaceHolderView extends StatelessWidget {
  final YLZPlacHolderViewType viewType;

  final OnPlaceHolderViewClickListener onPlaceHolderViewClickListener;

  String picStr = "";

  String tipsStr = "";

  String btnStr = "";

  YLZPlaceHolderView(
      {Key? key,
      required this.onPlaceHolderViewClickListener,
      required this.viewType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //先设置图片、文字
    _setStr();
    return new Container(
      child: Column(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: new Center(child: new Image.asset(picStr)),
          ),
          new Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: new Center(
              child: new Text(tipsStr,
                  style: new TextStyle(
                      fontSize: 16.0, color: Color(YLZColorTitleOne)),
                  textAlign: TextAlign.center),
            ),
          ),
          new Container(
            margin: EdgeInsets.fromLTRB((ScreenW(context) - 200) / 2, 30,
                (ScreenW(context) - 200) / 2, 0),
            height: 45,
            width: 200,
            child: new RaisedButton(
              onPressed: () {
                if (onPlaceHolderViewClickListener != null) {
                  onPlaceHolderViewClickListener(viewType);
                }
              },
              shape: StadiumBorder(),
              child: new Text(btnStr,
                  style: TextStyle(fontSize: 16.0, color: Colors.white)),
              color: Color(YLZColorLightBlueView),
            ),
          )
        ],
      ),
    );
  }

  _setStr() {
    if (viewType == YLZPlacHolderViewType.noNetwork) {
      picStr = "assets/images/noNet.png";
    } else if (viewType == YLZPlacHolderViewType.noGoods) {
      picStr = "assets/images/noShopCart.png";
    } else {
      picStr = "assets/images/noShopCart.png";
    }

    if (viewType == YLZPlacHolderViewType.noNetwork) {
      tipsStr = "亲，网络不佳丫";
    } else if (viewType == YLZPlacHolderViewType.noGoods) {
      tipsStr = "暂无订单";
    } else {
      tipsStr = "暂无订单";
    }

    if (viewType == YLZPlacHolderViewType.noNetwork) {
      btnStr = "点击重试";
    } else if (viewType == YLZPlacHolderViewType.noGoods) {
      btnStr = "重新加载";
    } else {
      btnStr = "重新加载";
    }
  }
//this.onHomeItemClickListener(homeMs.reportId);
}
