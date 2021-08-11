import 'package:dart_demo/base/config/YLZMacros.dart';
import 'package:dart_demo/base/config/YLZStyle.dart';
import 'package:dart_demo/provider/YLZCounter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YLZShopCartPage extends StatefulWidget {
  const YLZShopCartPage({Key? key}) : super(key: key);

  @override
  _YLZShopCartPageState createState() => _YLZShopCartPageState();
}

class _YLZShopCartPageState extends State<YLZShopCartPage> {
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
                  _startProvider();
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

  void _startProvider() {
    context.read<YLZCounter>().increment();
    // context.read<YLZTabbarProvider>().setSelectedIndex(0);
  }
}

// import 'package:dart_demo/base/config/YLZMacros.dart';
// import 'package:dart_demo/base/config/YLZStyle.dart';
// import 'package:dart_demo/logic/mine/YLZModel.dart';
// import 'package:dart_demo/net/dao/login_dao.dart';
// import 'package:dart_demo/provider/YLZCounter.dart';
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
