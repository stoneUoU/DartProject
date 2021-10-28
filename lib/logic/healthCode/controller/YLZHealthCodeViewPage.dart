import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:FlutterProject/logic/healthCode/view/YLZHealthCodeCheckWidget.dart';
import 'package:FlutterProject/logic/healthCode/view/YLZHealthCodeInfoWidget.dart';
import 'package:FlutterProject/logic/healthCode/view/YLZHealthCodeNavigationWidget.dart';
import 'package:FlutterProject/logic/healthCode/view/YLZHealthCodeServiceWidget.dart';
import 'package:FlutterProject/logic/healthCode/view/YLZHealthCodeSourceWidget.dart';
import 'package:FlutterProject/logic/healthCode/view/YLZHealthCodeWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class YLZHealthCodeViewPage extends StatefulWidget {
  const YLZHealthCodeViewPage({Key? key}) : super(key: key);
  @override
  _YLZHealthCodeViewPageState createState() => _YLZHealthCodeViewPageState();
}

class _YLZHealthCodeViewPageState extends State<YLZHealthCodeViewPage> {
  GlobalKey<YLZHealthCodeWidgetState> healthCodeWidgetStateKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
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
          YLZHealthCodeNavigationWidget(clickListener: (int index) {
            Navigator.pop(context);
          }),
          new Container(
              width: ScreenW(context),
              height: ScreenH(context) -
                  (kBottomNavigationBarHeight + StatusH(context)),
              color: Color(YLZColorMZTBlueView),
              child: CustomScrollView(
                slivers: [
                  _StickyHeaderList(
                      index: 0,
                      clickListener: (int clickNum) {
                        this.generateClickNum(clickNum);
                      }),
                  _StickyHeaderList(
                    index: 1,
                    stateKey: this.healthCodeWidgetStateKey,
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

  void generateClickNum(int intString) {
    this.healthCodeWidgetStateKey.currentState?.generateClickNum(intString);
  }
}

typedef void _StickyHeaderListClickListener(int intString);

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
                if (this.clickListener != null) {
                  this.clickListener!(intString);
                }
                // context.read<YLZHealthCodeProvider>().setClickNum(intString);
              });
            } else if (index == 1) {
              return YLZHealthCodeWidget(stateKey!);
              // return YLZHealthCodeProviderWidget();
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
