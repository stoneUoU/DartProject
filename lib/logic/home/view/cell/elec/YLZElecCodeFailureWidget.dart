import 'package:dart_demo/base/config/YLZMacros.dart';
import 'package:dart_demo/base/config/YLZStyle.dart';
import 'package:flutter/material.dart';

class YLZElecCodeFailureWidget extends StatefulWidget {
  const YLZElecCodeFailureWidget({Key? key}) : super(key: key);

  @override
  _YLZElecCodeFailureWidgetState createState() =>
      _YLZElecCodeFailureWidgetState();
}

class _YLZElecCodeFailureWidgetState extends State<YLZElecCodeFailureWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
      width: ScreenW(context) - 32,
      child: Card(
        elevation: 15.0,
        shadowColor: Colors.black38,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: ScreenW(context) - 32,
                    color: Color(YLZColorLightGoldView),
                    margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 6, 16, 6),
                      child: Text.rich(
                        TextSpan(children: [
                          TextSpan(
                              text: "您已激活医保电子凭证，但系统未查询到 \n您的有效参保记录 ",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color(YLZColorGoldView))),
                          WidgetSpan(
                              child: Padding(
                            padding: EdgeInsets.only(bottom: 2),
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 12.0,
                              color: Color(YLZColorGoldView),
                            ),
                          )),
                        ]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    width: 88,
                    height: 88,
                    child: Image.asset(
                      'assets/images/ylz_failure_image.png',
                      fit: BoxFit.fill,
                    ),
                    margin: EdgeInsets.fromLTRB(0, 32, 0, 0),
                  ),
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(YLZColorLightBlueView),
                        borderRadius: BorderRadius.all(Radius.circular(22.0)),
                      ),
                      height: 44,
                      width: ScreenW(context) - 72,
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(0, 32, 0, 0),
                      child: Text(
                        "领取电子凭证",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: Text(
                      "领取电子凭证后\n可以使用更多医保功能",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(YLZColorTitleTwo)),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 18),
              height: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: Color(YLZColorLine),
                    height: 1.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 12),
                        child: Text(
                          '医保账户 ',
                          style: const TextStyle(
                              color: Color(YLZColorTitleOne), fontSize: 16),
                        ),
                        height: 49,
                      ),
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(right: 12),
                          child: Row(
                            children: [
                              Text(
                                '厦门市市本级 ',
                                style: const TextStyle(
                                    color: Color(YLZColorTitleOne),
                                    fontSize: 16),
                              ),
                              Image.asset(
                                'assets/images/ylz_arrow_right.png',
                                width: 12,
                                height: 12,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
