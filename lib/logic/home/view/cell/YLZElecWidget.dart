import 'package:dart_demo/base/config/YLZMacros.dart';
import 'package:dart_demo/base/config/YLZStyle.dart';
import 'package:dart_demo/logic/home/model/YLZModuleModel.dart';
import 'package:flutter/material.dart';

class YLZElecWidget extends StatelessWidget {
  HomePage? homePage;

  YLZElecWidget(
    this.homePage, {
    Key? key,
    required this.cellWidth,
    required this.desiredCellHeight,
  }) : super(key: key);

  final double cellWidth;
  final double desiredCellHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: FadeInImage.assetNetwork(
            placeholder: "assets/images/ylz_blank_rectangle.png",
            image: homePage?.imgUrl ?? "",
            fit: BoxFit.fill,
            width: cellWidth,
            height: desiredCellHeight,
          ),
        ),
        Positioned(
            top: StatusH(context) + NaviH + 44 + 18,
            left: 16,
            child: Container(
                width: ScreenW(context) - 32,
                height: 182,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 146,
                              margin: EdgeInsets.only(top: 1),
                              width: ScreenW(context) - 34,
                              child: Image.asset(
                                'assets/images/ylz_elec_code.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                            Positioned(
                              child: Container(
                                child: Image.asset(
                                  'assets/images/ylz_arrow_right.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              right: 16,
                              bottom: 36,
                            ),
                            Positioned(
                              child: Container(
                                child: Text(
                                  "林磊      362324*******6010",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              left: 16,
                              bottom: 36,
                            )
                          ],
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 16),
                                child: Text("医保个人账户余额（元）"),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        "3000.00  ",
                                        style:
                                            TextStyle(color: Color(colorC20)),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 16),
                                      child: Image.asset(
                                        'assets/images/ylz_eye_open.png',
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Positioned(
                        top: 12,
                        left: 16,
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                  child: Image.asset(
                                'assets/images/ylz_logo.png',
                                fit: BoxFit.fill,
                              )),
                              Container(
                                margin: EdgeInsets.only(left: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("国家医疗保障局监制",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.black26,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800)),
                                    Text(
                                      "医保电子凭证",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w800),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                    Positioned(
                        child: Opacity(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                            ),
                            height: 24,
                            child: Row(
                              children: [
                                Container(
                                  child: Text(
                                    "参保地  ",
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                  margin: EdgeInsets.only(left: 16),
                                ),
                                Container(
                                  child: Image.asset(
                                    'assets/images/ylz_arrow_right.png',
                                    fit: BoxFit.fill,
                                  ),
                                  margin: EdgeInsets.only(right: 8),
                                ),
                              ],
                            ),
                          ),
                          opacity: 0.6,
                        ),
                        right: 16,
                        top: 24),
                  ],
                ))),
        Positioned(
          child: Container(
            width: ScreenW(context) - 64,
            height: 96,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Image.asset(
                            'assets/images/ylz_home_scan.png',
                            fit: BoxFit.fill,
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Text(
                            "扫一扫",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ))
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Image.asset(
                            'assets/images/ylz_home_qrcode.png',
                            fit: BoxFit.fill,
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Text("二维码",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)))
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Image.asset(
                            'assets/images/ylz_home_care.png',
                            fit: BoxFit.fill,
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Text(
                            "关怀版",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
          left: 32,
          bottom: 0,
        )
      ],
    );
  }
}
