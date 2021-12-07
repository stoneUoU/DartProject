import 'dart:convert';

import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:FlutterProject/base/navigator/HiNavigator.dart';
import 'package:FlutterProject/logic/mguo/home/model/mg_home_model.dart';
import 'package:FlutterProject/logic/mguo/home/model/mg_video_detail_model.dart';
import 'package:FlutterProject/logic/mguo/login/model/mg_login_model.dart';
import 'package:FlutterProject/logic/mguo/topics/model/MGAdModels.dart';
import 'package:FlutterProject/logic/mguo/topics/model/MGCommentModel.dart';
import 'package:FlutterProject/net/dao/mguo/mg_movie_dao.dart';
import 'package:FlutterProject/net/db/hi_cache.dart';
import 'package:FlutterProject/provider/MGMovieDetailProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class MGMovieDetailViewPage extends StatefulWidget {
  int movieId;

  MGMovieDetailViewPage({Key? key, required this.movieId}) : super(key: key);

  @override
  _MGMovieDetailViewPageState createState() => _MGMovieDetailViewPageState();
}

class _MGMovieDetailViewPageState extends State<MGMovieDetailViewPage> {
  EasyRefreshController easyRefreshController = new EasyRefreshController();
  late MGVideoDetailModel detailModel;
  List<MGCommentModel> commentModels = [];
  int _pageIndex = 1;
  late Future _futureBuilderFuture;

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
    return Container(
      child: new Scaffold(
        body: FutureBuilder(
            future: _futureBuilderFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List dataList = (snapshot.data as List).cast();
                MGVideoDetailModel model = dataList[0] as MGVideoDetailModel;
                MGAdModels adModel = dataList[1] as MGAdModels;
                this.detailModel = model;
                return generateSliverView();
              } else {
                return _buildSpinKitFadingCircle();
              }
            }),
      ),
    );
  }

  Widget generateSliverView() {
    return Column(
      children: [
        YLZMovieNavigationWidget(context: context),
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
        )
      ],
    );
  }

  List<Widget> _buildSlivers(BuildContext context) {
    List<Widget> slivers = [];
    slivers.add(_buildTopWidget(context));
    slivers.addAll(_buildLists(context));
    return slivers;
  }

  Widget _buildTopWidget(BuildContext context) {
    return new SliverStickyHeader(
      header: new Container(),
      sliver: new SliverList(
        delegate: new SliverChildBuilderDelegate(
          (context, i) => _generateTopCell(i),
          childCount: 1,
        ),
      ),
    );
  }

  Widget _generateTopCell(int i) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YLZMovieTopInfoWidget(
            detailModel: detailModel,
            context: context,
            movieId: widget.movieId,
          ),
          YLZMovieFansWidget(),
          Container(
            decoration: new BoxDecoration(
              color: Color(YLZColorTitleFour),
              borderRadius: new BorderRadius.all(new Radius.circular(4.0)),
            ),
            height: 112,
          ),
          YLZMoviePlotWidget(detailModel: detailModel),
          YLZMovieActorWidget(detailModel: detailModel),
          YLZFriendCommetWidget(commentModels: this.commentModels)
        ],
      ),
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
    );
  }

  List<Widget> _buildLists(BuildContext context) {
    return List.generate(1, (sliverIndex) {
      return new SliverStickyHeader(
        header: new Container(
          height: 12,
        ),
        sliver: new SliverList(
          delegate: new SliverChildBuilderDelegate(
            (context, i) => _generateCell(i),
            childCount: this.commentModels.length,
          ),
        ),
      );
    });
  }

  Center _buildSpinKitFadingCircle() {
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

  Widget _generateCell(int i) {
    MGCommentModel model = this.commentModels[i];
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
      decoration: new BoxDecoration(
        color: Color(YLZColorMZTLightBlueView),
        borderRadius: new BorderRadius.all(new Radius.circular(4.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 12, 10, 12),
            child: Row(
              children: [
                new Container(
                  width: 28.0,
                  height: 28.0,
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/images/ylz_blank_circular.jpg",
                      image: model.userPortrait ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text("${model.name}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(YLZColorTitleOne),
                                fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        child: Text("${model.time}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12, color: Color(YLZColorTitleOne))),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text("${model.content}",
                maxLines: 120,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 14,
                    color: Color(YLZColorTitleOne),
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        child: Text("${model.up}   ",
                            maxLines: 120,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(YLZColorTitleOne),
                                fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        child: Image.asset(
                            "assets/images/mg_movie_comment_zan.png"),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  height: i == commentModels.length - 1 ? 0 : 0.5,
                  color: Colors.red,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future _request(int pageIndex, bool loadMore) async {
    String personalInfo = HiCache.getInstance().get("personalInfo") ?? "";
    Map<String, dynamic> map = json.decode(personalInfo);
    MGLoginModel model = MGLoginModel.fromJson(map);

    MGVideoDetailModel detailModel =
        await MGMovieDao.videoInfo(widget.movieId, model.token ?? "");
    MGAdModels adModel = await MGMovieDao.videoAds("ios_video_ad");
    var result = await MGMovieDao.videoCommentList(widget.movieId, pageIndex);
    List listRs = result["list"];
    if (!loadMore) {
      commentModels.clear();
    }
    for (var i = 0; i < listRs.length; i++) {
      MGCommentModel rs = MGCommentModel.fromJson(listRs[i]);
      commentModels.add(rs);
    }
    context.read<MGMovieDetailProvider>().fireMovieDetail(detailModel);
    return [detailModel, adModel];
  }
}

class YLZFriendCommetWidget extends StatelessWidget {
  final List<MGCommentModel> commentModels;

  const YLZFriendCommetWidget({Key? key, required this.commentModels})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (commentModels.length == 0) {
      return Container();
    }
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text("圈友评",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 16,
                    color: Color(YLZColorTitleOne),
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            child: Text("全部影评:6233",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, color: Color(YLZColorTitleOne))),
          )
        ],
      ),
    );
  }
}

class YLZMovieActorWidget extends StatelessWidget {
  const YLZMovieActorWidget({
    Key? key,
    required this.detailModel,
  }) : super(key: key);

  final MGVideoDetailModel detailModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text("演员:",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 16,
                    color: Color(YLZColorTitleOne),
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            height: 192,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                VideoModel videoModel = detailModel.likes![index];
                return InkWell(
                  child: Container(
                    margin: EdgeInsets.only(
                        right: index == detailModel.likes!.length - 1 ? 0 : 10),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6.0)),
                                  child: new FadeInImage.assetNetwork(
                                    placeholder:
                                        "assets/images/ylz_blank_rectangle.png",
                                    image: "${videoModel.img}",
                                    fit: BoxFit.cover,
                                  )),
                              width: 104,
                              height: 146,
                            ),
                            Positioned(
                                right: 6,
                                bottom: 6,
                                child: Text(
                                  "${videoModel.score}",
                                  style: TextStyle(
                                      color: Colors.deepOrange, fontSize: 16),
                                ))
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 104,
                          height: 36,
                          child: Text(
                            "${videoModel.name}",
                            style: TextStyle(
                                color: Color(YLZColorTitleTwo), fontSize: 14),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    HiNavigator().onJumpTo(RouteStatus.videoPlay,
                        args: {"moiveId": videoModel.id});
                  },
                );
              },
              itemCount: detailModel.likes?.length ?? 0,
            ),
          )
        ],
      ),
    );
  }
}

class YLZMoviePlotWidget extends StatelessWidget {
  const YLZMoviePlotWidget({
    Key? key,
    required this.detailModel,
  }) : super(key: key);

  final MGVideoDetailModel detailModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 12, 0, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text("剧情介绍:",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 16,
                    color: Color(YLZColorTitleOne),
                    fontWeight: FontWeight.bold)),
          ),
          Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.all(0),
              child: Html(
                data: detailModel.info,
                style: {
                  'p': Style(
                      fontSize: FontSize.medium, color: Color(YLZColorTitleOne))
                },
              ))
        ],
      ),
    );
  }
}

class YLZMovieFansWidget extends StatelessWidget {
  const YLZMovieFansWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        border: new Border.all(
          color: Colors.red,
          width: 1.0,
        ),
        borderRadius: new BorderRadius.all(new Radius.circular(4.0)),
      ),
      height: 36,
      margin: EdgeInsets.fromLTRB(0, 12, 0, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Text("14.9万人看过 ",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(YLZColorTitleTwo),
                        ))),
                Container(
                    child: Text(" 8.0万人想看",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(YLZColorTitleTwo),
                        )))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 12),
            child: Row(
              children: [
                Container(
                    child: Text("4分钟前 ",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(YLZColorTitleTwo),
                        ))),
                Container(
                    child: Text(" 收藏",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(YLZColorTitleTwo),
                        )))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class YLZMovieTopInfoWidget extends StatelessWidget {
  const YLZMovieTopInfoWidget(
      {Key? key,
      required this.detailModel,
      required this.context,
      required this.movieId})
      : super(key: key);

  final MGVideoDetailModel detailModel;
  final BuildContext context;
  final int movieId;

  @override
  Widget build(BuildContext context) {
    MGVideoDetailModel detailModel =
        context.watch<MGMovieDetailProvider>().detailModel;
    return Container(
      height: 136,
      child: Row(
        children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: FadeInImage.assetNetwork(
                placeholder: "assets/images/ylz_blank_circular.jpg",
                image: this.detailModel.img ?? "",
                fit: BoxFit.cover,
              ),
            ),
            height: 128,
            width: 92,
          ),
          Container(
              width: (ScreenW(context) - (48 + 92)),
              margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text("${this.detailModel.name}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(YLZColorTitleOne),
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                    child: Text("类型：${this.detailModel.type}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 10, color: Color(YLZColorTitleThree))),
                  ),
                  Container(
                    child: Text("年份：${this.detailModel.msg}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 10, color: Color(YLZColorTitleThree))),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                    child: Text("地区：${this.detailModel.vodArea}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 10, color: Color(YLZColorTitleThree))),
                  ),
                  Expanded(
                    child: Text("主演：${this.detailModel.actor}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 10, color: Color(YLZColorTitleThree))),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          child: Container(
                            width: (ScreenW(context) - (48 + 92 + 16)) / 3,
                            height: 26,
                            decoration: new BoxDecoration(
                              color: Color(YLZColorMZTLightBlueView),
                              borderRadius: new BorderRadius.all(
                                  new Radius.circular(4.0)),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(detailModel.isCollect ?? false
                                      ? "assets/images/mg_movie_like.png"
                                      : "assets/images/mg_movie_un_like.png"),
                                  Text(
                                    "  收藏",
                                    style: TextStyle(
                                      color: Color(YLZColorTitleOne),
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            funcWithCollectLogic(
                                detailModel.isCollect ?? false);
                          },
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          width: (ScreenW(context) - (48 + 92 + 16)) / 3,
                          height: 26,
                          decoration: new BoxDecoration(
                            color: Color(YLZColorMZTLightBlueView),
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(4.0)),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                    "assets/images/mg_movie_moment.png"),
                                Text(
                                  "  分享",
                                  style: TextStyle(
                                    color: Color(YLZColorTitleOne),
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          width: (ScreenW(context) - (48 + 92 + 16)) / 3,
                          height: 26,
                          decoration: new BoxDecoration(
                            color: Color(YLZColorMZTLightBlueView),
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(4.0)),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                    "assets/images/mg_movie_want_watch.png"),
                                Text(
                                  "  想看",
                                  style: TextStyle(
                                    color: Color(YLZColorTitleOne),
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  funcWithCollectLogic(bool collected) async {
    String personalInfo = HiCache.getInstance().get("personalInfo") ?? "";
    Map<String, dynamic> map = json.decode(personalInfo);
    MGLoginModel model = MGLoginModel.fromJson(map);

    if (!collected) {
      var result =
          await MGMovieDao.videoAddCollect(this.movieId, model.token ?? "");
      if (result["code"] == 1) {
        detailModel.isCollect = true;
        context.read<MGMovieDetailProvider>().fireMovieDetail(detailModel);
        Fluttertoast.showToast(
            msg: result["msg"] ?? "收藏成功！", gravity: ToastGravity.CENTER);
        return;
      } else {
        Fluttertoast.showToast(
            msg: result["msg"] ?? "收藏失败！", gravity: ToastGravity.CENTER);
      }
    } else {
      var result =
          await MGMovieDao.videoCancelCollect(this.movieId, model.token ?? "");
      if (result["code"] == 1) {
        detailModel.isCollect = false;
        context.read<MGMovieDetailProvider>().fireMovieDetail(detailModel);
        Fluttertoast.showToast(
            msg: result["msg"] ?? "取消收藏成功！", gravity: ToastGravity.CENTER);
        return;
      } else {
        Fluttertoast.showToast(
            msg: result["msg"] ?? "取消收藏失败！", gravity: ToastGravity.CENTER);
      }
    }
  }
}

class YLZMovieNavigationWidget extends StatelessWidget {
  const YLZMovieNavigationWidget({Key? key, required this.context})
      : super(key: key);

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
                child: Text("电视",
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(YLZColorTitleOne),
                        fontWeight: FontWeight.bold))),
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
    );
  }
}
