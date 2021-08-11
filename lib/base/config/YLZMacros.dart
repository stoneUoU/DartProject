import 'package:flutter/material.dart';

bool dark = true;
ThemeData themeData = new ThemeData.light();
Color searchBackgroundColor = Colors.white10;
Color cardBackgroundColor = new Color(0xFF222222);
Color fontColor = Colors.white30;

double NaviH = kToolbarHeight;

double TabBarH = kBottomNavigationBarHeight;

String CMarketUrl = "https://api.cht.znrmny.com/api/cht/app/v1/";

String RainBowUrl = "https://api.chdesign.cn"; //"http://192.168.1.97:8885";

String BXLifeUrl = "http://baixingliangfan.cn/baixing/";

String PicUrl = "https://pic.cht.znrmny.com";

/** 获取屏幕宽度 */
double ScreenW(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

/** 获取屏幕高度 */
double ScreenH(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

/** 获取系统状态栏高度 */
double StatusH(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}

/**  Tabbar safe bottom margin */
double TabbarSafeBottomM(BuildContext context) {
  return MediaQuery.of(context).padding.bottom;
}
