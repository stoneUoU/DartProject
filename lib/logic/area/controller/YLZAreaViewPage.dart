import 'package:dart_demo/logic/area/model/YLZAreaModel.dart';
import 'package:dart_demo/logic/area/model/YLZGeneralModel.dart';
import 'package:dart_demo/logic/area/view/YLZAreaHeaderWidget.dart';
import 'package:dart_demo/logic/area/view/YLZOpenListWidget.dart';
import 'package:dart_demo/logic/area/view/YLZUnOpenListWidget.dart';
import 'package:dart_demo/net/dao/area_dao.dart';
import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class YLZAreaViewPage extends StatefulWidget {
  final ValueChanged<int> onJumpTo;

  const YLZAreaViewPage({Key? key, required this.onJumpTo}) : super(key: key);

  @override
  _YLZAreaViewPageState createState() => _YLZAreaViewPageState();
}

class _YLZAreaViewPageState extends State<YLZAreaViewPage>
    with AutomaticKeepAliveClientMixin {
  late Future _futureBuilderFuture;

  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureBuilderFuture = _sendArea();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            YLZAreaHeaderWidget(
              clickListener: () {
                widget.onJumpTo(0);
              },
            ),
            FutureBuilder(
                future: _futureBuilderFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    YLZAreaModel areaModel = snapshot.data! as YLZAreaModel;
                    return Expanded(
                      child: Container(
                        color: Colors.white,
                        child: CustomScrollView(
                          slivers: _buildWidget(areaModel),
                          reverse: false,
                          controller: _scrollController,
                        ),
                      ),
                    );
                  } else {
                    return _buildSpinKitFadingCircle();
                  }
                })
          ],
        ),
      ),
    );
  }

  Expanded _buildSpinKitFadingCircle() {
    return Expanded(child: SpinKitFadingCircle(
      itemBuilder: (_, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Colors.red : Colors.green,
          ),
        );
      },
    ));
  }

  List<Widget> _buildWidget(YLZAreaModel areaModel) {
    List<Widget> widgetList = [];
    List<YLZGeneralModel> modelList = [
      YLZGeneralModel.fromJson({"title": "", "indexTag": 0}),
      YLZGeneralModel.fromJson({"title": "地方专区", "indexTag": 1}),
      YLZGeneralModel.fromJson({"title": "更多地方专区正在接入中...", "indexTag": 2})
    ];
    for (int i = 0; i < modelList.length; i++) {
      widgetList
          .add(_StickyHeaderGrid(model: modelList[i], areaModel: areaModel));
    }
    return widgetList;
  }

  _sendArea() async {
    YLZAreaModel model = await AreaDao.module();
    return model;
  }

  // Future<void> _getCurrentPosition() async {
  //   final hasPermission = await _handlePermission();
  //
  //   if (!hasPermission) {
  //     return;
  //   }
  //
  //   final position = await _geolocatorPlatform.getCurrentPosition();
  //   _updatePositionList(
  //     _PositionItemType.position,
  //     position.toString(),
  //   );
  // }
  //
  // Future<bool> _handlePermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   // Test if location services are enabled.
  //   serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     _updatePositionList(
  //       _PositionItemType.log,
  //       _kLocationServicesDisabledMessage,
  //     );
  //
  //     return false;
  //   }
  //
  //   permission = await _geolocatorPlatform.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await _geolocatorPlatform.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       _updatePositionList(
  //         _PositionItemType.log,
  //         _kPermissionDeniedMessage,
  //       );
  //
  //       return false;
  //     }
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     _updatePositionList(
  //       _PositionItemType.log,
  //       _kPermissionDeniedForeverMessage,
  //     );
  //
  //     return false;
  //   }
  //
  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   _updatePositionList(
  //     _PositionItemType.log,
  //     _kPermissionGrantedMessage,
  //   );
  //   return true;
  // }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class _StickyHeaderGrid extends StatelessWidget {
  const _StickyHeaderGrid(
      {Key? key, required this.model, required this.areaModel})
      : super(key: key);
  final YLZGeneralModel model;
  final YLZAreaModel areaModel;
  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
        sticky: false,
        header: buildHeaderContainer(model),
        sliver: SliverPadding(
          padding: EdgeInsets.all(16.0),
          sliver: buildSliverGrid(
              context, model, areaModel), //SliverGrid和GridView类似)
          //一组sliver类型的小部件
        ));
  }

  SliverGrid buildSliverGrid(
      BuildContext context, YLZGeneralModel model, YLZAreaModel areaModel) {
    if (model.indexTag == 0) {
      double cellWidth = (MediaQuery.of(context).size.width - 32);
      double desiredCellHeight = 160;
      double childAspectRatio = cellWidth / desiredCellHeight;
      return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: childAspectRatio),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    width: cellWidth,
                    height: desiredCellHeight,
                    child: Image.asset('assets/images/ylz_area_bg.png',
                        fit: BoxFit.fill)),
                Positioned(
                  child: Image.asset('assets/images/ylz_area_china.png',
                      fit: BoxFit.fill),
                  right: 0,
                  bottom: 0,
                )
              ],
            );
          },
          childCount: 1,
        ),
      );
    } else if (model.indexTag == 1) {
      double cellWidth = (MediaQuery.of(context).size.width - 32) / 4;
      double desiredCellHeight = 88;
      double childAspectRatio = cellWidth / desiredCellHeight;
      return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: childAspectRatio),
        delegate: SliverChildBuilderDelegate(
          (context, i) {
            OpenList openList = areaModel.openList![i];
            return YLZOpenListWidget(openList: openList);
          },
          childCount: areaModel.openList!.length,
        ),
      );
    } else {
      double cellWidth = (MediaQuery.of(context).size.width - 32) / 4;
      double desiredCellHeight = 88;
      double childAspectRatio = cellWidth / desiredCellHeight;
      return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: childAspectRatio),
        delegate: SliverChildBuilderDelegate(
          (context, i) {
            if (i == areaModel.unOpenList!.length) {
              return YLZUnOpenListWidget(
                  unOpenList: UnOpenList(), isMore: true);
            }
            UnOpenList unOpenList = areaModel.unOpenList![i];
            return YLZUnOpenListWidget(
                unOpenList: unOpenList,
                isMore: i == areaModel.unOpenList!.length);
          },
          childCount: areaModel.unOpenList!.length + 1,
        ),
      );
    }
  }

  Container buildHeaderContainer(YLZGeneralModel model) {
    if (model.indexTag == 0) {
      return Container(
        height: 0.0,
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
      );
    } else {
      return Container(
        height: 44,
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              model.title ?? "",
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ],
        ),
      );
    }
  }
}
