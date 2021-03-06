import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:flutter/material.dart';

typedef void YLZHomeNavigationWidgetClickListener();

class YLZHomeNavigationWidget extends StatefulWidget {
  final Key key;
  final YLZHomeNavigationWidgetClickListener clickListener;
  const YLZHomeNavigationWidget(this.key, this.clickListener) : super(key: key);

  @override
  YLZHomeNavigationWidgetState createState() => YLZHomeNavigationWidgetState();
}

class YLZHomeNavigationWidgetState extends State<YLZHomeNavigationWidget> {
  double opacityAlpha = 1.0;

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
                            Image.asset('assets/images/chs_logo_hsa.png'),
                            Text(
                              " 国家医保服务平台",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            )
                          ],
                        )),
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
                        child: Image.asset(
                          'assets/images/ylz_message_logo.png',
                        ),
                      ),
                      onTap: () {
                        if (widget.clickListener != Null) {
                          widget.clickListener();
                        }
                      },
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
