import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:FlutterProject/logic/mguo/controller/mg_home_tab_page.dart';
import 'package:FlutterProject/logic/mguo/model/mg_home_nav_model.dart';
import 'package:FlutterProject/logic/mguo/view/mg_home_navigation_widget.dart';
import 'package:FlutterProject/logic/mguo/view/mg_top_tab_widget.dart';
import 'package:FlutterProject/net/dao/mg_home_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MGHomeViewPage extends StatefulWidget {
  const MGHomeViewPage({Key? key}) : super(key: key);

  @override
  _MGHomeViewPageState createState() => _MGHomeViewPageState();
}

class _MGHomeViewPageState extends State<MGHomeViewPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late Future _futureBuilderFuture;
  late TabController _controller;
  late List<MGHomeNavModel> modelList = [];
  GlobalKey<MGHomeNavigatorWidgetState> homeNavigatorWidgetStateKey =
      GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureBuilderFuture = _start();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: _futureBuilderFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<MGHomeNavModel> modelList =
                    snapshot.data! as List<MGHomeNavModel>;
                this.modelList = modelList;
                _controller =
                    TabController(length: modelList.length, vsync: this)
                      ..addListener(() {
                        if (_controller.index.toDouble() ==
                            _controller.animation!.value) {
                          //在这里切换顶部导航栏的视图：
                          homeNavigatorWidgetStateKey.currentState
                              ?.generateIndex(_controller.index);
                        }
                      });
                return Container(
                  width: ScreenW(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MGHomeNavigatorWidget(homeNavigatorWidgetStateKey),
                      Container(
                        color: Color(MGColorMainView),
                        width: ScreenW(context),
                        child: _tabBar(),
                      ),
                      Flexible(
                          child: Container(
                              color: Color(MGColorMainView),
                              child: TabBarView(
                                  controller: _controller,
                                  children: modelList.map((tab) {
                                    return MGHomeTabPage(model: tab);
                                  }).toList()))),
                    ],
                  ),
                );
              } else {
                return _buildSpinKitFadingCircle();
              }
            }));
  }

  ///自定义顶部tab
  _tabBar() {
    return MGTopTabWidget(
      modelList.map<Tab>((tab) {
        return Tab(
          text: tab.name,
        );
      }).toList(),
      controller: _controller,
      fontSize: 16,
      borderWidth: 3,
      unselectedLabelColor: Color(YLZColorTitleThree),
      insets: 0,
    );
  }

  Future _start() async {
    List<MGHomeNavModel> list = [];
    list = await MGHomeDao.navigator();
    return list;
  }

  Center _buildSpinKitFadingCircle() {
    return Center(child: SpinKitFadingCircle(
      itemBuilder: (_, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Colors.red : Colors.green,
          ),
        );
      },
    ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
