import 'package:FlutterProject/logic/healthCode/controller/YLZHealthCodeViewPage.dart';
import 'package:FlutterProject/logic/home/YLZElecCodeViewPage.dart';
import 'package:FlutterProject/logic/home/YLZScanViewPage.dart';
import 'package:FlutterProject/logic/login/YLZCodeLoginPage.dart';
import 'package:FlutterProject/logic/login/YLZSmsLoginPage.dart';
import 'package:FlutterProject/logic/mguo/controller/mg_home_player_page.dart';
import 'package:FlutterProject/logic/rainBow/YLZReportDetailPage.dart';
import 'package:FlutterProject/logic/rainBow/YLZReportListPage.dart';
import 'package:FlutterProject/logic/topics/controller/YLZTopicListViewPage.dart';
import 'package:FlutterProject/logic/topics/controller/YLZTopicDetailViewPage.dart';
import 'package:FlutterProject/logic/tabbar/YLZBottomNavigator.dart';
import 'package:flutter/material.dart';
import 'package:singleton/singleton.dart';
import 'package:url_launcher/url_launcher.dart';

typedef RouteChangeListener(RouteStatusInfo current, RouteStatusInfo pre);

///创建页面
pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}

///获取routeStatus在页面栈中的位置
int getPageIndex(List<MaterialPage> pages, RouteStatus routeStatus) {
  for (int i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    if (getStatus(page) == routeStatus) {
      return i;
    }
  }
  return -1;
}

///自定义路由封装，路由状态
enum RouteStatus {
  smsLogin,
  codeLogin,
  reportDetail,
  reportList,
  home,
  elecCode,
  scan,
  videoPlay,
  healthCode,
  topicList,
  topicDetail,
  unknown
}

///获取page对应的RouteStatus
RouteStatus getStatus(MaterialPage page) {
  if (page.child is YLZSmsLoginPage) {
    return RouteStatus.smsLogin;
  } else if (page.child is YLZCodeLoginPage) {
    return RouteStatus.codeLogin;
  } else if (page.child is YLZReportDetailPage) {
    return RouteStatus.reportDetail;
  } else if (page.child is YLZReportListPage) {
    return RouteStatus.reportList;
  } else if (page.child is YLZBottomNavigator) {
    return RouteStatus.home;
  } else if (page.child is YLZElecCodeViewPage) {
    return RouteStatus.elecCode;
  } else if (page.child is YLZScanViewPage) {
    return RouteStatus.scan;
  } else if (page.child is MGHomePlayerPage) {
    return RouteStatus.videoPlay;
  } else if (page.child is YLZHealthCodeViewPage) {
    return RouteStatus.healthCode;
  } else if (page.child is YLZTopicListViewPage) {
    return RouteStatus.topicList;
  } else if (page.child is YLZTopicDetailViewPage) {
    return RouteStatus.topicDetail;
  } else {
    return RouteStatus.unknown;
  }
}

///路由信息
class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget page;

  RouteStatusInfo(this.routeStatus, this.page);
}

///监听路由页面跳转
///感知当前页面是否压后台
class HiNavigator extends _RouteJumpListener {
  factory HiNavigator() => Singleton.lazy(() => HiNavigator._());

  /// Private constructor
  HiNavigator._() {}

  late RouteJumpListener _routeJump;
  List<RouteChangeListener> _listeners = [];
  late RouteStatusInfo _current;
  //首页底部tab
  RouteStatusInfo? _bottomTab;

  ///首页底部tab切换监听
  void onBottomTabChange(int index, Widget page) {
    _bottomTab = RouteStatusInfo(RouteStatus.home, page);
    _notify(_bottomTab!);
  }

  ///注册路由跳转逻辑
  void registerRouteJump(RouteJumpListener routeJumpListener) {
    this._routeJump = routeJumpListener;
  }

  Future<bool> openH5(String url) async {
    var result = await canLaunch(url);
    if (result) {
      return await launch(url);
    } else {
      return Future.value(false);
    }
  }

  void pop(BuildContext context) {
    Navigator.pop(context);
  }

  ///监听路由页面跳转
  void addListener(RouteChangeListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  ///移除监听
  void removeListener(RouteChangeListener listener) {
    _listeners.remove(listener);
  }

  @override
  void onJumpTo(RouteStatus routeStatus, {Map? args}) {
    _routeJump.onJumpTo(routeStatus, args: args);
  }

  ///通知路由页面变化
  void notify(List<MaterialPage> currentPages, List<MaterialPage> prePages) {
    if (currentPages == prePages) return;
    var current =
        RouteStatusInfo(getStatus(currentPages.last), currentPages.last.child);
    _notify(current);
  }

  void _notify(RouteStatusInfo current) {
    if (current.page is YLZBottomNavigator && _bottomTab != null) {
      //如果打开的是首页，则明确到首页具体的tab
      current = _bottomTab!;
    }
    _listeners.forEach((listener) {
      listener(current, _current);
    });
    _current = current;
  }
}

///抽象类供HiNavigator实现
abstract class _RouteJumpListener {
  void onJumpTo(RouteStatus routeStatus, {Map? args});
}

typedef OnJumpTo = void Function(RouteStatus routeStatus, {Map? args});

///定义路由跳转逻辑要实现的功能
class RouteJumpListener {
  final OnJumpTo onJumpTo;

  RouteJumpListener({required this.onJumpTo});
}
