import 'dart:math';

import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:FlutterProject/base/view/YLZSeparatorView.dart';
import 'package:FlutterProject/logic/healthCode/view/YLZHealthCodeTimerWidget.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class YLZHealthCodeWidget extends StatefulWidget {
  final Key key;
  const YLZHealthCodeWidget(this.key) : super(key: key);
  @override
  YLZHealthCodeWidgetState createState() => YLZHealthCodeWidgetState();
}

class YLZHealthCodeWidgetState extends State<YLZHealthCodeWidget> {
  /**
   * 0 : 绿码
   * 1 : 橙码
   * 2 : 红码
   */
  int clickNum = 0;
  void generateClickNum(int clickNum) {
    setState(() {
      this.clickNum = clickNum;
    });
  }

  //生成提示文字：
  TextSpan generateLabel() {
    switch (this.clickNum) {
      case 0:
        return TextSpan(
          text: "未见异常【绿码】",
          style: TextStyle(
              color: Color(YLZColorMZTGreenView),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        );
      case 1:
        return TextSpan(
          text: "建议隔离【橙码】",
          style: TextStyle(
              color: Color(YLZColorMZTOrangeView),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        );
      default:
        return TextSpan(
          text: "强制隔离【红码】",
          style: TextStyle(
              color: Color(YLZColorMZTRedView),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        );
    }
  }

  Color generateColor() {
    switch (this.clickNum) {
      case 0:
        return Color(YLZColorMZTGreenView);
      case 1:
        return Color(YLZColorMZTOrangeView);
      default:
        return Color(YLZColorMZTRedView);
    }
  }

  String _randomBit(int len) {
    String scopeF = '123456789'; //首位
    String scopeC = '0123456789'; //中间
    String result = '';
    for (int i = 0; i < len; i++) {
      if (i == 0) {
        result = scopeF[Random().nextInt(scopeF.length)];
      } else {
        result = result + scopeC[Random().nextInt(scopeC.length)];
      }
    }
    return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
                          generateLabel(),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: YLZHealthCodeTimerWidget(),
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
                              color: generateColor(),
                              barcode: Barcode.qrCode(
                                errorCorrectLevel:
                                    BarcodeQRCorrectionLevel.high,
                              ),
                              data: "${_randomBit(100)}",
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
                    "${_randomBit(18)}",
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
}
