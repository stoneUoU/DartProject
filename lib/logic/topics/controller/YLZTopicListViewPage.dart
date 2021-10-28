import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZUnFixHeaderDelegate.dart';
import 'package:FlutterProject/base/navigator/HiNavigator.dart';
import 'package:FlutterProject/logic/topics/model/YLZListModel.dart';
import 'package:FlutterProject/logic/topics/model/YLZTopModel.dart';
import 'package:FlutterProject/logic/topics/view/YLZTopicCellWidget.dart';
import 'package:FlutterProject/logic/topics/view/YLZTopicSwiperView.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class YLZTopicListViewPage extends StatefulWidget {
  const YLZTopicListViewPage({Key? key}) : super(key: key);

  @override
  _YLZTopicListViewPageState createState() => _YLZTopicListViewPageState();
}

class _YLZTopicListViewPageState extends State<YLZTopicListViewPage>
    with AutomaticKeepAliveClientMixin {
  late Dio dio;
  List<YLZTopModel> topModels = [];
  List<YLZListModel> listModels = [];
  late Future _futureBuilderFuture;

  int _pageIndex = 1;
  EasyRefreshController easyRefreshController = new EasyRefreshController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    if (!mounted) return;
    _futureBuilderFuture = _request(1, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Scaffold(
        body: FutureBuilder(
            future: _futureBuilderFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return generateSliverView();
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

  Widget generateSliverView() {
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
                _futureBuilderFuture = _request(_pageIndex, 0);
              });
            },
            onLoad: () async {
              setState(() {
                _pageIndex++;
                _futureBuilderFuture = _request(_pageIndex, 1);
              });
            },
            slivers: _buildSlivers(context),
          ),
        )
      ],
    );
  }

  List<Widget> _buildSlivers(BuildContext context) {
    List<Widget> slivers = [];
    slivers.add(_makeTopHeader(context, topModels));
    for (int index = 0; index < listModels.length; index++) {
      slivers.addAll(_buildLists(context, index, listModels[index]));
    }
    return slivers;
  }

  Widget _makeTopHeader(BuildContext context, List<YLZTopModel> topModels) {
    return SliverPersistentHeader(
        pinned: false,
        delegate: YLZUnFixHeaderDelegate(
            212.0,
            212.0,
            Container(
              child: Column(
                children: <Widget>[
                  YLZTopicSwiperView(
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
      BuildContext context, int index, YLZListModel listModel) {
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

  Widget _generateCell(int i, int index, YLZListModel listModel) {
    return YLZTopicCellWidget(
        listModel: listModel,
        topicCellWidgetClickListener: (int index) {
          HiNavigator().onJumpTo(RouteStatus.topicDetail, args: {
            "topicId": index,
          });
        });
  }

  Future _request(int pageindex, int loadMore) async {
    String url = "/provide/news"; //图片轮播+跑马灯
    var data = {"page": pageindex, "limit": 10};
    Response response;
    dio = new Dio();
    response =
        await dio.post("https://mgapp.appearoo.top/api.php${url}", data: data);
    List listRs = response.data["data"]["list"];
    if (loadMore == 0) {
      topModels.clear();
      listModels.clear();
      List topRs = response.data["data"]["top"];
      for (var i = 0; i < topRs.length; i++) {
        YLZTopModel rs = YLZTopModel.fromJson(topRs[i]);
        topModels.add(rs);
      }
    }
    for (var i = 0; i < listRs.length; i++) {
      YLZListModel rs = YLZListModel.fromJson(listRs[i]);
      listModels.add(rs);
    }
    response.data["top"] = topModels;
    response.data["list"] = listModels;
    return response;
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
                    HiNavigator().onJumpTo(RouteStatus.healthCode);
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
