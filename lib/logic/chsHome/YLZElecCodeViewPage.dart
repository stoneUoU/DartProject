import 'dart:math';

import 'package:DartProject/base/config/YLZMacros.dart';
import 'package:DartProject/base/navigator/HiNavigator.dart';
import 'package:DartProject/logic/chsHome/view/cell/elec/YLZElecCodeBannerWidget.dart';
import 'package:DartProject/logic/chsHome/view/cell/elec/YLZElecCodeCarouselWidget.dart';
import 'package:DartProject/logic/chsHome/view/cell/elec/YLZElecCodeFunctionWidget.dart';
import 'package:DartProject/logic/chsHome/view/cell/elec/YLZElecCodeWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class YLZElecCodeViewPage extends StatefulWidget {
  const YLZElecCodeViewPage({Key? key}) : super(key: key);

  @override
  _YLZElecCodeViewPageState createState() => _YLZElecCodeViewPageState();
}

class _YLZElecCodeViewPageState extends State<YLZElecCodeViewPage> {
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
      appBar: AppBar(
        //让title居左
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        leading: BackButton(onPressed: () {
          // HiNavigator().onJumpTo(RouteStatus.home);
          HiNavigator().pop(context);
        }),
        title: Text(
          "返回",
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 32),
              alignment: Alignment.center,
              child: Image.asset('assets/images/ylz_elec_code_dot.png',
                  fit: BoxFit.fill),
            ),
          )
        ],
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return new Container(
        width: ScreenW(context),
        height: ScreenH(context) -
            (kToolbarHeight + StatusH(context) + TabbarSafeBottomM(context)),
        color: Colors.white,
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
            _StickyHeaderList(index: 3)
          ],
          reverse: false,
        ));
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
        color: Colors.white,
        width: ScreenW(context),
        height: index == 1 ? 0 : 10,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) {
            if (index == 0) {
              return YLZElecCodeBannerWidget();
            } else if (index == 1) {
              // return YLZElecCodeProviderWidget(() {
              //   if (this.clickListener != null) {
              //     this.clickListener!();
              //   }
              // });
              return YLZElecCodeWidget(stateKey!,
                  elecCodeWidgetFreshClickListener: () {
                if (this.clickListener != null) {
                  this.clickListener!();
                }
              });
              // return YLZElecCodeFailureWidget();
            } else if (index == 2) {
              return YLZElecCodeFunctionWidget(
                  elecCodeFunctionWidgetClickListener: (int intString) {
                if (intString == 0) {
                  print("支持功能");
                } else if (intString == 1) {
                  print("交易记录");
                } else {
                  print("使用记录");
                }
              });
            } else {
              return YLZElecCodeCarouselWidget(
                  elecCodeCarouselWidgetClickListener: (int intString) {});
            }
          },
          childCount: 1,
        ),
      ),
    );
  }
}
