import 'package:dart_demo/base/navigator/HiNavigator.dart';
import 'package:dart_demo/logic/area/controller/YLZAreaViewPage.dart';
import 'package:dart_demo/logic/home/YLZHomeViewPage.dart';
import 'package:dart_demo/logic/mine/controller/YLZMineViewPage.dart';
import 'package:dart_demo/net/db/hi_cache.dart';
import 'package:dart_demo/provider/YLZTabbarProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///底部导航
class YLZBottomNavigator extends StatelessWidget {
  final _activeColor = Colors.red;
  static int initialPage = 0;
  final PageController _controller = PageController(initialPage: initialPage);
  List<Widget> _pages = [
    YLZHomeViewPage(),
    YLZAreaViewPage(),
    YLZMineViewPage()
  ];
  bool _hasBuild = false;
  @override
  Widget build(BuildContext context) {
    int selectedIndex = context.watch<YLZTabbarProvider>().selectedIndex;
    if (!_hasBuild) {
      //页面第一次打开时通知打开的是那个tab
      HiNavigator().onBottomTabChange(initialPage, _pages[initialPage]);
      _hasBuild = true;
    }
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: _pages,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => _onJumpTo(context, index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _activeColor,
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
        icon: Image.asset(
          icon,
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
      String value = HiCache.getInstance().get("access_token_12") ?? "";
      if (value.length == 0) {
        HiNavigator().onJumpTo(RouteStatus.codeLogin, args: {
          "onCodeLoginPageListener": (bool isSuccess) {
            if (isSuccess) {
              _controller.jumpToPage(index);
              context.read<YLZTabbarProvider>().setSelectedIndex(index);
            }
          }
        });
      } else {
        _controller.jumpToPage(index);
        context.read<YLZTabbarProvider>().setSelectedIndex(index);
      }
    } else {
      _controller.jumpToPage(index);
      context.read<YLZTabbarProvider>().setSelectedIndex(index);
    }
  }
}
