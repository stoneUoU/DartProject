import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class YLZMovieDetailViewPage extends StatefulWidget {
  int movieId;

  YLZMovieDetailViewPage({Key? key, required this.movieId}) : super(key: key);

  @override
  _YLZMovieDetailViewPageState createState() => _YLZMovieDetailViewPageState();
}

class _YLZMovieDetailViewPageState extends State<YLZMovieDetailViewPage> {
  late Dio dio;
  late Future _futureBuilderFuture;
  EasyRefreshController easyRefreshController = new EasyRefreshController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    if (!mounted) return;
    _futureBuilderFuture = _request();
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
        Container(
          width: ScreenW(context),
          height: StatusH(context) + kToolbarHeight,
          color: Colors.white,
          child: Column(
            children: [
              Container(width: ScreenW(context), height: StatusH(context)),
              Stack(children: [
                Container(width: ScreenW(context), height: kToolbarHeight),
                Positioned(
                    child: InkWell(
                      child: Image.asset("assets/images/topic_back.png"),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    left: 16,
                    top: 20)
              ])
            ],
          ),
        ),
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
                _futureBuilderFuture = _request();
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
    slivers.addAll(_buildLists(context));
    return slivers;
  }

  List<Widget> _buildLists(BuildContext context) {
    return List.generate(1, (sliverIndex) {
      return new SliverStickyHeader(
        header: new Container(),
        sliver: new SliverList(
          delegate: new SliverChildBuilderDelegate(
            (context, i) => _generateCell(i),
            childCount: 1,
          ),
        ),
      );
    });
  }

  Widget _generateCell(int i) {
    return Container();
  }

  Future _request() async {
    String url = "/provide/news"; //图片轮播+跑马灯
    var data = {"page": 1, "limit": 10};
    Response response;
    dio = new Dio();
    response =
        await dio.post("https://mgapp.appearoo.top/api.php${url}", data: data);
    return response;
  }
}
