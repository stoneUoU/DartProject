import 'package:dart_demo/base/config/YLZMacros.dart';
import 'package:flutter/material.dart';

import 'YLZHomeAlphaNavigationWidget.dart';
import 'YLZHomeNavigationWidget.dart';
import 'YLZHomeSearchWidget.dart';

class YLZHomeNavigationWithSearchWidget extends StatefulWidget {
  final Key key;
  final YLZHomeNavigationWidgetClickListener clickListener;
  const YLZHomeNavigationWithSearchWidget(this.key, this.clickListener)
      : super(key: key);

  @override
  YLZHomeNavigationWithSearchWidgetState createState() =>
      YLZHomeNavigationWithSearchWidgetState();
}

class YLZHomeNavigationWithSearchWidgetState
    extends State<YLZHomeNavigationWithSearchWidget> {
  GlobalKey<YLZHomeAlphaNavigationWidgetState> homeAlphaNavigationKey =
      GlobalKey();
  GlobalKey<YLZHomeNavigationWidgetState> homeNavigationKey = GlobalKey();

  GlobalKey<YLZHomeSearchWidgetState> homeSearchKey = GlobalKey();

  double topMargin = 0.0;
  void changeHomeOpacity(double homeAplhaOpacity, double aplhaOpacity) {
    //偏移量>导航栏的高度
    homeAlphaNavigationKey.currentState?.changeHomeOpacity(homeAplhaOpacity);
    homeNavigationKey.currentState?.changeHomeOpacity(aplhaOpacity);
    homeSearchKey.currentState?.changeHeightRatio(homeAplhaOpacity);
  }

  void changeOffset(double offset) {
    setState(() {
      print("滑动距离+++++$offset");
      topMargin = offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
          children: [
            Stack(
              children: [
                YLZHomeAlphaNavigationWidget(homeAlphaNavigationKey),
                Positioned(
                    top: 0,
                    left: 0,
                    child: YLZHomeNavigationWidget(
                        homeNavigationKey, widget.clickListener))
              ],
            ),
            Positioned(
                child: YLZHomeSearchWidget(homeSearchKey),
                top: StatusH(context) + NaviH - topMargin,
                left: 0)
          ],
        ),
        width: ScreenW(context),
        height: StatusH(context) + NaviH + 44);
  }
}
