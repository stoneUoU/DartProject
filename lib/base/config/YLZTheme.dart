import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*
  * 去除水波纹效果
  * 使用theme强制设置splash color和highlight color为 Colors.transparent
  * splashColor: Colors.transparent,
  * highlightColor: Colors.transparent),
  * brightness: Theme.of(context).brightness,确保与appTheme主题一致
  */

class YLZTheme {
  static ThemeData kIOSTheme = new ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Colors.grey[100],
      primaryColorBrightness: Brightness.light,
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.black54));

  static ThemeData kDefaultTheme = new ThemeData(
      primaryColor: Colors.white, // 主题色
      scaffoldBackgroundColor: Colors.grey[200], //背景样色
      accentColor: Colors.deepOrangeAccent, //强调颜色
      secondaryHeaderColor: Colors.white70, // 次标题颜色
      primarySwatch: Colors.purple,
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.black54));
}
