import 'package:dart_demo/base/config/YLZStyle.dart';
import 'package:dart_demo/logic/mguo/model/mg_home_model.dart';
import 'package:dart_demo/logic/mguo/model/mg_home_nav_model.dart';
import 'package:dart_demo/logic/mguo/view/mg_footer_ad_widget.dart';
import 'package:dart_demo/logic/mguo/view/mg_footer_button_widget.dart';
import 'package:dart_demo/logic/mguo/view/mg_footer_feedback_widget.dart';
import 'package:dart_demo/net/dao/mg_home_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class MGHomeTabPage extends StatefulWidget {
  final Mg_home_nav_model model;

  const MGHomeTabPage({Key? key, required this.model}) : super(key: key);

  @override
  _MGHomeTabPageState createState() => _MGHomeTabPageState();
}

class _MGHomeTabPageState extends State<MGHomeTabPage> {
  late Future _futureBuilderFuture;
  ScrollController _scrollController = new ScrollController();
  Mg_home_model homeModel = Mg_home_model();

  @override
  void initState() {
    super.initState();
    _futureBuilderFuture = _start(widget.model.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
        future: _futureBuilderFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Mg_home_model model = snapshot.data! as Mg_home_model;
            return contentChild(model);
          } else {
            return Container();
          }
        });
  }

  Widget contentChild(Mg_home_model homeModel) {
    if (widget.model.id == 0) {
      return Container(
        color: Color(MGColorMainView),
        child: CustomScrollView(
          slivers: _buildWidget(homeModel),
          reverse: false,
          controller: _scrollController,
        ),
      );
    }
    return Container(
      color: Colors.red,
    );
  }

  List<Widget> _buildWidget(Mg_home_model model) {
    List<Widget> widgetList = [];
    if (widget.model.id == 0) {
      widgetList.add(_BannerHeaderGrid(
        homeModel: model,
      ));
      widgetList.add(_MovieHeaderGrid(
        homeModel: model,
      ));
      widgetList.add(_TvHeaderGrid(
        homeModel: model,
      ));
      //添加电视剧下方的尾巴
      if ((model.video?.length ?? 0) > 0) {
        Video? video = model.video?[0];
        widgetList.add(_MGFooterGrid(video: video ?? Video(), isFinal: false));
      }
      int maxLength = (model.video?.length ?? 0);
      for (int index = 0; index < maxLength; index++) {
        Video? video = model.video?[index];
        video?.indexSection = index;
        widgetList.add(_VideoHeaderGrid(
          video: video ?? Video(),
        ));
        if (index == maxLength - 1) {
          widgetList.add(_MGFooterGrid(video: video ?? Video(), isFinal: true));
        } else {
          Video? videoModel = model.video?[index + 1];
          widgetList
              .add(_MGFooterGrid(video: videoModel ?? Video(), isFinal: false));
        }
      }
    }
    return widgetList;
  }

  Future _start(int id) async {
    Mg_home_model model;
    model = await MGHomeDao.dataLists(id);
    return model;
  }
}

class _BannerHeaderGrid extends StatelessWidget {
  final Mg_home_model homeModel;
  const _BannerHeaderGrid({Key? key, required this.homeModel})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
        header: buildHeaderContainer(),
        sliver: SliverPadding(
          padding: EdgeInsets.all(0.0),
          sliver: buildSliverGrid(context), //SliverGrid和GridView类似)
          //一组sliver类型的小部件
        ));
  }

  SliverGrid buildSliverGrid(BuildContext context) {
    double cellWidth = ((MediaQuery.of(context).size.width));
    double desiredCellHeight = 216;
    double childAspectRatio = cellWidth / desiredCellHeight;
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 0.0,
          childAspectRatio: childAspectRatio),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Container(
            color: Color(MGColorMainView),
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Column(
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0))),
                  child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        Slide sildeModel = homeModel.slide![index];
                        return ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)),
                            child: new FadeInImage.assetNetwork(
                              placeholder:
                                  "assets/images/ylz_blank_rectangle.png",
                              image: "${sildeModel.img}",
                              fit: BoxFit.cover,
                            ));
                      },
                      // viewportFraction: 0.8,
                      // scale: 0.9,
                      autoplay: true,
                      itemCount: homeModel.slide?.length ?? 0,
                      loop: true,
                      pagination: new SwiperPagination(
                          alignment: Alignment.bottomRight,
                          builder: DotSwiperPaginationBuilder(
                              activeColor: Color(YLZColorLightBlueView)))),
                ),
                Container(
                  color: Color(MGColorMainViewThree),
                  margin: EdgeInsets.only(top: 8),
                  height: 28,
                  child: Row(
                    children: [
                      Container(width: 72, color: Color(MGColorMainViewTwo))
                    ],
                  ),
                )
              ],
            ),
          );
        },
        childCount: 1,
      ),
    );
  }

  Container buildHeaderContainer() {
    return Container(height: 10.0, color: Color(MGColorMainView));
  }
}

class _MovieHeaderGrid extends StatelessWidget {
  final Mg_home_model homeModel;
  const _MovieHeaderGrid({Key? key, required this.homeModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
        header: buildHeaderContainer(),
        sliver: SliverPadding(
          padding: EdgeInsets.all(0.0),
          sliver: buildSliverGrid(context, homeModel), //SliverGrid和GridView类似)
          //一组sliver类型的小部件
        ));
  }

  SliverGrid buildSliverGrid(BuildContext context, Mg_home_model homeModel) {
    double cellWidth = ((MediaQuery.of(context).size.width));
    double desiredCellHeight = 182;
    double childAspectRatio = cellWidth / desiredCellHeight;
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: childAspectRatio),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Container(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                VideoModel videoModel = homeModel.hotvideo![index];
                return Container(
                  margin: EdgeInsets.only(
                      right: index == homeModel.hotvideo!.length - 1 ? 0 : 10),
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
                          style: TextStyle(color: Colors.white, fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: homeModel.hotvideo?.length ?? 0,
            ),
          );
        },
        childCount: 1,
      ),
    );
  }

  Container buildHeaderContainer() {
    return Container(
      alignment: Alignment.centerLeft,
      height: 44,
      color: Color(MGColorMainView),
      child: Padding(
        padding: EdgeInsets.only(left: 16),
        child: Text(
          "推荐电影",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class _TvHeaderGrid extends StatelessWidget {
  final Mg_home_model homeModel;
  const _TvHeaderGrid({Key? key, required this.homeModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
        header: buildHeaderContainer(),
        sliver: SliverPadding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          sliver: buildSliverGrid(context), //SliverGrid和GridView类似)
          //一组sliver类型的小部件
        ));
  }

  SliverGrid buildSliverGrid(BuildContext context) {
    double cellWidth = ((MediaQuery.of(context).size.width - 42) / 2);
    double desiredCellHeight = 136;
    double childAspectRatio = cellWidth / desiredCellHeight;
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: childAspectRatio),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          VideoModel? videoModel = homeModel.tv?.data?[index];
          return Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          child: new FadeInImage.assetNetwork(
                            placeholder:
                                "assets/images/ylz_blank_rectangle.png",
                            image: "${videoModel?.img ?? ""}",
                            fit: BoxFit.cover,
                          )),
                      width: cellWidth,
                      height: 100,
                    ),
                    Positioned(
                        right: 6,
                        bottom: 6,
                        child: Text(
                          "${videoModel?.qingxidu ?? ""}",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ))
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: cellWidth,
                  height: 36,
                  child: Text(
                    "${videoModel?.name ?? ""}",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          );
        },
        childCount: homeModel.tv?.data?.length ?? 0,
      ),
    );
  }

  Container buildHeaderContainer() {
    return Container(
      alignment: Alignment.centerLeft,
      height: 44,
      color: Color(MGColorMainView),
      child: Padding(
        padding: EdgeInsets.only(left: 16),
        child: Text(
          "电视剧",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class _VideoHeaderGrid extends StatelessWidget {
  final Video video;
  const _VideoHeaderGrid({Key? key, required this.video}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
        header: buildHeaderContainer(video),
        sliver: SliverPadding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          sliver: buildSliverGrid(context), //SliverGrid和GridView类似)
          //一组sliver类型的小部件
        ));
  }

  SliverGrid buildSliverGrid(BuildContext context) {
    if (video.indexSection == 0) {
      double cellWidth = ((MediaQuery.of(context).size.width - 42) / 2);
      double desiredCellHeight = 136;
      double childAspectRatio = cellWidth / desiredCellHeight;
      return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: childAspectRatio),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            VideoModel? videoModel = video.data?[index];
            return Container(
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
                              image: "${videoModel?.img ?? ""}",
                              fit: BoxFit.cover,
                            )),
                        width: cellWidth,
                        height: 100,
                      ),
                      Positioned(
                          right: 6,
                          bottom: 6,
                          child: Text(
                            "${videoModel?.qingxidu ?? ""}",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ))
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: cellWidth,
                    height: 36,
                    child: Text(
                      "${videoModel?.name ?? ""}",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            );
          },
          childCount: video.data?.length ?? 0,
        ),
      );
    } else {
      double cellWidth = (MediaQuery.of(context).size.width - 52) / 3;
      double desiredCellHeight = 196;
      double childAspectRatio = cellWidth / desiredCellHeight;
      return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: childAspectRatio),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            VideoModel? videoModel = video.data?[index];
            return Container(
                child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          child: new FadeInImage.assetNetwork(
                            placeholder:
                                "assets/images/ylz_blank_rectangle.png",
                            image: "${videoModel?.img ?? ""}",
                            fit: BoxFit.cover,
                          )),
                      width: cellWidth,
                      height: 160,
                    ),
                    Positioned(
                        right: 6,
                        bottom: 6,
                        child: Text(
                          "${videoModel?.score ?? ""}",
                          style:
                              TextStyle(color: Colors.deepOrange, fontSize: 16),
                        ))
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: cellWidth,
                  height: 36,
                  child: Text(
                    "${videoModel?.name ?? ""}",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ));
          },
          childCount: video.data?.length ?? 0,
        ),
      );
    }
  }

  Container buildHeaderContainer(Video video) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 44,
      color: Color(MGColorMainView),
      child: Padding(
        padding: EdgeInsets.only(left: 16),
        child: Text(
          "${video.name}",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class _MGFooterGrid extends StatelessWidget {
  final Video video;
  final bool isFinal;
  const _MGFooterGrid({Key? key, required this.video, required this.isFinal})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
        header: buildHeaderContainer(),
        sliver: SliverPadding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          sliver: buildSliverGrid(context), //SliverGrid和GridView类似)
          //一组sliver类型的小部件
        ));
  }

  SliverGrid buildSliverGrid(BuildContext context) {
    if (isFinal) {
      double cellWidth = MediaQuery.of(context).size.width - 32;
      double desiredCellHeight = 200;
      double childAspectRatio = cellWidth / desiredCellHeight;
      return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 0.0,
            childAspectRatio: childAspectRatio),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Container(
              // color: Colors.yellow,
              child: Column(
                children: [MGFooterButtonWidget(), MGFooterFeedBackWidget()],
              ),
            );
          },
          childCount: 1,
        ),
      );
    } else {
      if (video.ad != null) {
        double cellWidth = MediaQuery.of(context).size.width - 32;
        double desiredCellHeight = 254;
        double childAspectRatio = cellWidth / desiredCellHeight;
        return SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 0.0,
              childAspectRatio: childAspectRatio),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                // color: Colors.yellow,
                child: Column(
                  children: [
                    MGFooterButtonWidget(),
                    MGFooterAdWidget(
                      adModel: video.ad ?? AdModel(),
                    )
                  ],
                ),
              );
            },
            childCount: 1,
          ),
        );
      } else {
        double cellWidth = MediaQuery.of(context).size.width - 32;
        double desiredCellHeight = 76;
        double childAspectRatio = cellWidth / desiredCellHeight;
        return SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 0.0,
              childAspectRatio: childAspectRatio),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                // color: Colors.yellow,
                child: Column(
                  children: [MGFooterButtonWidget()],
                ),
              );
            },
            childCount: 1,
          ),
        );
      }
    }
  }

  Container buildHeaderContainer() {
    return Container(height: 0, color: Colors.transparent);
  }
}
