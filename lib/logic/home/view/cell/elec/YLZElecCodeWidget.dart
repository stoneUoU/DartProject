import 'package:barcode_widget/barcode_widget.dart';
import 'package:dart_demo/base/config/YLZMacros.dart';
import 'package:dart_demo/base/config/YLZStyle.dart';
import 'package:dart_demo/logic/home/view/cell/elec/YLZElecAreaWidget.dart';
import 'package:flutter/material.dart';

typedef void YLZElecCodeWidgetFreshClickListener();

class YLZElecCodeWidget extends StatefulWidget {
  final Key key;

  final YLZElecCodeWidgetFreshClickListener elecCodeWidgetFreshClickListener;

  const YLZElecCodeWidget(this.key,
      {required this.elecCodeWidgetFreshClickListener})
      : super(key: key);

  @override
  YLZElecCodeWidgetState createState() => YLZElecCodeWidgetState();
}

class YLZElecCodeWidgetState extends State<YLZElecCodeWidget> {
  String barCodeBytes = "";

  String codeBytes = "";

  void generateBarCode(String barCodeByte) {
    setState(() {
      barCodeBytes = barCodeByte;
    });
  }

  void generateCode(String codeByte) {
    setState(() {
      codeBytes = codeByte;
    });
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
      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
      width: ScreenW(context) - 32,
      height: 345,
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
                    width: ScreenW(context) - 120,
                    height: 64,
                    margin: EdgeInsets.fromLTRB(0, 32, 0, 0),
                    child: BarcodeWidget(
                      barcode: Barcode.code128(),
                      data: barCodeBytes,
                      drawText: false,
                    ),
                  ),
                  Container(
                      width: 120,
                      height: 120,
                      margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          BarcodeWidget(
                            barcode: Barcode.qrCode(
                              errorCorrectLevel: BarcodeQRCorrectionLevel.high,
                            ),
                            data: codeBytes,
                            width: 120,
                            height: 120,
                          ),
                          Container(
                            color: Colors.white,
                            width: 20,
                            height: 20,
                            child: Image.asset(
                              'assets/images/ylz_elec_code_small_logo.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      )),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/ylz_elec_code_fresh.png',
                          fit: BoxFit.fill,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(6, 0, 6, 0),
                          child: Text("每隔1分钟自动"),
                        ),
                        InkWell(
                          child: Container(
                            child: Text(
                              "刷新",
                              style: TextStyle(
                                  color: Color(YLZColorLightBlueView)),
                            ),
                          ),
                          onTap: () {
                            if (widget.elecCodeWidgetFreshClickListener !=
                                null) {
                              widget.elecCodeWidgetFreshClickListener();
                            }
                          },
                        )
                      ],
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
                        onTap: () {
                          print("AAA");
                          showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (BuildContext context) {
                                return YLZElecAreaWidget();
                              });
                        },
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
