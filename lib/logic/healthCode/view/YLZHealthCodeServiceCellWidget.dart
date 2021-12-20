import 'package:DartProject/base/config/YLZMacros.dart';
import 'package:DartProject/base/config/YLZStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class YLZHealthCodeServiceCellWidget extends StatelessWidget {
  ScrollController _scrollController = new ScrollController();
  YLZHealthCodeServiceCellWidget({Key? key}) : super(key: key);
  List<String> dataLists = [
    "健康报告",
    "为家人申领",
    "扫张贴码",
    "疫苗接种预约",
    "疫苗接种查询",
    "医保电子凭证",
    "申领张贴码",
    "申领机构张贴码",
    "通信行程卡",
    "疫情防控服务"
  ];
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        controller: _scrollController,
        slivers: _buildWidget(this.dataLists),
        reverse: false);
  }

  List<Widget> _buildWidget(List<String> dataLists) {
    List<Widget> widgetList = [];
    widgetList.add(_StickyHeaderGrid(
      dataLists: dataLists,
    ));
    return widgetList;
  }
}

class _StickyHeaderGrid extends StatelessWidget {
  final List<String> dataLists;
  const _StickyHeaderGrid({required this.dataLists, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
        sticky: false,
        header: Container(),
        sliver: SliverPadding(
          padding: EdgeInsets.all(0.0),
          sliver: buildSliverGrid(context),
        ));
  }

  SliverGrid buildSliverGrid(BuildContext context) {
    double cellWidth = (ScreenW(context) - 80) / 2;
    double desiredCellHeight = 36;
    double childAspectRatio = cellWidth / desiredCellHeight;
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 0.0,
          childAspectRatio: childAspectRatio),
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          String textString = this.dataLists[i];
          return buildCell(textString);
        },
        childCount: this.dataLists.length,
      ),
    );
  }

  Widget buildCell(String textString) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Row(
        children: [
          Container(
            child: Image.asset(
              'assets/images/ylz_mzt_star.png',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            child: Text(
              "${textString}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                color: Color(YLZColorTitleOne),
              ),
            ),
          )
        ],
      ),
    );
  }
}
