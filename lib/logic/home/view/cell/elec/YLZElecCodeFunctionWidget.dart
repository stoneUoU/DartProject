import 'package:dart_demo/base/config/YLZMacros.dart';
import 'package:flutter/material.dart';

typedef void YLZElecCodeFunctionWidgetClickListener(int idStr);

class YLZElecCodeFunctionWidget extends StatelessWidget {
  final YLZElecCodeFunctionWidgetClickListener
      elecCodeFunctionWidgetClickListener;
  const YLZElecCodeFunctionWidget(
      {Key? key, required this.elecCodeFunctionWidgetClickListener})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
      width: ScreenW(context) - 32,
      height: 72,
      child: Card(
        elevation: 15.0,
        shadowColor: Colors.black38,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Image.asset(
                        'assets/images/ylz_elec_code_supporting.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Text("支持功能"),
                    )
                  ],
                ),
              ),
              onTap: () {
                if (this.elecCodeFunctionWidgetClickListener != null) {
                  this.elecCodeFunctionWidgetClickListener(0);
                }
              },
            ),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Image.asset(
                        'assets/images/ylz_elec_code_deal_record.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Text("交易记录"),
                    )
                  ],
                ),
              ),
              onTap: () {
                if (this.elecCodeFunctionWidgetClickListener != null) {
                  this.elecCodeFunctionWidgetClickListener(1);
                }
              },
            ),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Image.asset(
                        'assets/images/ylz_elec_code_use_record.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Text("使用记录"),
                    )
                  ],
                ),
              ),
              onTap: () {
                if (this.elecCodeFunctionWidgetClickListener != null) {
                  this.elecCodeFunctionWidgetClickListener(2);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
