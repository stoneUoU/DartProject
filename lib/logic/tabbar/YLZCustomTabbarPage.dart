import 'package:dart_demo/base/config/YLZMacros.dart';
import 'package:dart_demo/base/config/YLZStyle.dart';
import 'package:dart_demo/logic/home/YLZHomeViewPage.dart';
import 'package:dart_demo/logic/login/YLZCodeLoginPage.dart';
import 'package:dart_demo/logic/rainBow/YLZRainBowPage.dart';
import 'package:dart_demo/provider/YLZTabbarProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_bottom_tab_bar/flutter_custom_bottom_tab_bar.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class YLZCustomTabBarPage extends StatefulWidget {
  YLZCustomTabBarPage({Key? key}) : super(key: key);

  @override
  _YLZCustomTabBarPageState createState() => _YLZCustomTabBarPageState();
}

class _YLZCustomTabBarPageState extends State<YLZCustomTabBarPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  var titles = ['首页', '发现', '我的'];
  final log = Logger();
  @override
  void initState() {
    super.initState();
    _tabController =
        new TabController(vsync: this, initialIndex: 0, length: titles.length);
    _tabController.addListener(() {
      context.read<YLZTabbarProvider>().setSelectedIndex(_tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          height: kBottomNavigationBarHeight + TabbarSafeBottomM(context),
          child: Column(
            children: <Widget>[
              Divider(
                height: 2,
              ),
              new TabBar(
                isScrollable: false,
                controller: _tabController,
                indicatorColor: Colors.transparent,
                labelColor: Colors.red,
                labelPadding: EdgeInsets.all(0),
                unselectedLabelColor: Colors.black54,
                tabs: buildAllTabs(),
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(), //设置滑动的效果，这个禁用滑动
          controller: _tabController,
          children: <Widget>[
            YLZHomeViewPage(onJumpTo: (int i) {}),
            YLZRainBowPage(),
            YLZCodeLoginPage()
          ],
        ));
  }

  List<Widget> buildAllTabs() {
    int selectedIndex = context.watch<YLZTabbarProvider>().selectedIndex;
    return <Widget>[
      buildHomeEachTab(selectedIndex),
      buildShopCartEachTab(selectedIndex),
      buildMineEachTab(selectedIndex),
    ];
  }

  EachTab buildMineEachTab(int selectedIndex) {
    return EachTab(
        width: 70,
        height: 48,
        padding: EdgeInsets.all(0),
        icon: selectedIndex == 2
            ? Image.asset(
                'assets/images/mine_icon_mine_click.png',
                width: 20,
                height: 20,
              )
            : Image.asset(
                'assets/images/mine_icon_mine_onclick.png',
                width: 20,
                height: 20,
              ),
        text: titles[2],
        iconPadding: EdgeInsets.fromLTRB(0, 4, 0, 2),
        textStyle: TextStyle(
            fontSize: 10,
            color: selectedIndex == 2 ? Colors.red : Color(YLZColorTitleTwo)));
  }

  EachTab buildShopCartEachTab(int selectedIndex) {
    return EachTab(
      height: 40,
      padding: EdgeInsets.all(0),
      icon: selectedIndex == 1
          ? Image.asset(
              'assets/images/icon_shoppingcar_click.png',
              width: 20,
              height: 20,
            )
          : Image.asset(
              'assets/images/icon_shoppingcar_onclick.png',
              width: 20,
              height: 20,
            ),
      text: titles[1],
      iconPadding: EdgeInsets.fromLTRB(0, 4, 0, 2),
      textStyle: TextStyle(
          fontSize: 10,
          color: selectedIndex == 1 ? Colors.red : Color(YLZColorTitleTwo)),
    );
  }

  EachTab buildHomeEachTab(int selectedIndex) {
    return EachTab(
        width: 70,
        badgeNo: '8',
        badgeColor: Colors.red,
        height: 48,
        padding: EdgeInsets.all(0),
        icon: selectedIndex == 0
            ? Image.asset(
                'assets/images/mine_icon_store_click.png',
                width: 20,
                height: 20,
              )
            : Image.asset(
                'assets/images/mine_icon_store_onclick.png',
                width: 20,
                height: 20,
              ),
        text: titles[0],
        iconPadding: EdgeInsets.fromLTRB(0, 4, 0, 2),
        textStyle: TextStyle(
            fontSize: 10,
            color: selectedIndex == 0 ? Colors.red : Color(YLZColorTitleTwo)));
  }
}
