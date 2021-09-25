import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
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
      decoration: BoxDecoration(
        boxShadow: [
          //阴影效果
          BoxShadow(
            offset: Offset(0, 0), //阴影在X轴和Y轴上的偏移
            color: Color(YLZColorBackGround), //阴影颜色
            blurRadius: 3.0, //阴影程度
            spreadRadius: 5, //阴影扩散的程度 取值可以正数,也可以是负数
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: EdgeInsets.fromLTRB(16, 5, 16, 5),
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      width: ScreenW(context) - 32,
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
    );
  }
}
