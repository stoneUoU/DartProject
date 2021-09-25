import 'package:flutter/material.dart';

///颜色
const String primaryValueString = "#24292E";
const String primaryLightValueString = "#42464b";
const String primaryDarkValueString = "#121917";
const String miWhiteString = "#ececec";
const String actionBlueString = "#267aff";
const String webDraculaBackgroundColorString = "#282a36";

const int primaryValue = 0xFF24292E;
const int primaryLightValue = 0xFF42464b;
const int primaryDarkValue = 0xFF121917;

const int cardWhite = 0xFFFFFFFF;
const int textWhite = 0xFFFFFFFF;
const int miWhite = 0xffececec;
const int white = 0xFFFFFFFF;
const int actionBlue = 0xff267aff;
const int subTextColor = 0xff959595;
const int subLightTextColor = 0xffc4c4c4;

const int mainBackgroundColor = miWhite;

const int mainTextColor = primaryDarkValue;
const int textColorWhite = white;

const int YLZColorBackGround = 0xffF5F7FA;
const int YLZColorLine = 0xffCECECE;
const int YLZColorRedView = 0xffF56C6C;
const int YLZColorBlueView = 0xff1B65B9;
const int YLZColorLightBlueView = 0xff3B71E8;
//app按钮不可用颜色
const int YLZColorDisabled = 0xffb5c7f2;
//app主页icon占位颜色
const int YLZColorPlace = 0xffe7ebf2;

const int YLZColorTitleOne = 0xff303133;

const int YLZColorTitleTwo = 0xff606266;

const int YLZColorTitleThree = 0xff909399;

const int YLZColorTitleFour = 0xffC0C4CC;

const int YLZColorGoldView = 0xffE6A23C;

const int YLZColorLightGoldView = 0xffFFF7ED;

const int YLZColorGreenView = 0xff4dab69;

const int YLZColorTableSeparatorView = 0xfff5f5f5;

const int YLZColorBlackView = 0xff000000;

const int YLZColorLightGreenView = 0xffF2F6FE;

const int MGColorMainView = 0xff1D1B2A;

const int MGColorLightBlueView = 0xff8AC4F5;

const int MGColorMainViewTwo = 0xff3B3756;

const int MGColorMainViewThree = 0xff2E2B42;

const int MGColorHomeViewPurple = 0xff746cff;

const int MGColorHomeViewPink = 0xffc003f8;

/// 闽政通淡蓝色
const int YLZColorMZTBlueView = 0xff2171f6;

const int YLZColorMZTCheckView = 0xffeff5f3;

const int YLZColorMZTGreenView = 0xff6ab069;

const int YLZColorMZTOrangeView = 0xffF7ce44;

const int YLZColorMZTRedView = 0xffeb3223;

const int YLZColorMZTLightBlueView = 0xffe5ecf8;

const int YLZColorMZTLightGoldView = 0xfffcf3ba;

const int YLZColorMZTGradientOneView = 0xffecbc6b;

const int YLZColorMZTGradientTwoView = 0xfff6eb9c;

const int YLZColorMZTGradientThreeView = 0xffe48344;

const int colorC14 = 0xffE6A23C;
const int colorC15 = 0xffFEFBF2;
const int colorC16 = 0xffFFF4D9;

const int colorC17 = 0xffF56C6C;
const int colorC18 = 0xffFFF6F5;
const int colorC19 = 0xffFFEFED;

const int colorC20 = 0xff3F74E9;
const int colorC21 = 0xffF4F7FE;
const int colorC22 = 0xffE2EAFC;

const MaterialColor primarySwatch = const MaterialColor(
  primaryValue,
  const <int, Color>{
    50: const Color(primaryLightValue),
    100: const Color(primaryLightValue),
    200: const Color(primaryLightValue),
    300: const Color(primaryLightValue),
    400: const Color(primaryLightValue),
    500: const Color(primaryValue),
    600: const Color(primaryDarkValue),
    700: const Color(primaryDarkValue),
    800: const Color(primaryDarkValue),
    900: const Color(primaryDarkValue),
  },
);

///主色调
const MaterialColor primary = const MaterialColor(
  0xfffb7299,
  const <int, Color>{50: const Color(0xffff9db5)},
);

const String app_default_share_url =
    "https://github.com/CarGuo/GSYGithubAppFlutter";

const lagerTextSize = 30.0;
const bigTextSize = 23.0;
const normalTextSize = 18.0;
const middleTextWhiteSize = 16.0;
const smallTextSize = 14.0;
const minTextSize = 12.0;

const minText = TextStyle(
  color: Color(subLightTextColor),
  fontSize: minTextSize,
);

const smallTextWhite = TextStyle(
  color: Color(textColorWhite),
  fontSize: smallTextSize,
);

const smallText = TextStyle(
  color: Color(mainTextColor),
  fontSize: smallTextSize,
);

const smallTextBold = TextStyle(
  color: Color(mainTextColor),
  fontSize: smallTextSize,
  fontWeight: FontWeight.bold,
);

const smallSubLightText = TextStyle(
  color: Color(subLightTextColor),
  fontSize: smallTextSize,
);

const smallActionLightText = TextStyle(
  color: Color(actionBlue),
  fontSize: smallTextSize,
);

const smallMiLightText = TextStyle(
  color: Color(miWhite),
  fontSize: smallTextSize,
);

const smallSubText = TextStyle(
  color: Color(subTextColor),
  fontSize: smallTextSize,
);

const middleText = TextStyle(
  color: Color(mainTextColor),
  fontSize: middleTextWhiteSize,
);

const middleTextWhite = TextStyle(
  color: Color(textColorWhite),
  fontSize: middleTextWhiteSize,
);

const middleSubText = TextStyle(
  color: Color(subTextColor),
  fontSize: middleTextWhiteSize,
);

const middleSubLightText = TextStyle(
  color: Color(subLightTextColor),
  fontSize: middleTextWhiteSize,
);

const middleTextBold = TextStyle(
  color: Color(mainTextColor),
  fontSize: middleTextWhiteSize,
  fontWeight: FontWeight.bold,
);

const middleTextWhiteBold = TextStyle(
  color: Color(textColorWhite),
  fontSize: middleTextWhiteSize,
  fontWeight: FontWeight.bold,
);

const middleSubTextBold = TextStyle(
  color: Color(subTextColor),
  fontSize: middleTextWhiteSize,
  fontWeight: FontWeight.bold,
);

const normalText = TextStyle(
  color: Color(mainTextColor),
  fontSize: normalTextSize,
);

const normalTextBold = TextStyle(
  color: Color(mainTextColor),
  fontSize: normalTextSize,
  fontWeight: FontWeight.bold,
);

const normalSubText = TextStyle(
  color: Color(subTextColor),
  fontSize: normalTextSize,
);

const normalTextWhite = TextStyle(
  color: Color(textColorWhite),
  fontSize: normalTextSize,
);

const normalTextMitWhiteBold = TextStyle(
  color: Color(miWhite),
  fontSize: normalTextSize,
  fontWeight: FontWeight.bold,
);

const normalTextActionWhiteBold = TextStyle(
  color: Color(actionBlue),
  fontSize: normalTextSize,
  fontWeight: FontWeight.bold,
);

const normalTextLight = TextStyle(
  color: Color(primaryLightValue),
  fontSize: normalTextSize,
);

const largeText = TextStyle(
  color: Color(mainTextColor),
  fontSize: bigTextSize,
);

const largeTextBold = TextStyle(
  color: Color(mainTextColor),
  fontSize: bigTextSize,
  fontWeight: FontWeight.bold,
);

const largeTextWhite = TextStyle(
  color: Color(textColorWhite),
  fontSize: bigTextSize,
);

const largeTextWhiteBold = TextStyle(
  color: Color(textColorWhite),
  fontSize: bigTextSize,
  fontWeight: FontWeight.bold,
);

const largeLargeTextWhite = TextStyle(
  color: Color(textColorWhite),
  fontSize: lagerTextSize,
  fontWeight: FontWeight.bold,
);

const largeLargeText = TextStyle(
  color: Color(primaryValue),
  fontSize: lagerTextSize,
  fontWeight: FontWeight.bold,
);

const String FONT_FAMILY = 'wxcIconFont';

const String DEFAULT_USER_ICON = '/images/logo.png';
const String DEFAULT_IMAGE = '/images/default_img.png';
const String DEFAULT_REMOTE_PIC =
    'https://raw.githubusercontent.com/CarGuo/GSYGithubAppFlutter/master//images/logo.png';

const IconData HOME = const IconData(0xe624, fontFamily: FONT_FAMILY);
const IconData MORE = const IconData(0xe674, fontFamily: FONT_FAMILY);
const IconData SEARCH = const IconData(0xe61c, fontFamily: FONT_FAMILY);

const IconData MAIN_DT = const IconData(0xe684, fontFamily: FONT_FAMILY);
const IconData MAIN_QS = const IconData(0xe818, fontFamily: FONT_FAMILY);
const IconData MAIN_MY = const IconData(0xe6d0, fontFamily: FONT_FAMILY);
const IconData MAIN_SEARCH = const IconData(0xe61c, fontFamily: FONT_FAMILY);

const IconData LOGIN_USER = const IconData(0xe666, fontFamily: FONT_FAMILY);
const IconData LOGIN_PW = const IconData(0xe60e, fontFamily: FONT_FAMILY);

const IconData REPOS_ITEM_USER =
    const IconData(0xe63e, fontFamily: FONT_FAMILY);
const IconData REPOS_ITEM_STAR =
    const IconData(0xe643, fontFamily: FONT_FAMILY);
const IconData REPOS_ITEM_FORK =
    const IconData(0xe67e, fontFamily: FONT_FAMILY);
const IconData REPOS_ITEM_ISSUE =
    const IconData(0xe661, fontFamily: FONT_FAMILY);

const IconData REPOS_ITEM_STARED =
    const IconData(0xe698, fontFamily: FONT_FAMILY);
const IconData REPOS_ITEM_WATCH =
    const IconData(0xe681, fontFamily: FONT_FAMILY);
const IconData REPOS_ITEM_WATCHED =
    const IconData(0xe629, fontFamily: FONT_FAMILY);
const IconData REPOS_ITEM_DIR = Icons.folder;
const IconData REPOS_ITEM_FILE =
    const IconData(0xea77, fontFamily: FONT_FAMILY);
const IconData REPOS_ITEM_NEXT =
    const IconData(0xe610, fontFamily: FONT_FAMILY);

const IconData USER_ITEM_COMPANY =
    const IconData(0xe63e, fontFamily: FONT_FAMILY);
const IconData USER_ITEM_LOCATION =
    const IconData(0xe7e6, fontFamily: FONT_FAMILY);
const IconData USER_ITEM_LINK = const IconData(0xe670, fontFamily: FONT_FAMILY);
const IconData USER_NOTIFY = const IconData(0xe600, fontFamily: FONT_FAMILY);

const IconData ISSUE_ITEM_ISSUE =
    const IconData(0xe661, fontFamily: FONT_FAMILY);
const IconData ISSUE_ITEM_COMMENT =
    const IconData(0xe6ba, fontFamily: FONT_FAMILY);
const IconData ISSUE_ITEM_ADD = const IconData(0xe662, fontFamily: FONT_FAMILY);

const IconData ISSUE_EDIT_H1 = Icons.filter_1;
const IconData ISSUE_EDIT_H2 = Icons.filter_2;
const IconData ISSUE_EDIT_H3 = Icons.filter_3;
const IconData ISSUE_EDIT_BOLD = Icons.format_bold;
const IconData ISSUE_EDIT_ITALIC = Icons.format_italic;
const IconData ISSUE_EDIT_QUOTE = Icons.format_quote;
const IconData ISSUE_EDIT_CODE = Icons.format_shapes;
const IconData ISSUE_EDIT_LINK = Icons.insert_link;

const IconData NOTIFY_ALL_READ =
    const IconData(0xe62f, fontFamily: FONT_FAMILY);

const IconData PUSH_ITEM_EDIT = Icons.mode_edit;
const IconData PUSH_ITEM_ADD = Icons.add_box;
const IconData PUSH_ITEM_MIN = Icons.indeterminate_check_box;
