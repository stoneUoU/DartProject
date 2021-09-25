import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:FlutterProject/provider/YLZCounter.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class YLZShopCartPage extends StatefulWidget {
  const YLZShopCartPage({Key? key}) : super(key: key);

  @override
  _YLZShopCartPageState createState() => _YLZShopCartPageState();
}

class _YLZShopCartPageState extends State<YLZShopCartPage> {
  static const String _kLocationServicesDisabledMessage =
      'Location services are disabled.';
  static const String _kPermissionDeniedMessage = 'Permission denied.';
  static const String _kPermissionDeniedForeverMessage =
      'Permission denied forever.';
  static const String _kPermissionGrantedMessage = 'Permission granted.';

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: buildContainer(context));
  }

  Container buildContainer(BuildContext context) {
    return new Container(
      width: ScreenW(context),
      height: ScreenH(context) -
          kBottomNavigationBarHeight -
          TabbarSafeBottomM(context),
      color: Colors.white,
      child: new Center(
          child: Container(
        width: ScreenW(context),
        height: 200,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 24),
              child: InkWell(
                onTap: () {
                  // _startProvider();
                  _getCurrentPosition();
                },
                child: new Text("测试网络请求",
                    style: new TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Color(YLZColorLightBlueView)),
                    textAlign: TextAlign.center),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 24),
              child: Text('${context.watch<YLZCounter>().value}',
                  key: const Key('counterState'),
                  style: Theme.of(context).textTheme.headline4),
            )
          ],
        ),
      )),
    );
  }

  // void _startProvider() {
  //   context.read<YLZCounter>().increment();
  //   // context.read<YLZTabbarProvider>().setSelectedIndex(0);
  // }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();
    _updatePositionList(
      _PositionItemType.position,
      position.toString(),
    );
  }

  void _updatePositionList(_PositionItemType type, String displayValue) {
    print("_____${type}__________${displayValue}");
    setState(() {});
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      _updatePositionList(
        _PositionItemType.log,
        _kLocationServicesDisabledMessage,
      );

      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        _updatePositionList(
          _PositionItemType.log,
          _kPermissionDeniedMessage,
        );

        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      _updatePositionList(
        _PositionItemType.log,
        _kPermissionDeniedForeverMessage,
      );

      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    _updatePositionList(
      _PositionItemType.log,
      _kPermissionGrantedMessage,
    );
    return true;
  }
}

enum _PositionItemType {
  log,
  position,
}

// import 'package:FlutterProject/base/config/YLZMacros.dart';
// import 'package:FlutterProject/base/config/YLZStyle.dart';
// import 'package:FlutterProject/logic/mine/YLZModel.dart';
// import 'package:FlutterProject/net/dao/login_dao.dart';
// import 'package:FlutterProject/provider/YLZCounter.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:logger/logger.dart';
// import 'package:provider/provider.dart';
//
// class YLZShopCartPage extends StatefulWidget {
//   const YLZShopCartPage({Key? key}) : super(key: key);
//
//   @override
//   _YLZShopCartPageState createState() => _YLZShopCartPageState();
// }
//
// class _YLZShopCartPageState extends State<YLZShopCartPage> {
//   final _log = Logger();
//
//   late Future _futureBuilderFuture;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     if (!mounted) return;
//     _futureBuilderFuture = _start();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         body: FutureBuilder(
//             future: _futureBuilderFuture,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 YLZModel model = snapshot.data! as YLZModel;
//                 List<HomePage> homePageList = model.homePage!;
//                 HomePage homePage = homePageList[0];
//                 return buildContainer(context);
//               } else {
//                 return Center(child: SpinKitFadingCircle(
//                   itemBuilder: (_, int index) {
//                     return DecoratedBox(
//                       decoration: BoxDecoration(
//                         color: index.isEven ? Colors.red : Colors.green,
//                       ),
//                     );
//                   },
//                 ));
//               }
//             }));
//   }
//
//   Container buildContainer(BuildContext context) {
//     return new Container(
//       width: ScreenW(context),
//       height: ScreenH(context) -
//           kBottomNavigationBarHeight -
//           TabbarSafeBottomM(context),
//       color: Colors.white,
//       child: new Center(
//           child: Container(
//         width: ScreenW(context),
//         height: 200,
//         child: Column(
//           children: [
//             Container(
//               margin: EdgeInsets.only(top: 24),
//               child: InkWell(
//                 onTap: () {
//                   _startProvider();
//                 },
//                 child: new Text("测试网络请求",
//                     style: new TextStyle(
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.w500,
//                         color: Color(YLZColorLightBlueView)),
//                     textAlign: TextAlign.center),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 24),
//               child: Text('${context.watch<YLZCounter>().value}',
//                   key: const Key('counterState'),
//                   style: Theme.of(context).textTheme.headline4),
//             )
//           ],
//         ),
//       )),
//     );
//   }
//
//   void _startProvider() {
//     context.read<YLZCounter>().increment();
//   }
//
//   Future _start() async {
//     YLZModel model = await HomeDao.module("1.3.2", 2);
//     return model;
//
//     // var result = HotDao.module("1", "1");
//
//     // var data = {
//     //   "signType": "plain",
//     //   "data": {"type": "1", "clntType": "1"},
//     //   "encType": "plain",
//     //   "version": "1.1.7",
//     //   "timestamp": 1599036663,
//     //   "appId": "19E179E5DC29C05E65B90CDE57A1C7E5"
//     // };
//     // Response response;
//     // Options option = Options(headers: {"Content-Type": "application/json"});
//     // var dio = new Dio();
//     // response = await dio.post(
//     //     'https://fuwu-test.nhsa.gov.cn/ebus/fuwu/api/base/api/bmgt/hotWord/getAppHotWordList',
//     //     data: data ,options: option);
//     // print("___________$response");
//   }
// }
