import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:FlutterProject/base/config/YLZUnFixHeaderDelegate.dart';
import 'package:FlutterProject/base/navigator/HiNavigator.dart';
import 'package:FlutterProject/logic/mguo/topics/model/MGListModel.dart';
import 'package:FlutterProject/logic/mguo/topics/model/MGTopModel.dart';
import 'package:FlutterProject/logic/mguo/topics/view/MGTopicCellWidget.dart';
import 'package:FlutterProject/logic/mguo/topics/view/MGTopicSwiperView.dart';
import 'package:FlutterProject/net/dao/mguo/mg_topics_dao.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class MGTopicListViewPage extends StatefulWidget {
  const MGTopicListViewPage({Key? key}) : super(key: key);

  @override
  _MGTopicListViewPageState createState() => _MGTopicListViewPageState();
}

class _MGTopicListViewPageState extends State<MGTopicListViewPage>
    with AutomaticKeepAliveClientMixin {
  List<MGTopModel> topModels = [];
  List<MGListModel> listModels = [];
  late Future _futureBuilderFuture;
  int _pageIndex = 1;
  EasyRefreshController easyRefreshController = new EasyRefreshController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    if (!mounted) return;
    _futureBuilderFuture = _request(1, false);
  }

  @override
  Widget build(BuildContext context) {
    // isConnected().then((result) {
    //   if (result) {
    //
    //   } else {
    //     return Container();
    //   }
    // });
    return WillPopScope(
      onWillPop: () {
        print("退出");
        SystemNavigator.pop();
        return new Future.value(false);
      },
      child: Container(
        child: new Scaffold(
          body: FutureBuilder(
              future: _futureBuilderFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  bool sign = snapshot.data as bool;
                  return generateSliverView(sign);
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
      ),
    );
  }

  // Future<bool> isConnected() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   return connectivityResult != ConnectivityResult.none;
  // }

  Widget generateSliverView(bool sign) {
    if (sign) {
      return Column(
        children: [
          YLZTopicNavigationWidget(context: context),
          new Expanded(
            child: EasyRefresh.custom(
              controller: easyRefreshController,
              //上面创建的刷新控制器
              header: ClassicalHeader(
                  refreshText: "下拉可以  刷新",
                  refreshReadyText: "松开立即刷新",
                  refreshingText: "正在刷新数据中" + "...",
                  refreshedText: "刷新完成",
                  bgColor: Colors.transparent,
                  textColor: Colors.black87,
                  infoColor: Colors.black54),
              //自定义刷新头（如果想更改背景色等，可以在小括号内设置属性，都有哪些属性，可以点击这个类自行查看）
              footer: ClassicalFooter(
                  loadText: "上拉可以加载更多",
                  loadReadyText: "松开立即加载更多",
                  loadingText: "加载数据中" + "...",
                  loadedText: "加载完成",
                  noMoreText: "暂无更多数据",
                  bgColor: Colors.transparent,
                  textColor: Colors.black87),
              //自定义加载尾（如果想更改背景色等，可以在小括号内设置属性，都有哪些属性，可以点击这个类自行查看）
              onRefresh: () async {
                setState(() {
                  _pageIndex = 1;
                  _futureBuilderFuture = _request(_pageIndex, false);
                });
              },
              onLoad: () async {
                setState(() {
                  _pageIndex++;
                  _futureBuilderFuture = _request(_pageIndex, true);
                });
              },
              slivers: _buildSlivers(context),
            ),
          ),
          InkWell(
            child: Container(
              width: ScreenW(context),
              color: Colors.white,
              padding: EdgeInsets.all(12),
              alignment: Alignment.center,
              child: Text("《隐私政策》",
                  style: TextStyle(
                    color: Color(YLZColorBlueView),
                    fontSize: 14,
                  )),
            ),
            onTap: () {},
          )
        ],
      );
    } else {
      return Column(
        children: [
          YLZTopicNavigationWidget(context: context),
          new Expanded(
            child: Center(
              child: Container(
                height: 120,
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text("抱歉，暂为连接到网络！",
                        style: TextStyle(
                            color: Color(YLZColorTitleOne),
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.only(top: 24),
                        width: 144,
                        height: 36,
                        decoration: new BoxDecoration(
                          color: Color(YLZColorLightBlueView),
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(4.0)),
                        ),
                        child: Center(
                          child: Text(
                            "刷新界面",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _pageIndex = 1;
                          _futureBuilderFuture = _request(_pageIndex, false);
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            child: Container(
              width: ScreenW(context),
              color: Colors.white,
              padding: EdgeInsets.all(12),
              alignment: Alignment.center,
              child: Text("《隐私政策》",
                  style: TextStyle(
                    color: Color(YLZColorBlueView),
                    fontSize: 14,
                  )),
            ),
            onTap: () {},
          )
        ],
      );
    }
  }

  List<Widget> _buildSlivers(BuildContext context) {
    List<Widget> slivers = [];
    slivers.add(_makeTopHeader(context, topModels));
    for (int index = 0; index < listModels.length; index++) {
      slivers.addAll(_buildLists(context, index, listModels[index]));
    }
    return slivers;
  }

  Widget _makeTopHeader(BuildContext context, List<MGTopModel> topModels) {
    return SliverPersistentHeader(
        pinned: false,
        delegate: YLZUnFixHeaderDelegate(
            212.0,
            212.0,
            Container(
              child: Column(
                children: <Widget>[
                  MGTopicSwiperView(
                    dataList: topModels,
                    clickListener: (int index) {
                      HiNavigator().onJumpTo(RouteStatus.topicDetail, args: {
                        "topicId": index,
                      });
                    },
                  ),
                ],
              ),
            )));
  }

  List<Widget> _buildLists(
      BuildContext context, int index, MGListModel listModel) {
    return List.generate(1, (sliverIndex) {
      return new SliverStickyHeader(
        header: new Container(),
        sliver: new SliverList(
          delegate: new SliverChildBuilderDelegate(
            (context, i) => _generateCell(i, index, listModel),
            childCount: 1,
          ),
        ),
      );
    });
  }

  Widget _generateCell(int i, int index, MGListModel listModel) {
    return MGTopicCellWidget(
        listModel: listModel,
        topicCellWidgetClickListener: (int index) {
          HiNavigator().onJumpTo(RouteStatus.topicDetail, args: {
            "topicId": index,
          });
        });
  }

  Future _request(int pageIndex, bool loadMore) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    bool sign = false;
    if (connectivityResult != ConnectivityResult.none) {
      var result = await MGTopicDao.list(pageIndex);
      List listRs = result["data"]["list"];
      if (!loadMore) {
        topModels.clear();
        listModels.clear();
        List topRs = result["data"]["top"];
        for (var i = 0; i < topRs.length; i++) {
          MGTopModel rs = MGTopModel.fromJson(topRs[i]);
          topModels.add(rs);
        }
      }
      for (var i = 0; i < listRs.length; i++) {
        MGListModel rs = MGListModel.fromJson(listRs[i]);
        listModels.add(rs);
      }
      sign = true;
      return sign;
    } else {
      sign = false;
      return sign;
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class YLZTopicNavigationWidget extends StatelessWidget {
  const YLZTopicNavigationWidget({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenW(context),
      height: StatusH(context) + kToolbarHeight,
      color: Colors.white,
      child: Column(
        children: [
          Container(width: ScreenW(context), height: StatusH(context)),
          Stack(children: [
            Container(
              width: ScreenW(context),
              height: kToolbarHeight,
              alignment: Alignment.center,
              child: Text("最新",
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500)),
            ),
            Positioned(
                child: InkWell(
                  child: Image.asset("assets/images/top_search.png"),
                  onTap: () {
                    // HiNavigator().onJumpTo(RouteStatus.healthCode);
                  },
                ),
                right: 16,
                top: 16)
          ])
        ],
      ),
    );
  }
}
