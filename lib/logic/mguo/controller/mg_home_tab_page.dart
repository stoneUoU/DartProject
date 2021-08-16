import 'dart:convert';

import 'package:dart_demo/logic/mguo/model/mg_home_model.dart';
import 'package:dart_demo/logic/mguo/model/mg_home_nav_model.dart';
import 'package:dart_demo/net/dao/mg_home_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MGHomeTabPage extends StatefulWidget {
  final Mg_home_nav_model model;

  const MGHomeTabPage({Key? key, required this.model}) : super(key: key);

  @override
  _MGHomeTabPageState createState() => _MGHomeTabPageState();
}

class _MGHomeTabPageState extends State<MGHomeTabPage> {
  @override
  void initState() {
    super.initState();
    _start(widget.model.id ?? 0);
  }

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return contentChild;
  }

  get contentChild => StaggeredGridView.countBuilder(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      crossAxisCount: 1,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        //有banner时第一个item位置显示banner
        return Container(
          child: Text("AAAAAAAAA"),
          color: Colors.red,
        );
      },
      staggeredTileBuilder: (int index) {
        if (index == 0) {
          return StaggeredTile.fit(2);
        } else {
          return StaggeredTile.fit(1);
        }
      });

  Future _start(int id) async {
    Mg_home_model model;
    model = await MGHomeDao.dataLists(id);
    print("model_____${json.encode(model)}");
    return model;
  }
}
