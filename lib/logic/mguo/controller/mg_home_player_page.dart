import 'dart:convert';
import 'dart:developer';

import 'package:common_utils/common_utils.dart';
import 'package:dart_demo/base/navigator/HiNavigator.dart';
import 'package:dart_demo/logic/mguo/model/mg_father_video_player_model.dart';
import 'package:dart_demo/logic/mguo/model/mg_video_decode_model.dart';
import 'package:dart_demo/logic/mguo/model/mg_video_detail_model.dart';
import 'package:dart_demo/logic/mguo/model/mg_video_parse_model.dart';
import 'package:dart_demo/logic/mguo/view/VideoView.dart';
import 'package:dart_demo/net/dao/mg_video_dao.dart';
import 'package:dart_demo/net/db/hi_cache.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rsa_util/rsa_util.dart';

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
  final publicKeyString =
      "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC3jrJKw+DB2MO7KRTFdLeaciv+3SDNDSnuc3KtUuIwPuVwrbGnVmgRej6VuRwNA4Qx/CvVaKly1Wijsb/HdP5WXFeAGHzO2JuRrTOYrAlm/H09oAIoQk7KMAEfM9sM5h2jDiZc+GJ7h5f8VBitH1b0RjvTKufhk9AHU/dEyI2YNQIDAQAB\n-----END PUBLIC KEY-----";

  @override
  void initState() {
    // TODO: implement initState
    _futureBuilderFuture = _start();
  }

  @override
  void dispose() {
    super.dispose();
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
                return _buildWidget();
              } else {
                return _buildSpinKitFadingCircle();
              }
            }));
  }

  Widget _buildWidget() {
    return VideoView(
      "https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4",
      cover:
          "https://pic.ntimg.cn/BannerPic/20210521/design/20210521194418.jpg",
      overlayUI: videoAppBar(),
      barrageUI: Container(),
    );
  }

  ///黑色线性渐变
  blackLinearGradient({bool fromTop = false}) {
    return LinearGradient(
        begin: fromTop ? Alignment.topCenter : Alignment.bottomCenter,
        end: fromTop ? Alignment.bottomCenter : Alignment.topCenter,
        colors: [
          Colors.black54,
          Colors.black45,
          Colors.black38,
          Colors.black26,
          Colors.black12,
          Colors.transparent
        ]);
  }

  ///视频详情页appBar
  videoAppBar() {
    return Container(
      padding: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(gradient: blackLinearGradient(fromTop: true)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BackButton(
            color: Colors.white,
          ),
          Row(
            children: [
              Icon(Icons.live_tv_rounded, color: Colors.white, size: 20),
              Padding(
                padding: EdgeInsets.only(left: 12),
                child: Icon(Icons.more_vert_rounded,
                    color: Colors.white, size: 20),
              )
            ],
          )
        ],
      ),
    );
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
    }
    _decodeVideo(totalVideolist[1].from ?? "",
        totalVideolist[1].videoModel?[0].playerUrl ?? "");
  }

  Future _start() async {
    MGVideoDetailModel detailModel = await MGHomeVideoDao.videoInfo(widget.id);
    return detailModel;
  }

  Future _decodeVideo(String playerCode, String videoString) async {
    MGVideoDecodeModel decodeModel =
        await MGHomeVideoDao.videoDecode(playerCode);
    String parseUrl = await _loadData(decodeModel.data ?? "");

    _parseUrl(parseUrl, videoString);
  }

  Future<String> _loadData(String message) async {
    RSAUtil rsa = RSAUtil.getInstance(publicKeyString, "");
    var rsaResult = rsa.decryptByPublicKey(message);
    return rsaResult;
  }

  Future _parseUrl(String parseUrl, String videoString) async {
    //获取毫秒级时间戳：
    String timeStampString =
        new DateTime.now().millisecondsSinceEpoch.toString();
    HiCache.getInstance().setString("milliseconds", timeStampString);

    String saltString = "043730226d9ada98";
    String secretString = "${saltString}${timeStampString}";

    Map<String, String> headers = {
      "AUTHORIZE": EncryptUtil.encodeMd5(secretString)
    };
    dio.options.headers.addAll({});
    var data = {
      "url": videoString,
      "tm": HiCache.getInstance().get("milliseconds")
    };
    var response =
        await dio.get("${parseUrl}&url=${data["url"]}&tm=${data["tm"]}");
    MGVideoParseModel parseModel =
        MGVideoParseModel.fromJson(json.decode(response.data));
    //最终获取到了视频数据：
    log("url___________${parseModel.url}");
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
