import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:flutter/material.dart';

class YLZHomeAlphaNavigationWidget extends StatefulWidget {
  final Key key;

  const YLZHomeAlphaNavigationWidget(this.key) : super(key: key);

  @override
  YLZHomeAlphaNavigationWidgetState createState() =>
      YLZHomeAlphaNavigationWidgetState();
}

class YLZHomeAlphaNavigationWidgetState
    extends State<YLZHomeAlphaNavigationWidget> {
  double opacityAlpha = 0.0;

  void changeHomeOpacity(double opacity) {
    setState(() {
      opacityAlpha = opacity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacityAlpha,
      child: Container(
        color: Color(YLZColorLightBlueView),
        width: ScreenW(context),
        height: StatusH(context) + NaviH,
        child: Column(
          children: [
            Container(width: ScreenW(context), height: StatusH(context)),
            Container(
                width: ScreenW(context),
                height: NaviH,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: Row(
                          children: [
                            Image.asset('assets/images/chs_logo_hsa.png')
                          ],
                        )),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
                      child: Image.asset(
                        'assets/images/ylz_message_logo.png',
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
