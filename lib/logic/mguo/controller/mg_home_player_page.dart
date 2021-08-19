import 'dart:convert';
import 'dart:developer';

import 'package:dart_demo/base/navigator/HiNavigator.dart';
import 'package:dart_demo/logic/mguo/model/mg_father_video_player_model.dart';
import 'package:dart_demo/logic/mguo/model/mg_video_decode_model.dart';
import 'package:dart_demo/logic/mguo/model/mg_video_detail_model.dart';
import 'package:dart_demo/net/dao/mg_video_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MGHomePlayerPage extends StatefulWidget {
  final int id;

  const MGHomePlayerPage({Key? key, required this.id}) : super(key: key);

  @override
  _MGHomePlayerPageState createState() => _MGHomePlayerPageState();
}

class _MGHomePlayerPageState extends State<MGHomePlayerPage> {
  late Future _futureBuilderFuture;
  Dio dio = Dio();
  List<MGFatherVideoPlayerModel> videolists = [];
  @override
  void initState() {
    // TODO: implement initState
    _futureBuilderFuture = _start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //让title居左
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleSpacing: 0,
          leading: BackButton(onPressed: () {
            // HiNavigator().onJumpTo(RouteStatus.home);
            HiNavigator().pop(context);
          }),
          title: Text(
            "返回",
            style: TextStyle(fontSize: 18),
          ),
        ),
        body: FutureBuilder(
            future: _futureBuilderFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                MGVideoDetailModel model = snapshot.data! as MGVideoDetailModel;
                //进行数据处理：
                dealRecord(model);
                return Container();
              } else {
                return _buildSpinKitFadingCircle();
              }
            }));
  }

  Widget buildWidget() {
    return Container();
  }

  void dealRecord(MGVideoDetailModel model) {
    List<MGFatherVideoPlayerModel> totalVideolist = [];
    String exampleString = model.playlist ?? "";
    List<String> stringList = [];
    stringList = exampleString.split("\$\$\$");

    for (int index = 0; index < model.playerInfo!.length; index++) {
      String sectionUrlString = stringList[index];
      List<String> sectionUrlStringList = sectionUrlString.split("#");

      List<String> sectionUrlNewStringList = [];
      for (int a = 0; a < sectionUrlStringList.length; a++) {
        String str = sectionUrlStringList[a];
        if (str.length != 0) {
          sectionUrlNewStringList.add(str);
        }
      }
      List<Map> sectionUrlModelList = [];
      Player_info playerInfoModel = model.playerInfo![index];
      for (int j = 0; j < sectionUrlNewStringList.length; j++) {
        String endUrlString = sectionUrlNewStringList[j];
        List<String> endUrlStringList = endUrlString.split("\$");
        Map<String, dynamic> endUrlMap = {
          "from": playerInfoModel.from,
          "videoName": model.name,
          "img": model.img,
          "sectionName": endUrlStringList[0].toString(),
          "playerUrl": endUrlStringList[1].toString(),
          "isMovie": model.isMovie,
          "show": playerInfoModel.show,
          "videoId": widget.id
        };
        // MGVideoPlayerModel playerModel = MGVideoPlayerModel.fromJson(endUrlMap);
        sectionUrlModelList.add(endUrlMap);
      }
      Map<String, dynamic> endUrlMap = {
        "videoModel": sectionUrlModelList,
        "show": playerInfoModel.show,
        "from": playerInfoModel.from,
        "icon": playerInfoModel.icon
      };
      totalVideolist.add(MGFatherVideoPlayerModel.fromJson(endUrlMap));

      // setState(() {
      //   videolists = totalVideolist;
      // });
    }
    _decodeVideo(totalVideolist[1].from ?? "");
  }

  Future _start() async {
    MGVideoDetailModel detailModel = await MGHomeVideoDao.videoInfo(widget.id);
    return detailModel;
  }

  Future _decodeVideo(String playerCode) async {
    MGVideoDecodeModel decodeModel =
        await MGHomeVideoDao.videoDecode(playerCode);
    log("json_______________${json.encode(decodeModel)}");
  }

  Future<String> _loadData() async {
    var publicKeyStr =
        "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC3jrJKw+DB2MO7KRTFdLeaciv+3SDNDSnuc3KtUuIwPuVwrbGnVmgRej6VuRwNA4Qx/CvVaKly1Wijsb/HdP5WXFeAGHzO2JuRrTOYrAlm/H09oAIoQk7KMAEfM9sM5h2jDiZc+GJ7h5f8VBitH1b0RjvTKufhk9AHU/dEyI2YNQIDAQAB\n-----END PUBLIC KEY-----";
    var publicKey = RSAKeyParser().parse(publicKeyStr);
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    return await encrypter.decrypt(Encrypted.fromBase64(content));

    // String url = "/";
    // var data = {"reportId": widget.reportId, "userId": "9"};
    // var response = await dio.post("${RainBowUrl}${url}", data: data);
    // if (response.data["flag"] == 1) {
    //   if (mounted) {
    //     setState(() {
    //       try {
    //         this.renderMs =
    //         new YLZReportDetailModel.fromJson(response.data["rs"]);
    //       } catch (e) {
    //         print(e);
    //       }
    //     });
    //   }
    // } else {
    //   print(response);
    // }
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
}
