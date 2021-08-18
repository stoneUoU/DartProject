import 'package:dart_demo/base/config/YLZMacros.dart';
import 'package:dart_demo/base/config/YLZStyle.dart';
import 'package:dart_demo/logic/mguo/controller/mg_home_tab_page.dart';
import 'package:dart_demo/logic/mguo/model/mg_home_nav_model.dart';
import 'package:dart_demo/logic/mguo/view/HiTab.dart';
import 'package:dart_demo/logic/mguo/view/mg_home_navigation_widget.dart';
import 'package:dart_demo/net/dao/mg_home_dao.dart';
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
  late List<Mg_home_nav_model> modelList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: modelList.length, vsync: this);
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
                List<Mg_home_nav_model> modelList =
                    snapshot.data! as List<Mg_home_nav_model>;
                this.modelList = modelList;
                _controller =
                    TabController(length: modelList.length, vsync: this);
                return Container(
                  width: ScreenW(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MGHomeNavigatorWidget(),
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
    return HiTab(
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
    List<Mg_home_nav_model> list = [];
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
