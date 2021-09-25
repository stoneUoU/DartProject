import 'package:FlutterProject/base/config/YLZTheme.dart';
import 'package:FlutterProject/base/navigator/HiNavigator.dart';
import 'package:FlutterProject/logic/healthCode/controller/YLZHealthCodeViewPage.dart';
import 'package:FlutterProject/logic/home/YLZElecCodeViewPage.dart';
import 'package:FlutterProject/logic/home/YLZScanViewPage.dart';
import 'package:FlutterProject/logic/login/YLZCodeLoginPage.dart';
import 'package:FlutterProject/logic/login/YLZSmsLoginPage.dart';
import 'package:FlutterProject/logic/mguo/controller/mg_home_player_page.dart';
import 'package:FlutterProject/logic/rainBow/YLZReportDetailPage.dart';
import 'package:FlutterProject/logic/rainBow/YLZReportListPage.dart';
import 'package:FlutterProject/logic/tabbar/YLZBottomNavigator.dart';
import 'package:FlutterProject/net/db/hi_cache.dart';
import 'package:FlutterProject/provider/MGVideoDetailProvider.dart';
import 'package:FlutterProject/provider/YLZCodeProvider.dart';
import 'package:FlutterProject/provider/YLZCounter.dart';
import 'package:FlutterProject/provider/YLZTabbarProvider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(APP());
}

class APP extends StatefulWidget {
  @override
  _APPState createState() => _APPState();
}

class _APPState extends State<APP> {
  APPRouteDelegate _routeDelegate = APPRouteDelegate();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HiCache>(
        //进行初始化
        future: HiCache.preInit(),
        builder: (BuildContext context, AsyncSnapshot<HiCache> snapshot) {
          //定义route
          var widget = snapshot.connectionState == ConnectionState.done
              ? Router(routerDelegate: _routeDelegate)
              : Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => YLZCounter()),
              ChangeNotifierProvider(create: (_) => YLZTabbarProvider()),
              ChangeNotifierProvider(create: (_) => YLZCodeProvider()),
              ChangeNotifierProvider(create: (_) => MGVideoDetailProvider())
            ],
            child: ScreenUtilInit(
                designSize: Size(1125, 2436),
                builder: () => buildMaterialApp(widget)),
          );
        });
  }

  MaterialApp buildMaterialApp(Widget widget) {
    return MaterialApp(
        //标题栏的名字
        title: 'APP',
        theme: defaultTargetPlatform == TargetPlatform.iOS
            ? YLZTheme.kIOSTheme
            : YLZTheme.kDefaultTheme, // 根据平台获取主题
        debugShowCheckedModeBanner: false, // 设置这一属性即可
        // onGenerateRoute: Application.router.generator,
        home: widget,
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        //国际化
        supportedLocales: [
          Locale('zh', 'CN'),
        ]);
  }
}

class APPRouteDelegate extends RouterDelegate<APPRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<APPRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;
  Map? _args;
  //为Navigator设置一个key，必要的时候可以通过navigatorKey.currentState来获取到NavigatorState对象
  APPRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    //实现路由跳转逻辑
    HiNavigator().registerRouteJump(
        RouteJumpListener(onJumpTo: (RouteStatus routeStatus, {Map? args}) {
      _args = args;
      _routeStatus = routeStatus;
      notifyListeners();
    }));
    //设置网络错误拦截器
    // HiNet().setErrorInterceptor((error) {
    //   if (error is NeedLogin) {
    //     //拉起登录
    //     HiNavigator.getInstance().onJumpTo(RouteStatus.login);
    //   }
    // });
  }
  RouteStatus _routeStatus = RouteStatus.healthCode;
  List<MaterialPage> pages = [];

  @override
  Widget build(BuildContext context) {
    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      //要打开的页面在栈中已存在，则将该页面和它上面的所有页面进行出栈
      //tips 具体规则可以根据需要进行调整，这里要求栈中只允许有一个同样的页面的实例
      tempPages = tempPages.sublist(0, index);
    }
    var page;
    if (routeStatus == RouteStatus.home) {
      pages.clear();
      page = pageWrap(YLZBottomNavigator());
    } else if (routeStatus == RouteStatus.smsLogin) {
      page = pageWrap(YLZSmsLoginPage());
    } else if (routeStatus == RouteStatus.codeLogin) {
      page = pageWrap(YLZCodeLoginPage(
          onCodeLoginPageListener: _args?["onCodeLoginPageListener"]));
    } else if (routeStatus == RouteStatus.reportList) {
      page = pageWrap(YLZReportListPage());
    } else if (routeStatus == RouteStatus.reportDetail) {
      page = pageWrap(YLZReportDetailPage(
          reportId: _args?["reportId"],
          onReportDetailPageListener: _args?["onReportDetailPageListener"]));
    } else if (routeStatus == RouteStatus.elecCode) {
      page = pageWrap(YLZElecCodeViewPage());
    } else if (routeStatus == RouteStatus.scan) {
      page = pageWrap(YLZScanViewPage());
    } else if (routeStatus == RouteStatus.videoPlay) {
      page = pageWrap(MGHomePlayerPage(id: _args?["id"]));
    } else if (routeStatus == RouteStatus.healthCode) {
      page = pageWrap(YLZHealthCodeViewPage());
    }
    //重新创建一个数组，否则pages因引用没有改变路由不会生效
    tempPages = [...tempPages, page];
    //通知路由发生变化
    HiNavigator().notify(tempPages, pages);
    pages = tempPages;
    return WillPopScope(
      //fix Android物理返回键，无法返回上一页问题@https://github.com/flutter/flutter/issues/66349
      onWillPop: () async => !await navigatorKey.currentState!.maybePop(),
      child: Navigator(
        key: navigatorKey,
        pages: pages,
        onPopPage: (route, result) {
          //执行返回操作
          if (!route.didPop(result)) {
            return false;
          }
          var tempPages = [...pages];
          pages.removeLast();
          //通知路由发生变化
          HiNavigator().notify(pages, tempPages);
          return true;
        },
      ),
    );
  }

  RouteStatus get routeStatus {
    return _routeStatus;
  }

  @override
  Future<void> setNewRoutePath(APPRoutePath path) async {}
}

///定义路由数据，path
class APPRoutePath {
  final String location;
  APPRoutePath.home() : location = "/";
}
