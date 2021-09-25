import 'dart:async';

import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:FlutterProject/base/view/YLZSeparatorView.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class YLZHealthCodeWidget extends StatefulWidget {
  const YLZHealthCodeWidget({Key? key}) : super(key: key);
  @override
  _YLZHealthCodeWidgetState createState() => _YLZHealthCodeWidgetState();
}

class _YLZHealthCodeWidgetState extends State<YLZHealthCodeWidget> {
  codeLinearGradient({bool fromTop = false}) {
    return LinearGradient(
        begin: fromTop ? Alignment.topCenter : Alignment.bottomCenter,
        end: fromTop ? Alignment.bottomCenter : Alignment.topCenter,
        colors: [
          Color(YLZColorMZTGradientOneView),
          Color(YLZColorMZTGradientTwoView),
          Color(YLZColorMZTGradientThreeView)
        ]);
  }

  String fireTime() {
    DateTime dateTime = DateTime.now();
    return dateTime.toString().substring(0, 19);
  }

  String timeString = "";
  late Timer timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    const timeout = const Duration(seconds: 1);
    this.timer = Timer.periodic(timeout, (timer) {
      if (!mounted) return;
      setState(() {
        this.timeString = "${fireTime()}";
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    this.timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenW(context) - 32,
      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
      ),
      height: 467,
      child: Stack(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: "健康状况核验 ",
                              style: TextStyle(
                                color: Color(YLZColorTitleOne),
                                fontSize: 18,
                              )),
                          TextSpan(
                            text: "未见异常【绿码】",
                            style: TextStyle(
                                color: Color(YLZColorMZTGreenView),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: Text(
                    "${this.timeString}".length == 0
                        ? "${fireTime()}"
                        : "${this.timeString}",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12),
                  width: 240,
                  height: 240,
                  decoration: new BoxDecoration(
                    gradient: codeLinearGradient(fromTop: true),
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(10.0)),
                  ),
                  child: Center(
                    child: Container(
                        width: 230,
                        height: 230,
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(10.0)),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            BarcodeWidget(
                              decoration: new BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    new Radius.circular(10.0)),
                              ),
                              color: Color(YLZColorMZTGreenView),
                              barcode: Barcode.qrCode(
                                errorCorrectLevel:
                                    BarcodeQRCorrectionLevel.high,
                              ),
                              data: "3623241996****6010",
                              width: 218,
                              height: 218,
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(3.0),
                                child: Image.asset(
                                  'assets/images/ylz_mzt_logo.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: Text(
                    "6 5 2 3 4 5 8 9 0",
                    style: TextStyle(
                      color: Color(YLZColorTitleOne),
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 136,
                        height: 32,
                        decoration: new BoxDecoration(
                          color: Color(YLZColorMZTLightBlueView),
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(16.0)),
                        ),
                        child: Center(
                          child: Text(
                            "创建桌面快捷方式",
                            style: TextStyle(
                              color: Color(YLZColorMZTBlueView),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 136,
                        height: 32,
                        decoration: new BoxDecoration(
                          color: Color(YLZColorMZTLightGoldView),
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(16.0)),
                        ),
                        child: Center(
                          child: Text(
                            "接种新冠疫苗x2",
                            style: TextStyle(
                              color: Color(YLZColorGoldView),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: YLZSeparatorView(color: Color(YLZColorLine)),
                  height: 1.0,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: InkWell(
                          child: Center(
                            child: Text(
                              "家人健康码",
                              style: TextStyle(
                                color: Color(YLZColorMZTBlueView),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: InkWell(
                          child: Center(
                            child: Text(
                              "在线咨询",
                              style: TextStyle(
                                color: Color(YLZColorMZTBlueView),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: InkWell(
                          child: Center(
                            child: Text(
                              "人工客服",
                              style: TextStyle(
                                color: Color(YLZColorMZTBlueView),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: Container(
                child: Image.asset(
              'assets/images/ylz_mzt_left.png',
              fit: BoxFit.fill,
            )),
            top: 80,
            left: 0,
          ),
          Positioned(
            child: Container(
                child: Image.asset(
              'assets/images/ylz_mzt_right.png',
              fit: BoxFit.fill,
            )),
            top: 80,
            right: 0,
          )
        ],
      ),
    );
  }
}
