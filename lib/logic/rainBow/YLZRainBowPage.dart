import 'package:FlutterProject/base/config/YLZHudTips.dart';
import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:FlutterProject/base/config/YLZUnFixHeaderDelegate.dart';
import 'package:FlutterProject/base/navigator/HiNavigator.dart';
import 'package:FlutterProject/logic/rainBow/model/YLZRainBowModel.dart';
import 'package:FlutterProject/logic/rainBow/model/YLZRainBowRotationModel.dart';
import 'package:FlutterProject/logic/rainBow/view/YLZRainBowHorizontalView.dart';
import 'package:FlutterProject/logic/rainBow/view/YLZRainBowMarqueeView.dart';
import 'package:FlutterProject/logic/rainBow/view/YLZRainBowSwiperView.dart';
import 'package:FlutterProject/logic/rainBow/view/cells/YLZRainBowDesignRealStuffCell.dart';
import 'package:FlutterProject/logic/rainBow/view/cells/YLZRainBowDesignerNoPhotoCell.dart';
import 'package:FlutterProject/logic/rainBow/view/cells/YLZRainBowDesignerPhotoCell.dart';
import 'package:FlutterProject/logic/rainBow/view/cells/YLZRainBowPrivateSchoolCell.dart';
import 'package:FlutterProject/logic/rainBow/view/cells/YLZRainBowPurchaseNoPhotoCell.dart';
import 'package:FlutterProject/logic/rainBow/view/cells/YLZRainBowPurchasePhotoCell.dart';
import 'package:FlutterProject/net/db/hi_cache.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class YLZRainBowPage extends StatefulWidget {
  const YLZRainBowPage({Key? key}) : super(key: key);

  @override
  _YYLZRainBowPageState createState() => _YYLZRainBowPageState();
}

class _YYLZRainBowPageState extends State<YLZRainBowPage>
    with AutomaticKeepAliveClientMixin {
  List dataLists = [
    {"index": 0, "picStr": "images/findDesigner.png", "textStr": "找设计师"},
    {"index": 1, "picStr": "images/designReport.png", "textStr": "设计报告"},
    {"index": 2, "picStr": "images/findDesigner.png", "textStr": "找设计师"},
    {"index": 3, "picStr": "images/privateSchool.png", "textStr": "作品私馆"},
    {"index": 4, "picStr": "images/planningCase.png", "textStr": "看策划案"},
    {"index": 5, "picStr": "images/findDesigner.png", "textStr": "找设计师"},
    {"index": 6, "picStr": "images/designCourse.png", "textStr": "设计课"},
  ];
  late Dio dio;

  List<Rs> loadMoreRs = [];
  List<Map<String, dynamic>> loadMoreJson = [];
  late Future _futureBuilderFuture;

  int _pageIndex = 1;
  EasyRefreshController easyRefreshController = new EasyRefreshController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!mounted) return;
    _futureBuilderFuture = _request(1, 0, 1);
  }

  @override
  Widget build(BuildContext context) {
    HiCache.getInstance().setString("aa", "67890");
    var value = HiCache.getInstance().get("aa");
    return Container(
      child: new Scaffold(
        body: FutureBuilder(
            future: _futureBuilderFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List dataList = (snapshot.data as List).cast();
                YLZRainBowRotationModel rotationModel =
                    YLZRainBowRotationModel.fromJson(dataList[0].data["rs"]);
                YLZRainBowModel listModel =
                    YLZRainBowModel.fromJson(dataList[1].data);
                return returnSliverView(rotationModel, listModel);
              } else {
                return Center(child: SpinKitFadingCircle(
                  itemBuilder: (_, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: index.isEven ? Colors.red : Colors.green,
                      ),
                    );
                  },
                ));
              }
            }),
      ),
    );
  }

  Widget returnSliverView(
      YLZRainBowRotationModel rotationModel, YLZRainBowModel listModel) {
    return new Container(
      width: ScreenW(context),
      height: ScreenH(context) -
          kBottomNavigationBarHeight -
          TabbarSafeBottomM(context),
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
            loadingText: "加载数据中" + "...",
            loadedText: "加载完成",
            noMoreText: "暂无更多数据",
            bgColor: Colors.transparent,
            textColor: Colors
                .black87), //自定义加载尾（如果想更改背景色等，可以在小括号内设置属性，都有哪些属性，可以点击这个类自行查看）
        onRefresh: () async {
          setState(() {
            _pageIndex = 1;
            _futureBuilderFuture = _request(_pageIndex, 0, 0);
          });
        },
        onLoad: () async {
          setState(() {
            _pageIndex++;
            _futureBuilderFuture = _request(_pageIndex, 1, 0);
          });
        },
        slivers: _buildSlivers(context, rotationModel, listModel),
      ),
    );
  }

  List<Widget> _buildSlivers(BuildContext context,
      YLZRainBowRotationModel rotationModel, YLZRainBowModel listModel) {
    List<Widget> slivers = [];
    slivers.add(_makeTopHeader(context, rotationModel));
    for (int index = 0; index < listModel.rs!.length; index++) {
      slivers.add(_makeFixedHeader(context));
      slivers.addAll(_buildLists(context, 0, index, listModel));
    }
    return slivers;
  }

  Widget _makeTopHeader(
      BuildContext context, YLZRainBowRotationModel rotationModel) {
    List<NewBannerList> carouselLists = rotationModel.newBannerList!;
    List<NewsList> newsLists = rotationModel.newsList!;
    return SliverPersistentHeader(
        pinned: false,
        delegate: YLZUnFixHeaderDelegate(
            295.0,
            295.0,
            Container(
              child: Column(
                children: <Widget>[
                  YLZRainBowSwiperView(
                    dataList: carouselLists,
                  ),
                  YLZRainBowHorizontalView(
                    dataList: dataLists,
                    onHorizontalViewClickListener: (int index) {
                      if (index == 1) {
                        HiNavigator().onJumpTo(RouteStatus.reportList);
                      }
                    },
                  ),
                  YLZRainBowMarqueeView(
                    newLists: newsLists,
                  ),
                ],
              ),
            )));
  }

  Widget _makeFixedHeader(BuildContext context) {
    return SliverPersistentHeader(
        pinned: false,
        delegate: YLZUnFixHeaderDelegate(
            10.0,
            10.0,
            new Container(
              height: 10.0,
              color: Color(YLZColorTableSeparatorView),
            )));
  }

  Widget _buildHeader(int index, {String text = ""}) {
    return new Container();
  }

  List<Widget> _buildLists(BuildContext context, int firstIndex, int count,
      YLZRainBowModel listModel) {
    return List.generate(1, (sliverIndex) {
      sliverIndex += firstIndex;
      return new SliverStickyHeader(
        header: _buildHeader(sliverIndex),
        sliver: new SliverList(
          delegate: new SliverChildBuilderDelegate(
            (context, i) => InkWell(
                onTap: () {}, child: _makeCustomerCell(i, count, listModel)),
            childCount: 1,
          ),
        ),
      );
    });
  }

  //type   1:作品   2:案例  3:设计师  4:设计干货  5:策划案  6:私馆  7:课程  8:广告  9:采购  10:主题  11:设计报告
  Widget _makeCustomerCell(int i, int count, YLZRainBowModel listModel) {
    Rs listRs = listModel.rs![count];
    if (listRs.type == 6 ||
        listRs.type == 1 ||
        listRs.type == 2 ||
        listRs.type == 5 ||
        listRs.type == 10 ||
        listRs.type == 11) {
      return YLZRainBowPrivateSchoolCell(
        rs: listRs,
        onYLZRainBowPrivateSchoolCellClickListener: (int str) {
          if (listRs.type == 11) {
            HiNavigator().onJumpTo(RouteStatus.reportDetail, args: {
              "reportId": str,
              "onReportDetailPageListener": (String str) => {print(str)}
            });
          }
        },
      );
    } else if (listRs.type == 3) {
      if (listRs.listImg.length == 3) {
        return YLZRainBowDesignerPhotoCell(rs: listRs);
      } else {
        return YLZRainBowDesignerNoPhotoCell(rs: listRs);
      }
    } else if (listRs.type == 4) {
      return YLZRainBowDesignRealStuffCell(rs: listRs);
    } else if (listRs.type == 9) {
      if (listRs.bigImg?.length == 0) {
        return YLZRainBowPurchaseNoPhotoCell(rs: listRs);
      } else {
        return YLZRainBowPurchasePhotoCell(rs: listRs);
      }
    } else {
      return Container(
        height: 64,
        color: Color(YLZColorGreenView),
      );
    }
  }

  Future _request(int pageindex, int loadMore, int firstR) async {
    String url1 = "/Home/GetHomeInfoTop"; //图片轮播+跑马灯
    String url2 = "/2.0.0/User/DataRecommendationList"; //list列表数据

    var data1 = {"userType": "1"};
    var data2 = {
      "TouristID": "9F2DB667-E32F-47BB-9A5E-23ED1C013800",
      "userId":
          "xiYKGnf7tf\/pNKH3y6K3iAdaU7OHRAZVEsSdBBd+hD+rTcelwJ3VYgfZVJlXRNjHAtPZ\/RRORrHvwEYdXQhLsMrp12F0FKrvFT2rUHwO0Aj3TLXMPB9MJzRwXpGf44sM3JuE1as+ISilADt4ChTE5aZdCJZJWbEOdo5dN6Q7x9o=",
      "pageindex": pageindex
    };
    List<Response> response;
    dio = new Dio();
    response = await Future.wait([
      dio.post("${RainBowUrl}${url1}", data: data1),
      dio.post("${RainBowUrl}${url2}", data: data2)
    ]);
    if (loadMore == 0) {
      if (int.parse(response[1].data["UpdateCount"].toString()) > 0) {
        YLZHudTips.showToast(
            "成功为您更新${response[1].data["UpdateCount"].toString()}条推荐");
      } else {
        YLZHudTips.showToast("暂无更新");
      }
    }
    loadMoreRs.clear();
    if (loadMore == 1) {
      List resRs = response[1].data["rs"];
      for (var i = 0; i < resRs.length; i++) {
        Rs lastRs = Rs.fromJson(resRs[i]);
        loadMoreRs.add(lastRs);
      }
    } else {
      loadMoreJson.clear();
      List resRs = response[1].data["rs"];
      for (var i = 0; i < resRs.length; i++) {
        Rs lastRs = Rs.fromJson(resRs[i]);
        loadMoreRs.add(lastRs);
      }
    }
    for (var i = 0; i < loadMoreRs.length; i++) {
      Rs lastRs = loadMoreRs[i];
      Map<String, dynamic> resStr = lastRs.toJson();
      loadMoreJson.add(resStr);
    }
    response[1].data["rs"] = loadMoreJson;
    return response;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
