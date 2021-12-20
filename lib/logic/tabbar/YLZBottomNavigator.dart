import 'dart:convert';

import 'package:DartProject/base/config/YLZStyle.dart';
import 'package:DartProject/base/navigator/HiNavigator.dart';
import 'package:DartProject/logic/mguo/home/controller/MGHomeViewPage.dart';
import 'package:DartProject/logic/mguo/login/model/MGLoginModel.dart';
import 'package:DartProject/logic/mguo/topics/controller/MGTopicListViewPage.dart';
import 'package:DartProject/logic/mine/controller/YLZMineViewPage.dart';
import 'package:DartProject/net/db/hi_cache.dart';
import 'package:flutter/material.dart';

///底部导航
class YLZBottomNavigator extends StatefulWidget {
  @override
  _YLZBottomNavigatorState createState() => _YLZBottomNavigatorState();
}

class _YLZBottomNavigatorState extends State<YLZBottomNavigator> {
  final _activeColor = Colors.red;
  static int initialPage = 0;
  final PageController _controller = PageController(initialPage: initialPage);
  late List<Widget> _pages;
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = [
      // YLZHomeViewPage(onJumpTo: (int i) {
      //   this._onJumpTo(context, i);
      // }),
      MGHomeViewPage(),
      MGTopicListViewPage(),
      YLZMineViewPage()
    ];
    //页面第一次打开时通知打开的是那个tab
    HiNavigator().onBottomTabChange(initialPage, _pages[initialPage]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: _pages,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) => _onJumpTo(context, index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _activeColor,
        unselectedItemColor: Color(YLZColorTitleOne),
        items: [
          _bottomItem('首页', 'assets/images/mine_icon_store_onclick.png',
              'assets/images/mine_icon_store_click.png', 0),
          _bottomItem('购物车', 'assets/images/icon_shoppingcar_onclick.png',
              'assets/images/icon_shoppingcar_click.png', 1),
          _bottomItem('我的', 'assets/images/mine_icon_mine_onclick.png',
              'assets/images/mine_icon_mine_click.png', 2)
        ],
      ),
    );
  }

  _bottomItem(String title, String icon, String activeIcon, int index) {
    return BottomNavigationBarItem(
        icon: Image(
          image: AssetImage(icon),
          width: 20,
          height: 20,
        ),
        activeIcon: Image.asset(
          activeIcon,
          width: 20,
          height: 20,
        ),
        label: title);
  }

  void _onJumpTo(BuildContext context, int index) {
    if (index == 1 || index == 2) {
      String personalInfo = HiCache.getInstance().get("personalInfo") ?? "";
      if (personalInfo.length == 0) {
        HiNavigator().onJumpTo(RouteStatus.codeLogin, args: {
          "onCodeLoginPageListener": (bool isSuccess) {
            if (isSuccess) {
              _controller.jumpToPage(index);
              setState(() {
                //控制选中第一个tab
                _currentIndex = index;
              });
            }
          }
        });
      } else {
        Map<String, dynamic> map = json.decode(personalInfo);
        MGLoginModel model = MGLoginModel.fromJson(map);
        _controller.jumpToPage(index);
        setState(() {
          //控制选中第一个tab
          _currentIndex = index;
        });
      }
    } else {
      _controller.jumpToPage(index);
      setState(() {
        //控制选中第一个tab
        _currentIndex = index;
      });
    }
  }
}
