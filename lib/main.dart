import 'package:FlutterProject/base/config/YLZTheme.dart';
import 'package:FlutterProject/base/navigator/HiNavigator.dart';
import 'package:FlutterProject/logic/chsHome/YLZElecCodeViewPage.dart';
import 'package:FlutterProject/logic/chsHome/YLZScanViewPage.dart';
import 'package:FlutterProject/logic/healthCode/controller/YLZHealthCodeViewPage.dart';
import 'package:FlutterProject/logic/mguo/home/controller/mg_home_player_page.dart';
import 'package:FlutterProject/logic/mguo/login/MGCodeLoginPage.dart';
import 'package:FlutterProject/logic/mguo/login/MGSmsLoginPage.dart';
import 'package:FlutterProject/logic/mguo/topics/controller/MGMovieDetailViewPage.dart';
import 'package:FlutterProject/logic/mguo/topics/controller/MGPrivacyPolicyDetailViewPage.dart';
import 'package:FlutterProject/logic/mguo/topics/controller/MGPrivacyPolicyViewPage.dart';
import 'package:FlutterProject/logic/mguo/topics/controller/MGTopicDetailViewPage.dart';
import 'package:FlutterProject/logic/mguo/topics/controller/MGTopicListViewPage.dart';
import 'package:FlutterProject/logic/rainBow/YLZReportDetailPage.dart';
import 'package:FlutterProject/logic/rainBow/YLZReportListPage.dart';
import 'package:FlutterProject/logic/tabbar/YLZBottomNavigator.dart';
import 'package:FlutterProject/net/db/hi_cache.dart';
import 'package:FlutterProject/provider/MGVideoDetailProvider.dart';
import 'package:FlutterProject/provider/YLZCodeProvider.dart';
import 'package:FlutterProject/provider/YLZCounter.dart';
import 'package:FlutterProject/provider/YLZHealthCodeProvider.dart';
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
        //???????????????
        future: HiCache.preInit(),
        builder: (BuildContext context, AsyncSnapshot<HiCache> snapshot) {
          //??????route
          var widget = snapshot.connectionState == ConnectionState.done
              ? Router(routerDelegate: _routeDelegate)
              : Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
          bool isAgree = HiCache.getInstance().get("isAgree") == null
              ? false
              : HiCache.getInstance().get("isAgree") as bool;
          _routeDelegate.routeStatus =
              isAgree ? RouteStatus.topicList : RouteStatus.privacyPolicy;
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => YLZCounter()),
              ChangeNotifierProvider(create: (_) => YLZTabbarProvider()),
              ChangeNotifierProvider(create: (_) => YLZCodeProvider()),
              ChangeNotifierProvider(create: (_) => MGVideoDetailProvider()),
              ChangeNotifierProvider(create: (_) => YLZHealthCodeProvider())
            ],
            child: ScreenUtilInit(
                designSize: Size(1125, 2436),
                builder: () => buildMaterialApp(widget)),
          );
        });
  }

  MaterialApp buildMaterialApp(Widget widget) {
    return MaterialApp(
        //??????????????????
        title: 'APP',
        theme: defaultTargetPlatform == TargetPlatform.iOS
            ? YLZTheme.kIOSTheme
            : YLZTheme.kDefaultTheme, // ????????????????????????
        debugShowCheckedModeBanner: false, // ????????????????????????
        // onGenerateRoute: Application.router.generator,
        home: widget,
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        //?????????
        supportedLocales: [
          Locale('zh', 'CN'),
        ]);
  }
}

class APPRouteDelegate extends RouterDelegate<APPRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<APPRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;
  Map? _args;
  late RouteStatus routeStatus;

  //???Navigator????????????key??????????????????????????????navigatorKey.currentState????????????NavigatorState??????
  APPRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    //????????????????????????
    HiNavigator().registerRouteJump(
        RouteJumpListener(onJumpTo: (RouteStatus routeStatus, {Map? args}) {
      _args = args;
      this.routeStatus = routeStatus;
      notifyListeners();
    }));
    //???????????????????????????
    // HiNet().setErrorInterceptor((error) {
    //   if (error is NeedLogin) {
    //     //????????????
    //     HiNavigator.getInstance().onJumpTo(RouteStatus.login);
    //   }
    // });
  }
  List<MaterialPage> pages = [];
  @override
  Widget build(BuildContext context) {
    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      //?????????????????????????????????????????????????????????????????????????????????????????????
      //tips ?????????????????????????????????????????????????????????????????????????????????????????????????????????
      tempPages = tempPages.sublist(0, index);
    }
    var page;
    if (routeStatus == RouteStatus.home) {
      pages.clear();
      page = pageWrap(YLZBottomNavigator());
    } else if (routeStatus == RouteStatus.smsLogin) {
      page = pageWrap(MGSmsLoginPage());
    } else if (routeStatus == RouteStatus.codeLogin) {
      page = pageWrap(MGCodeLoginPage(
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
    } else if (routeStatus == RouteStatus.topicList) {
      page = pageWrap(MGTopicListViewPage());
    } else if (routeStatus == RouteStatus.topicDetail) {
      page = pageWrap(MGTopicDetailViewPage(
        topicId: _args?["topicId"],
      ));
    } else if (routeStatus == RouteStatus.movieDetail) {
      page = pageWrap(MGMovieDetailViewPage(
        movieId: _args?["movieId"],
      ));
    } else if (routeStatus == RouteStatus.privacyPolicy) {
      page = pageWrap(MGPrivacyPolicyViewPage());
    } else if (routeStatus == RouteStatus.privacyPolicyDetail) {
      page = pageWrap(MGPrivacyPolicyDetailViewPage());
    }
    //?????????????????????????????????pages???????????????????????????????????????
    tempPages = [...tempPages, page];
    //????????????????????????
    HiNavigator().notify(tempPages, pages);
    pages = tempPages;
    return WillPopScope(
      //fix Android?????????????????????????????????????????????@https://github.com/flutter/flutter/issues/66349
      onWillPop: () async => !await navigatorKey.currentState!.maybePop(),
      child: Navigator(
        key: navigatorKey,
        pages: pages,
        onPopPage: (route, result) {
          //??????????????????
          if (!route.didPop(result)) {
            return false;
          }
          var tempPages = [...pages];
          pages.removeLast();
          //????????????????????????
          HiNavigator().notify(pages, tempPages);
          return true;
        },
      ),
    );
  }

  // RouteStatus get routeStatus {
  //   return routeStatus;
  // }

  @override
  Future<void> setNewRoutePath(APPRoutePath path) async {}
}

///?????????????????????path
class APPRoutePath {
  final String location;
  APPRoutePath.home() : location = "/";
}
