import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dart_demo/base/config/YLZMacros.dart';
import 'package:dart_demo/base/extent/YLZNetworkExtent.dart';
import 'package:dart_demo/base/navigator/HiNavigator.dart';
import 'package:dart_demo/base/view/YLZAppBar.dart';
import 'package:dart_demo/base/view/YLZBannerView.dart';
import 'package:dart_demo/base/view/YLZPlaceHolderView.dart';
import 'package:dart_demo/logic/rainBow/model/YLZReportCarouselModel.dart';
import 'package:dart_demo/logic/rainBow/model/YLZReportModel.dart';
import 'package:dart_demo/logic/rainBow/view/cells/YLZReportListCell.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logger/logger.dart';

class YLZReportListPage extends StatefulWidget {
  YLZReportListPage({Key? key}) : super(key: key);
  @override
  _YLZReportListPageState createState() => _YLZReportListPageState();
}

class _YLZReportListPageState extends State<YLZReportListPage> {
  List<YLZReportModel> widgets = [];
  List<YLZCarouselChildModel> mResult = [];
  YLZReportModel renderData = YLZReportModel();
  EasyRefreshController easyRefreshController = new EasyRefreshController();
  int pageSize = 10;
  int pageIndex = 1;
  bool netFlag = true;
  Dio dio = Dio();
  final log = Logger();

  @override
  void initState() {
    super.initState();
    _sendNet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YLZAppBar("设计报告", "", () {}),
      body: getBody(),
    );
  }

  _showLoadingDialog() {
    if (widgets.length == 0) {
      return true;
    }
    return false;
  }

  getProgressDialog() {
    return SpinKitFadingCircle(
      itemBuilder: (_, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Colors.red : Colors.green,
          ),
        );
      },
    );
  }

  getBody() {
    if (!netFlag) {
      return new YLZPlaceHolderView(
          viewType: YLZPlacHolderViewType.noNetwork,
          onPlaceHolderViewClickListener: (viewType) {
            if (viewType == YLZPlacHolderViewType.noNetwork) {
              _sendNet();
            } else if (viewType == YLZPlacHolderViewType.noGoods) {
              print("images/noShopCart.png");
            } else {
              print("images/noShopCart.png");
            }
          });
    } else {
      if (_showLoadingDialog()) {
        return getProgressDialog();
      } else {
        return Container(
          width: ScreenW(context),
          height: ScreenH(context) -
              kBottomNavigationBarHeight -
              TabbarSafeBottomM(context) -
              NaviH,
          child: EasyRefresh.custom(
            controller: easyRefreshController, //上面创建的刷新控制器
            header: ClassicalHeader(
                refreshText: "下拉可以  刷新",
                refreshReadyText: "松开立即刷新",
                refreshingText: "正在刷新数据中" + "...",
                refreshedText: "刷新完成",
                bgColor: Colors.transparent,
                textColor: Colors.black87,
                infoColor: Colors
                    .black54), //自定义刷新头（如果想更改背景色等，可以在小括号内设置属性，都有哪些属性，可以点击这个类自行查看）
            footer: ClassicalFooter(
                loadText: "上拉可以加载更多",
                loadReadyText: "松开立即加载更多",
                loadedText: "加载完成",
                noMoreText: "暂无更多数据",
                bgColor: Colors.transparent,
                textColor: Colors
                    .black87), //自定义加载尾（如果想更改背景色等，可以在小括号内设置属性，都有哪些属性，可以点击这个类自行查看）
            onRefresh: () async {
              _pullRefresh();
            },
            onLoad: () async {
              _loadMore();
            },
            slivers: _buildSlivers(context),
          ),
        );
      }
    }
  }

  List<Widget> _buildSlivers(BuildContext context) {
    return <Widget>[
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index == 0) {
              return _makeCarousel();
            } else {
              return _makeList(index);
            }
          },
          childCount: widgets.length + 1,
        ),
      ),
    ];
  }

  Widget _makeCarousel() {
    if (mResult.length == 0) {
      return new Container();
    }
    return new Container(
        height: 160, child: YLZHomeBannerView(carouselChildMs: mResult));
  }

  Widget _makeList(int i) {
    renderData = widgets[i != 0 ? i - 1 : 0];
    return new YLZReportListCell(
      model: renderData,
      onYLZReportListCellClickListener: (reportId) {
        HiNavigator().onJumpTo(RouteStatus.reportDetail, args: {
          "reportId": reportId,
          "onReportDetailPageListener": (String str) => {print(str)}
        });
      },
    );
  }

  _pullRefresh() {
    pageIndex = 1;
    widgets.clear();
    _loadData(true, false, false);
  }

  _loadMore() {
    pageIndex++;
    _loadData(false, true, false);
  }

  _sendNet() {
    YLZNetworkExtent networkExtent = new YLZNetworkExtent();
    networkExtent.checkInternet((netUseful) {
      if (!netUseful) {
        if (!mounted) return;
        setState(() {
          netFlag = false;
        });
      } else {
        netFlag = true;
        _loadData(true, false, true);
      }
    });
  }

  Future<Null> _loadData(bool freshBanner, bool ifLoad, bool firstR) async {
    String url = "/Exhibition/GetReportList";
    var data = {"pageIndex": pageIndex, "pageSize": pageSize};
    var response = await dio.post("${RainBowUrl}${url}", data: data);
    //先获取列表数据，再获取轮播图：
    if (freshBanner) {
      _getIPAddress();
    }
    if (response.data["flag"] == 1) {
      setState(() {
        for (int i = 0; i < response.data["rs"].length; i++) {
          YLZReportModel cellData =
              new YLZReportModel.fromJson(response.data["rs"][i]);
          widgets.add(cellData);
        }
      });
    }
  }

  _getIPAddress() async {
    var url = 'http://www.wanandroid.com/banner/json';
    var httpClient = new HttpClient();
    List<YLZCarouselChildModel>? result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var resJson = await response.transform(utf8.decoder).join();
        result = new YLZReportCarouselModel.fromJson(json.decode(resJson)).data;
      }
      setState(() {
        mResult = result ?? [];
      });
      request.close();
    } catch (exception) {}
  }
}
