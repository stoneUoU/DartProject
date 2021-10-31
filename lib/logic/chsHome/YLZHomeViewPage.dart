import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:FlutterProject/base/navigator/HiNavigator.dart';
import 'package:FlutterProject/logic/chsHome/model/YLZDynamicModel.dart';
import 'package:FlutterProject/logic/chsHome/model/YLZModuleModel.dart';
import 'package:FlutterProject/logic/chsHome/view/YLZHomeHeaderWidget.dart';
import 'package:FlutterProject/logic/chsHome/view/YLZHomeNavigationWithSearchWidget.dart';
import 'package:FlutterProject/logic/chsHome/view/cell/YLZHomeElecWidget.dart';
import 'package:FlutterProject/logic/chsHome/view/cell/YLZHomeOrganizationWidget.dart';
import 'package:FlutterProject/logic/chsHome/view/cell/YLZHomeQueryServiceWidget.dart';
import 'package:FlutterProject/logic/chsHome/view/cell/YLZHomeSinewsWidget.dart';
import 'package:FlutterProject/logic/chsHome/view/cell/YLZHomeTaxWidget.dart';
import 'package:FlutterProject/net/dao/home_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class YLZHomeViewPage extends StatefulWidget {
  final ValueChanged<int> onJumpTo;

  const YLZHomeViewPage({Key? key, required this.onJumpTo}) : super(key: key);

  @override
  _YLZHomeViewPageState createState() => _YLZHomeViewPageState();
}

class _YLZHomeViewPageState extends State<YLZHomeViewPage>
    with AutomaticKeepAliveClientMixin {
  late Future _futureBuilderFuture;
  YLZDynamicModel _dynamicModel = YLZDynamicModel();
  ScrollController _scrollController = new ScrollController();

  GlobalKey<YLZHomeNavigationWithSearchWidgetState>
      homeNavigationWithSearchWidgetStateKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("YLZHomeViewPage === initState");
    if (!mounted) return;
    _futureBuilderFuture = _start();
    _scrollController.addListener(() {
      double offset = _scrollController.position.pixels;
      if (offset > StatusH(context) + NaviH ||
          offset == StatusH(context) + NaviH) {
        //偏移量>导航栏的高度
        homeNavigationWithSearchWidgetStateKey.currentState
            ?.changeHomeOpacity(1.0, 0.0);
      } else if (offset < 0 || offset == 0) {
        homeNavigationWithSearchWidgetStateKey.currentState
            ?.changeHomeOpacity(0.0, 1.0);
      } else {
        homeNavigationWithSearchWidgetStateKey.currentState?.changeHomeOpacity(
            offset / (StatusH(context) + NaviH),
            1.0 - offset / (StatusH(context) + NaviH));
        if (offset > NaviH) {
          homeNavigationWithSearchWidgetStateKey.currentState
              ?.changeOffset(NaviH);
        } else {
          homeNavigationWithSearchWidgetStateKey.currentState
              ?.changeOffset(offset);
        }
        print("滑动距离${offset}}");
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultStickyHeaderController(
        child: Scaffold(
            body: FutureBuilder(
                future: _futureBuilderFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    YLZModuleModel model = snapshot.data! as YLZModuleModel;
                    List<HomePage> homePageList = model.homePage!;
                    return Stack(
                      children: [
                        Container(
                          child: CustomScrollView(
                            slivers: _buildWidget(homePageList),
                            reverse: false,
                            controller: _scrollController,
                          ),
                          color: Colors.white,
                        ),
                        Positioned(
                            top: 0,
                            left: 0,
                            child: YLZHomeNavigationWithSearchWidget(
                                homeNavigationWithSearchWidgetStateKey, () {
                              // print("点击");
                              widget.onJumpTo(1);
                            }))
                      ],
                    );
                  } else {
                    return buildSpinKitFadingCircle();
                  }
                })));
  }

  List<Widget> _buildWidget(List<HomePage> list) {
    List<Widget> widgetList = [];
    for (int i = 0; i < list.length; i++) {
      widgetList.add(_StickyHeaderGrid(list[i], _dynamicModel, index: i));
    }
    widgetList.add(_StickyFootGrid());
    return widgetList;
  }

  Center buildSpinKitFadingCircle() {
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

  Future _start() async {
    YLZModuleModel model = await HomeDao.module("1.3.2", 2);
    // if (model.homePage) {}
    for (int i = 0; i < model.homePage!.length; i++) {
      HomePage homePage = model.homePage![i];
      if (homePage.key == "si_news") {
        _dynamicNews();
      }
    }
    return model;
  }

  _dynamicNews() async {
    YLZDynamicModel model = await HomeDao.dynamicNews();
    if (!mounted) return;
    setState(() {
      _dynamicModel = model;
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class _StickyHeaderGrid extends StatelessWidget {
  const _StickyHeaderGrid(this.homePage, this.dynamicModel,
      {Key? key, this.index})
      : super(key: key);

  final int? index;
  final HomePage? homePage;
  final YLZDynamicModel? dynamicModel;

  @override
  Widget build(BuildContext context) {
    var homePageKey = homePage?.key ?? "";
    var titleString = homePage?.content ?? "";

    return SliverStickyHeader(
        header: buildHeaderContainer(homePageKey, titleString),
        sliver: SliverPadding(
          padding: homePageKey == "voucher"
              ? EdgeInsets.all(0.0)
              : EdgeInsets.all(16.0),
          sliver: buildSliverGrid(
              context, homePage, dynamicModel), //SliverGrid和GridView类似)
          //一组sliver类型的小部件
        ));
  }

  SliverGrid buildSliverGrid(
      BuildContext context, HomePage? homePage, YLZDynamicModel? dynamicModel) {
    var homePageKey = homePage?.key ?? "";
    List<Childs>? homeSonPageList = homePage?.childs;
    if (homePageKey == "organization") {
      return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 10 / 3.5),
        delegate: SliverChildBuilderDelegate(
          (context, i) {
            Childs homeSonPage = homeSonPageList![i] as Childs;
            return YLZHomeOrganizationWidget(homeSonPage: homeSonPage);
          },
          childCount: homeSonPageList?.length,
        ),
      );
    } else if (homePageKey == "si_news") {
      int childCount = dynamicModel?.list?.length ?? 0;
      int childLength = dynamicModel?.list?.length ?? 1;
      return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 10 / 3),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (childCount == 0) {
              return Container(
                color: Colors.red,
              );
            } else {
              return YLZHomeSinewsWidget(index, dynamicModel);
            }
          },
          childCount: childLength > 2 ? 2 : childLength,
        ),
      );
    } else if (homePageKey == "tax") {
      return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 10 / 3),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return YLZHomeTaxWidget();
          },
          childCount: 1,
        ),
      );
    } else if (homePageKey == "hot_service") {
      double cellWidth = ((MediaQuery.of(context).size.width - 48) / 2);
      double desiredCellHeight = 70;
      double childAspectRatio = cellWidth / desiredCellHeight;
      return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: childAspectRatio),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            Childs homeSonPage = homeSonPageList![index] as Childs;
            return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                ),
                child: Stack(children: [
                  new Container(
                    child: ClipRRect(
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/images/ylz_blank_rectangle.png",
                        image: homeSonPage.item?.imgUrl ?? "",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                      child: Text(homeSonPage.item?.content ?? ""),
                      left: 16,
                      top: 30)
                ]));
          },
          childCount: homeSonPageList?.length,
        ),
      );
    } else if (homePageKey == "query_service") {
      double cellWidth = (MediaQuery.of(context).size.width - 32);
      double desiredCellHeight = 118;
      double childAspectRatio = cellWidth / desiredCellHeight;

      return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: childAspectRatio),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            Childs insureModel = homeSonPageList![0] as Childs;
            Childs payModel = homeSonPageList[1] as Childs;
            Childs consumeModel = homeSonPageList[2] as Childs;
            return YLZHomeQueryServiceWidget(
                cellWidth: cellWidth,
                insureModel: insureModel,
                payModel: payModel,
                consumeModel: consumeModel);
          },
          childCount: 1,
        ),
      );
    } else {
      double cellWidth = (MediaQuery.of(context).size.width);
      double desiredCellHeight = 400 + StatusH(context);
      double childAspectRatio = cellWidth / desiredCellHeight;
      return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 0.0,
            crossAxisCount: 1,
            childAspectRatio: childAspectRatio),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return InkWell(
              child: YLZHomeElecWidget(homePage,
                  cellWidth: cellWidth, desiredCellHeight: desiredCellHeight),
              onTap: () {
                HiNavigator().onJumpTo(RouteStatus.elecCode);
              },
            );
          },
          childCount: 1,
        ),
      );
    }
  }

  Container buildHeaderContainer(String homePageKey, String titleString) {
    if (homePageKey == "organization" ||
        homePageKey == "si_news" ||
        homePageKey == "hot_service") {
      return Container(
          child: YLZHomeHeaderWidget(
        titleString: titleString,
        homePageKey: homePageKey,
      ));
    } else if (homePageKey == "voucher") {
      return Container(height: 0, color: Colors.transparent);
    } else {
      return Container(height: 10, color: Colors.transparent);
    }
  }
}

class _StickyFootGrid extends StatelessWidget {
  const _StickyFootGrid({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
        sticky: false,
        header: buildFooterContainer(),
        sliver: SliverPadding(
          padding: EdgeInsets.all(0.0),
          sliver: buildSliverGrid(context), //SliverGrid和GridView类似)
          //一组sliver类型的小部件
        ));
  }

  SliverGrid buildSliverGrid(BuildContext context) {
    double cellWidth = ((MediaQuery.of(context).size.width - 48) / 2);
    double desiredCellHeight = 48;
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
            child: Center(
              child: Text(
                "本服务由国家医疗保障局提供",
                style: TextStyle(color: Color(YLZColorTitleThree)),
              ),
            ),
          );
        },
        childCount: 1,
      ),
    );
  }

  Container buildFooterContainer() {
    return Container(height: 0, color: Colors.transparent);
  }
}
