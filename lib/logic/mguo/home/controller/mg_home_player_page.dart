import 'dart:convert';
import 'dart:developer';

import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:FlutterProject/base/view/YLZNormalView.dart';
import 'package:FlutterProject/logic/mguo/home/model/mg_ad_model.dart';
import 'package:FlutterProject/logic/mguo/home/model/mg_father_video_player_model.dart';
import 'package:FlutterProject/logic/mguo/home/model/mg_home_model.dart';
import 'package:FlutterProject/logic/mguo/home/model/mg_video_decode_model.dart';
import 'package:FlutterProject/logic/mguo/home/model/mg_video_detail_model.dart';
import 'package:FlutterProject/logic/mguo/home/model/mg_video_parse_model.dart';
import 'package:FlutterProject/logic/mguo/home/model/mg_video_player_model.dart';
import 'package:FlutterProject/logic/mguo/home/view/mg_video_widget.dart';
import 'package:FlutterProject/net/dao/mguo/mg_video_dao.dart';
import 'package:FlutterProject/net/db/hi_cache.dart';
import 'package:FlutterProject/provider/MGVideoDetailProvider.dart';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
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
  bool adShow = true;
  //选中的渠道：
  int selectedChannel = 0;
  //选中的集数：
  int selectedRow = 0;

  @override
  void initState() {
    // TODO: implement initState
    _futureBuilderFuture = _start();
    // _decodeVideo(totalVideolist[1].from ?? "",
    //     totalVideolist[1].videoModel?[0].playerUrl ?? "");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: _futureBuilderFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List dataList = (snapshot.data as List).cast();
                MGVideoDetailModel model = dataList[0] as MGVideoDetailModel;
                MGAdModel adModel = dataList[1] as MGAdModel;
                //进行数据处理：
                MGVideoDetailModel modelAfterDeal = dealRecord(model);
                return _buildWidget(modelAfterDeal, adModel);
              } else {
                return _buildSpinKitFadingCircle();
              }
            }));
  }

  Widget _buildWidget(MGVideoDetailModel model, MGAdModel adModel) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: MGVideoWidget(
              "https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4",
              cover:
                  "https://pic.ntimg.cn/BannerPic/20210521/design/20210521194418.jpg",
              overlayUI: videoAppBar(),
              barrageUI: Container(),
            ),
          ),
          Container(
              height: ScreenH(context) -
                  (ScreenW(context) * 9 / 16 + TabbarSafeBottomM(context)),
              child: ListView(
                  padding:
                      EdgeInsets.fromLTRB(0, 0, 0, TabbarSafeBottomM(context)),
                  scrollDirection: Axis.vertical,
                  children: [
                    _buildTitleWidget(model),
                    _buildToolsWidget(),
                    _buildAdsWidget(adModel),
                    _buildPlayerListWidget(model),
                    _buildLovesListWidget(model),
                  ]))
        ],
      ),
      color: Color(MGColorMainView),
    );
  }

  Container _buildLovesListWidget(MGVideoDetailModel model) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "猜你喜欢",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 16),
            height: 188,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                VideoModel videoModel = model.likes![index];
                return Container(
                  margin: EdgeInsets.only(
                      right: index == model.likes!.length - 1 ? 0 : 10),
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
              itemCount: model.likes?.length ?? 0,
            ),
          )
        ],
      ),
    );
  }

  Container _buildPlayerListWidget(MGVideoDetailModel model) {
    MGFatherVideoPlayerModel channelModel = MGFatherVideoPlayerModel();
    model.totalVideolist.forEach((element) {
      MGFatherVideoPlayerModel eleMent = element as MGFatherVideoPlayerModel;
      if (eleMent.selected) {
        channelModel = eleMent;
      }
    });
    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "播放列表",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  InkWell(
                    child: Text(
                      "  简介 ",
                      style: TextStyle(
                          color: Color(YLZColorTitleTwo), fontSize: 16),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return _buildIntroAlert(model);
                          });
                    },
                  ),
                  Image.asset(
                    'assets/images/ylz_arrow_right.png',
                    fit: BoxFit.fill,
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    child: Text(
                      "更新至${channelModel.videoModel?.length ?? 0}集",
                      style: TextStyle(
                          color: Color(YLZColorTitleTwo), fontSize: 14),
                    ),
                    onTap: () {
                      log("更新至n集");
                    },
                  ),
                  Image.asset(
                    'assets/images/ylz_arrow_right.png',
                    fit: BoxFit.fill,
                  ),
                ],
              )
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 16, 0, 16),
            height: 44,
            width: ScreenW(context) - 32,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                MGVideoPlayerModel playerModel =
                    channelModel.videoModel![index];
                return Container(
                    margin: EdgeInsets.only(right: index == 9 ? 0 : 10),
                    child: InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        width: (model.isMovie ?? false) ? 96 : 44,
                        height: 44,
                        decoration: new BoxDecoration(
                            color: Color(playerModel.selected!
                                ? MGColorMainViewTwo
                                : MGColorMainView),
                            border: new Border.all(
                              color: Color(MGColorMainViewTwo),
                              width: 1.0,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0))),
                        child: Text(
                          (model.isMovie ?? false)
                              ? "${playerModel.sectionName}"
                              : "${index + 1}",
                          style: TextStyle(
                              color: playerModel.selected!
                                  ? Colors.white
                                  : Color(YLZColorTitleThree),
                              fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      onTap: () {
                        print("${index}");
                        if (selectedRow != index) {
                          setState(() {
                            selectedRow = index;
                          });
                        }
                      },
                    ));
              },
              itemCount: channelModel.videoModel?.length ?? 0,
            ),
          )
        ],
      ),
    );
  }

  Container _buildAdsWidget(MGAdModel adModel) {
    if (adShow) {
      return Container(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: new FadeInImage.assetNetwork(
                  placeholder: "assets/images/ylz_blank_rectangle.png",
                  image: "${adModel.img}",
                  fit: BoxFit.cover,
                )),
            Positioned(
                top: 6,
                right: 6,
                child: InkWell(
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: new BoxDecoration(
                        color: Color(MGColorMainViewTwo),
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  ),
                  onTap: () {
                    setState(() {
                      adShow = false;
                    });
                  },
                )),
            Positioned(
              child: Container(
                margin: EdgeInsets.only(left: 16),
                padding: EdgeInsets.fromLTRB(6, 2, 6, 2),
                decoration: new BoxDecoration(
                  border: new Border.all(
                    color: Colors.green,
                    width: 1.0,
                  ),
                  borderRadius: new BorderRadius.all(new Radius.circular(4.0)),
                ),
                child: Text(
                  "广告",
                  style: TextStyle(color: Colors.green, fontSize: 12),
                ),
              ),
              right: 6,
              bottom: 6,
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Container _buildToolsWidget() {
    return Container(
        padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/ylz_home_scan.png',
                  fit: BoxFit.fill,
                ),
                Text(
                  "求片反馈",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(color: Color(YLZColorTitleThree), fontSize: 14),
                )
              ],
            ),
            Column(
              children: [
                Image.asset(
                  'assets/images/ylz_home_scan.png',
                  fit: BoxFit.fill,
                ),
                Text(
                  "收藏",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(color: Color(YLZColorTitleThree), fontSize: 14),
                )
              ],
            ),
            Column(
              children: [
                Image.asset(
                  'assets/images/ylz_home_scan.png',
                  fit: BoxFit.fill,
                ),
                Text(
                  "下载",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(color: Color(YLZColorTitleThree), fontSize: 14),
                )
              ],
            ),
            Column(
              children: [
                Image.asset(
                  'assets/images/ylz_home_scan.png',
                  fit: BoxFit.fill,
                ),
                Text(
                  "分享",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(color: Color(YLZColorTitleThree), fontSize: 14),
                )
              ],
            )
          ],
        ));
  }

  Container _buildTitleWidget(MGVideoDetailModel model) {
    MGFatherVideoPlayerModel channelModel = MGFatherVideoPlayerModel();
    model.totalVideolist.forEach((element) {
      MGFatherVideoPlayerModel eleMent = element as MGFatherVideoPlayerModel;
      if (eleMent.selected) {
        channelModel = eleMent;
      }
    });
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 16, 120, 10),
                child: Text(
                  "${model.name}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/ylz_home_scan.png',
                    fit: BoxFit.fill,
                    width: 16,
                    height: 16,
                  ),
                  Text(
                    "  热度：${model.hits}  评分：${model.score}  ${model.type}  ${model.msg}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Color(YLZColorTitleThree), fontSize: 14),
                  )
                ],
              )
            ],
          ),
          Positioned(
              right: 0,
              top: 12,
              child: GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: new BoxDecoration(
                      color: Color(MGColorMainViewThree),
                      borderRadius: BorderRadius.all(Radius.circular(18.0))),
                  child: Row(
                    children: [
                      Image.asset('assets/images/ylz_home_scan.png',
                          fit: BoxFit.fill, width: 16, height: 16),
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text(
                          "${channelModel.show ?? ""}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Color(YLZColorTitleThree), fontSize: 14),
                        ),
                      ),
                      Image.asset(
                        'assets/images/ylz_arrow_right.png',
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return _buildChannelAlert(model);
                      });
                },
              ))
        ],
      ),
    );
  }

  Container _buildIntroAlert(MGVideoDetailModel model) {
    return Container(
      color: Colors.green,
      height: ScreenH(context) - (ScreenW(context) * 9 / 16),
    );
  }

  Container _buildChannelAlert(MGVideoDetailModel model) {
    return Container(
      color: Color(MGColorMainViewThree),
      height: 44 * 4 + TabbarSafeBottomM(context),
      child: Column(
        children: [
          Container(
              height: 44,
              alignment: Alignment.center,
              child: Text(
                "选择播放渠道",
                style:
                    TextStyle(color: Color(YLZColorTitleThree), fontSize: 16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
          Container(
            height: 44 * 3,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                MGFatherVideoPlayerModel channelModel =
                    model.totalVideolist[index];
                channelModel.selected = index ==
                    context.watch<MGVideoDetailProvider>().selectedChannel;
                return InkWell(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 43,
                        child: Text(
                          "${channelModel.show}",
                          style: TextStyle(
                              color: channelModel.selected
                                  ? Colors.red
                                  : Colors.white,
                              fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(height: 1.0, color: Color(MGColorMainViewTwo))
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      selectedChannel = index;
                      selectedRow = 0;
                    });
                    context
                        .read<MGVideoDetailProvider>()
                        .changeSelectedChannel(index);
                  },
                );
              },
              itemCount: model.totalVideolist.length,
            ),
          )
        ],
      ),
    );
  }

  ///视频详情页appBar
  videoAppBar() {
    return Container(
      margin: EdgeInsets.only(top: StatusH(context)),
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

  MGVideoDetailModel dealRecord(MGVideoDetailModel model) {
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
          "videoId": widget.id,
          "selected": j == selectedRow
        };
        sectionUrlModelList.add(endUrlMap);
      }
      Map<String, dynamic> endUrlMap = {
        "videoModel": sectionUrlModelList,
        "show": playerInfoModel.show,
        "from": playerInfoModel.from,
        "icon": playerInfoModel.icon
      };
      MGFatherVideoPlayerModel channelModel =
          MGFatherVideoPlayerModel.fromJson(endUrlMap);
      channelModel.selected = index == selectedChannel;
      totalVideolist.add(channelModel);
    }
    model.totalVideolist = totalVideolist;
    return model;
  }

  Future _start() async {
    MGVideoDetailModel detailModel = await MGHomeVideoDao.videoInfo(widget.id);
    MGAdModel adModel = await MGHomeVideoDao.videoAds("test");
    return [detailModel, adModel];
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
