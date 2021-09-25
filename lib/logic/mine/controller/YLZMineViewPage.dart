import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:FlutterProject/logic/area/model/YLZGeneralModel.dart';
import 'package:FlutterProject/logic/mine/view/YLZMineElecWidget.dart';
import 'package:FlutterProject/logic/mine/view/YLZMineHeaderWidget.dart';
import 'package:FlutterProject/logic/mine/view/YLZMineListWidget.dart';
import 'package:FlutterProject/logic/mine/view/YLZMineMemberWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class YLZMineViewPage extends StatefulWidget {
  const YLZMineViewPage({Key? key}) : super(key: key);

  @override
  _YLZMineViewPageState createState() => _YLZMineViewPageState();
}

class _YLZMineViewPageState extends State<YLZMineViewPage>
    with AutomaticKeepAliveClientMixin {
  List<YLZGeneralModel> modelList = [
    YLZGeneralModel.fromJson(
        {"picUrl": "ylz_mine_list_info", "title": "个人基本信息", "indexTag": 0}),
    YLZGeneralModel.fromJson(
        {"picUrl": "ylz_mine_list_notice", "title": "消息中心", "indexTag": 0}),
    YLZGeneralModel.fromJson(
        {"picUrl": "ylz_mine_list_help", "title": "帮助与反馈", "indexTag": 0}),
    YLZGeneralModel.fromJson(
        {"picUrl": "ylz_mine_list_about", "title": "关于", "indexTag": 0}),
    YLZGeneralModel.fromJson(
        {"picUrl": "ylz_mine_list_setting", "title": "设置", "indexTag": 0}),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            color: Color(YLZColorLightBlueView),
            width: ScreenW(context),
            height: StatusH(context),
          ),
          YLZMineHeaderWidget(),
          Expanded(
              child: Container(
            child: CustomScrollView(
              slivers: [
                _StickyHeaderList(index: 0),
                _StickyHeaderList(index: 1),
                _StickyHeaderList(
                  index: 2,
                  modelList: modelList,
                )
              ],
              reverse: false,
            ),
          ))
        ],
      ),
    ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class _StickyHeaderList extends StatelessWidget {
  GlobalKey<State>? stateKey = GlobalKey();
  _StickyHeaderList({Key? key, this.index, this.modelList}) : super(key: key);
  final int? index;
  List<YLZGeneralModel>? modelList;
  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      sticky: false,
      header: Container(
        color: Color(YLZColorTableSeparatorView),
        width: ScreenW(context),
        height: index == 0 ? 0 : 10,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) {
            if (index == 0) {
              return YLZMineElecWidget();
            } else if (index == 1) {
              return YLZMineMemberWidget();
            } else {
              return YLZMineListWidget(model: modelList?[i]);
            }
          },
          childCount: index == 2 ? modelList?.length : 1,
        ),
      ),
    );
  }
}
