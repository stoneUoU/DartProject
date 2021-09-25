import 'dart:math';

import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:FlutterProject/logic/healthCode/view/YLZHealthCodeCheckWidget.dart';
import 'package:FlutterProject/logic/healthCode/view/YLZHealthCodeInfoWidget.dart';
import 'package:FlutterProject/logic/healthCode/view/YLZHealthCodeNavigationWidget.dart';
import 'package:FlutterProject/logic/healthCode/view/YLZHealthCodeServiceWidget.dart';
import 'package:FlutterProject/logic/healthCode/view/YLZHealthCodeSourceWidget.dart';
import 'package:FlutterProject/logic/healthCode/view/YLZHealthCodeWidget.dart';
import 'package:FlutterProject/logic/home/view/cell/elec/YLZElecCodeWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class YLZHealthCodeViewPage extends StatefulWidget {
  const YLZHealthCodeViewPage({Key? key}) : super(key: key);

  @override
  _YLZHealthCodeViewPageState createState() => _YLZHealthCodeViewPageState();
}

class _YLZHealthCodeViewPageState extends State<YLZHealthCodeViewPage> {
  GlobalKey<YLZElecCodeWidgetState> elecCodeWidgetStateKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //生产二维码：
    this.generateBarCode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    return new Container(
      child: Column(
        children: [
          YLZHealthCodeNavigationWidget(),
          new Container(
              width: ScreenW(context),
              height: ScreenH(context) -
                  (kBottomNavigationBarHeight + StatusH(context)),
              color: Color(YLZColorMZTBlueView),
              child: CustomScrollView(
                slivers: [
                  _StickyHeaderList(index: 0),
                  _StickyHeaderList(
                    index: 1,
                    stateKey: elecCodeWidgetStateKey,
                    clickListener: () {
                      this.generateBarCode();
                    },
                  ),
                  _StickyHeaderList(index: 2),
                  _StickyHeaderList(index: 3),
                  _StickyHeaderList(index: 4)
                ],
                reverse: false,
              ))
        ],
      ),
    );
  }

  Future generateBarCode() async {
    if (!mounted) return;
    await Future.delayed(const Duration(milliseconds: 500), () {
      elecCodeWidgetStateKey.currentState?.generateBarCode("${_randomBit(10)}");
      elecCodeWidgetStateKey.currentState?.generateCode("${_randomBit(10)}");
      // context.read<YLZCodeProvider>().setBarCodeBytes("${_randomBit(10)}");
      // context.read<YLZCodeProvider>().setCodeBytes("${_randomBit(10)}");
    });
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
}

typedef void _StickyHeaderListClickListener();

class _StickyHeaderList extends StatelessWidget {
  GlobalKey<State>? stateKey = GlobalKey();
  _StickyHeaderListClickListener? clickListener;
  _StickyHeaderList({Key? key, this.index, this.stateKey, this.clickListener})
      : super(key: key);
  final int? index;
  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      sticky: false,
      header: Container(
        color: Color(YLZColorMZTBlueView),
        width: ScreenW(context),
        height: index == 0 || index == 1 ? 0 : 12,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) {
            if (index == 0) {
              return YLZHealthCodeInfoWidget(
                  healthCodeInfoWidgetClickListener: (int intString) {
                if (intString == 0) {
                  print("支持功能");
                } else if (intString == 1) {
                  print("交易记录");
                } else {
                  print("使用记录");
                }
              });
            } else if (index == 1) {
              return YLZHealthCodeWidget();
            } else if (index == 2) {
              return YLZHealthCodeCheckWidget();
            } else if (index == 3) {
              return YLZHealthCodeServiceWidget();
            } else {
              return YLZHealthCodeSourceWidget();
            }
          },
          childCount: 1,
        ),
      ),
    );
  }
}
