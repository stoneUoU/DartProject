import 'package:barcode_widget/barcode_widget.dart';
import 'package:dart_demo/base/config/YLZMacros.dart';
import 'package:dart_demo/base/config/YLZStyle.dart';
import 'package:dart_demo/provider/YLZCodeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef void YLZElecCodeWidgetFreshClickListener();

class YLZElecCodeProviderWidget extends StatelessWidget {
  final YLZElecCodeWidgetFreshClickListener? elecCodeWidgetFreshClickListener;

  YLZElecCodeProviderWidget(this.elecCodeWidgetFreshClickListener);

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
                      data: '${context.watch<YLZCodeProvider>().barCodeBytes}',
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
                            data:
                                '${context.watch<YLZCodeProvider>().codeBytes}',
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
                            if (this.elecCodeWidgetFreshClickListener != null) {
                              this.elecCodeWidgetFreshClickListener!();
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
