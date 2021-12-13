import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:FlutterProject/base/view/YLZNormalView.dart';
import 'package:FlutterProject/logic/mguo/home/Configs/MGFijkplayerSkin.dart';
import 'package:FlutterProject/logic/mguo/home/model/MGAdModel.dart';
import 'package:FlutterProject/logic/mguo/home/model/MGHomeModel.dart';
import 'package:FlutterProject/logic/mguo/home/model/MGVideoDecodeModel.dart';
import 'package:FlutterProject/logic/mguo/home/model/MGVideoDetailModel.dart';
import 'package:FlutterProject/logic/mguo/home/model/MGVideoParseModel.dart';
import 'package:FlutterProject/logic/mguo/home/model/MGVideoPlayerFatherModel.dart';
import 'package:FlutterProject/logic/mguo/home/model/MGVideoPlayerModel.dart';
import 'package:FlutterProject/logic/mguo/home/view/videoPlayer/MGVideoChannelAlphaWidget.dart';
import 'package:FlutterProject/logic/mguo/topics/model/MGAdModels.dart';
import 'package:FlutterProject/net/dao/mguo/mg_video_dao.dart';
import 'package:FlutterProject/net/db/hi_cache.dart';
import 'package:FlutterProject/provider/MGVideoDetailProvider.dart';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rsa_util/rsa_util.dart';

typedef void MGVideoParseModelHandle(MGVideoParseResModel model);

class MGVideoPlayerPage extends StatefulWidget {
  final int videoId;

  const MGVideoPlayerPage({Key? key, required this.videoId}) : super(key: key);

  @override
  _MGVideoPlayerPageState createState() => _MGVideoPlayerPageState();
}

class _MGVideoPlayerPageState extends State<MGVideoPlayerPage> {
  late Future _futureBuilderFuture;
  Dio dio = Dio();
  List<MGVideoPlayerFatherModel> videolists = [];
  final publicKeyString =
      "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC3jrJKw+DB2MO7KRTFdLeaciv+3SDNDSnuc3KtUuIwPuVwrbGnVmgRej6VuRwNA4Qx/CvVaKly1Wijsb/HdP5WXFeAGHzO2JuRrTOYrAlm/H09oAIoQk7KMAEfM9sM5h2jDiZc+GJ7h5f8VBitH1b0RjvTKufhk9AHU/dEyI2YNQIDAQAB\n-----END PUBLIC KEY-----";
  bool adShow = true;

  MGVideoDetailModel videoDetailModel = MGVideoDetailModel();

  //选中的渠道：
  int selectedChannel = 0;

  //选中的集数：
  int selectedRow = 0;
  final FijkPlayer player = FijkPlayer();
  ShowConfigAbs vCfg = PlayerShowConfig();

  Map<String, List<Map<String, dynamic>>> videoList = {
    "video": [
      {
        "name": "天空资源",
        "list": [
          {
            "url": "https://static.smartisanos.cn/common/video/t1-ui.mp4",
            "name": "锤子UI-1",
          },
          {
            "url": "https://static.smartisanos.cn/common/video/video-jgpro.mp4",
            "name": "锤子UI-2",
          },
          {
            "url": "https://v-cdn.zjol.com.cn/280443.mp4",
            "name": "其他",
          },
        ]
      },
      {
        "name": "天空资源",
        "list": [
          {
            "url": "https://n1.szjal.cn/20210428/lsNZ6QAL/index.m3u8",
            "name": "综艺",
          },
          {
            "url": "https://static.smartisanos.cn/common/video/t1-ui.mp4",
            "name": "锤子1",
          },
          {
            "url": "https://static.smartisanos.cn/common/video/video-jgpro.mp4",
            "name": "锤子2",
          }
        ]
      },
    ]
  };

  @override
  void initState() {
    // TODO: implement initState
    _futureBuilderFuture = _start();
  }

  @override
  void dispose() {
    super.dispose();
    player.release();
  }

  @override
  Widget build(BuildContext context) {
    selectedChannel =
        context.watch<MGVideoDetailProvider>().selectedChannel(widget.videoId);
    selectedRow =
        context.watch<MGVideoDetailProvider>().selectedRow(widget.videoId);
    return Scaffold(
        body: FutureBuilder(
            future: _futureBuilderFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List dataList = (snapshot.data as List).cast();
                MGVideoDetailModel model = dataList[0] as MGVideoDetailModel;
                MGAdModels adModels = dataList[1] as MGAdModels;
                MGAdModel adModel = adModels.data ?? MGAdModel();
                return _buildWidget(model, adModel);
              } else {
                return _buildSpinKitFadingCircle();
              }
            }));
  }

  /**
   * 播放视频：
   */
  _fireVideo(MGVideoParseResModel model) async {
    if (player.value.state == FijkState.completed) {
      await player.stop();
    }
    await player.reset().then((_) async {
      player.setOption(FijkOption.formatCategory, "headers",
          "User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, liKe Gecko) Chrome/94.0.4606.81 Safari/537.36\r\nCookie:${model.cookie}");
      player.setDataSource(model.url ?? "", autoPlay: true);
    });
  }

  /**
   * 具体的播放视频的URL
   * */
  _fireVideoModel() {
    MGVideoPlayerFatherModel channelModel = MGVideoPlayerFatherModel();
    this.videoDetailModel.totalVideolist.forEach((element) {
      MGVideoPlayerFatherModel eleMent = element as MGVideoPlayerFatherModel;
      if (eleMent.channelChecked) {
        channelModel = eleMent;
      }
    });
    MGVideoPlayerModel playerModel = MGVideoPlayerModel();
    for (int i = 0; i < (channelModel.videoModel?.length ?? 0); i++) {
      if (i == selectedRow) {
        playerModel = channelModel.videoModel![i];
      }
    }
    _fireVideoParse(channelModel.from ?? "", playerModel.playerUrl ?? "",
        (parseModel) {
      _fireVideo(parseModel);
    });
  }

  FijkView _buildFijkView(
      MGVideoDetailModel model, double width, double height) {
    MGVideoPlayerFatherModel channelModel = MGVideoPlayerFatherModel();
    model.totalVideolist.forEach((element) {
      MGVideoPlayerFatherModel eleMent = element as MGVideoPlayerFatherModel;
      if (eleMent.channelChecked) {
        channelModel = eleMent;
      }
    });
    return FijkView(
      width: width,
      height: height,
      color: Colors.black,
      fit: FijkFit.cover,
      player: player,
      panelBuilder: (
        FijkPlayer player,
        FijkData data,
        BuildContext context,
        Size viewSize,
        Rect texturePos,
      ) {
        /// 使用自定义的布局
        return MGFijkPanel(
          player: player,
          viewSize: viewSize,
          texturePos: texturePos,
          pageContent: context,
          // 标题 当前页面顶部的标题部分
          playerTitle: (model.isMovie ?? false)
              ? (model.name ?? "")
              : ("${model.name ?? ""}(第${selectedRow + 1}集)"),
          // 当前视频改变钩子
          onChangeVideo: onChangeVideo,
          // 当前视频源tabIndexv
          curTabIdx: selectedChannel,
          // 当前视频源activeIndex
          curActiveIdx: selectedRow,
          // 显示的配置
          showConfig: vCfg,
          videoId: widget.videoId,
          // json格式化后的视频数据
          totalVideolist: model.totalVideolist,
          model: model,
          fijkPanelFireListener: () {
            this._fireVideoModel();
          },
        );
      },
    );
  }

  // 钩子函数，用于更新状态
  void onChangeVideo(int curTabIdx, int curActiveIdx) {
    this.setState(() {
      // _curTabIdx = curTabIdx;
      // _curActiveIdx = curActiveIdx;
    });
  }

  Widget _buildWidget(MGVideoDetailModel model, MGAdModel adModel) {
    double aspectRatio = 16 / 9;
    double screenWidth = MediaQuery.of(context).size.width;
    double playerHeight = screenWidth / aspectRatio;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: _buildFijkView(model, screenWidth, playerHeight),
            width: screenWidth,
            height: playerHeight,
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

  /**
   * 猜你喜欢
   * */
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

  /**
   * 播放列表:视频集数
   * */
  Container _buildPlayerListWidget(MGVideoDetailModel model) {
    MGVideoPlayerFatherModel channelModel = MGVideoPlayerFatherModel();
    model.totalVideolist.forEach((element) {
      MGVideoPlayerFatherModel eleMent = element as MGVideoPlayerFatherModel;
      if (eleMent.channelChecked) {
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
              _buildUpdateWidget(model, channelModel),
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
                            color: Color(playerModel.checked!
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
                              color: playerModel.checked!
                                  ? Colors.white
                                  : Color(YLZColorTitleThree),
                              fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      onTap: () {
                        if (selectedRow != index) {
                          setState(() {
                            channelModel.videoModel?.forEach((element) {
                              element.setChecked(false);
                            });
                            MGVideoPlayerModel playerModel =
                                channelModel.videoModel![index];
                            playerModel.setChecked(true);
                            selectedRow = index;
                            context
                                .read<MGVideoDetailProvider>()
                                .changeSelectedRow(widget.videoId, index);
                            _fireVideoModel();
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

  /**
   * 播放列表右侧的更新集数视图：
   * */

  Container _buildUpdateWidget(
      MGVideoDetailModel model, MGVideoPlayerFatherModel channelModel) {
    if (model.isMovie ?? false) {
      return Container();
    }
    return Container(
      child: Row(
        children: [
          InkWell(
            child: Text(
              "更新至${channelModel.videoModel?.length ?? 0}集",
              style: TextStyle(color: Color(YLZColorTitleTwo), fontSize: 14),
            ),
            onTap: () {},
          ),
          Image.asset(
            'assets/images/ylz_arrow_right.png',
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }

  /**
   * 播放页广告
   * */
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

  /**
   * 播放页操作栏：包括求片反馈、收藏、下载、分享
   * */
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

  /**
   * 播放页操作栏：标题栏
   * */
  Container _buildTitleWidget(MGVideoDetailModel model) {
    MGVideoPlayerFatherModel channelModel = MGVideoPlayerFatherModel();
    model.totalVideolist.forEach((element) {
      MGVideoPlayerFatherModel eleMent = element as MGVideoPlayerFatherModel;
      if (eleMent.channelChecked) {
        channelModel = eleMent;
      }
    });
    // print("222___${json.encode(model.totalVideolist)}");
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
                      backgroundColor: Colors.black12,
                      isDismissible: true,
                      enableDrag: false,
                      builder: (BuildContext context) {
                        return _buildChannelAlert(model);
                      });
                },
              ))
        ],
      ),
    );
  }

  /**
   * 播放页操作栏：视频简介
   * */
  Container _buildIntroAlert(MGVideoDetailModel model) {
    return Container(
      color: Colors.green,
      height: ScreenH(context) - (ScreenW(context) * 9 / 16),
    );
  }

  /**
   * 播放页操作栏：播放线路
   * */
  MGVideoChannelAlphaWidget _buildChannelAlert(MGVideoDetailModel model) {
    return MGVideoChannelAlphaWidget(
        videoId: widget.videoId,
        model: model,
        channelClickListener: (int index) {
          Future.delayed(Duration(milliseconds: 500), () {
            setState(() {
              selectedChannel = index;
              selectedRow = 0;
              _fireVideoModel();
            });
          });
        });
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

  /**
   * 网络请求：播放详情数据 + 广告
   * */
  Future _start() async {
    MGVideoDetailModel detailModel =
        await MGHomeVideoDao.videoInfo(widget.videoId);
    MGAdModels adModel = await MGHomeVideoDao.videoAds("ios_video_ad");
    //进行数据处理：
    MGVideoDetailModel modelAfterDeal = _dealRecord(detailModel);
    this.videoDetailModel = modelAfterDeal;
    _fireVideoModel();
    return [modelAfterDeal, adModel];
  }

  /**
   * 播放数据的处理
   * */
  MGVideoDetailModel _dealRecord(MGVideoDetailModel model) {
    List<MGVideoPlayerFatherModel> totalVideolist = [];
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
          "videoId": widget.videoId,
          "checked": j == selectedRow
        };
        sectionUrlModelList.add(endUrlMap);
      }
      Map<String, dynamic> endUrlMap = {
        "videoModel": sectionUrlModelList,
        "show": playerInfoModel.show,
        "from": playerInfoModel.from,
        "icon": playerInfoModel.icon
      };
      MGVideoPlayerFatherModel channelModel =
          MGVideoPlayerFatherModel.fromJson(endUrlMap);
      channelModel.channelChecked = index == selectedChannel;
      totalVideolist.add(channelModel);
    }
    model.totalVideolist = totalVideolist;
    return model;
  }

  /**
   * APP解析数据
   * 1.parseUrl 为空说明不需要解析，直接播放
   * 2.parseUrl 不为空则需要Rsa解密parseUrl，然后进行播放地址解析
   * */
  Future _fireVideoParse(String playerCode, String videoString,
      MGVideoParseModelHandle handle) async {
    MGVideoDecodeModel decodeModel =
        await MGHomeVideoDao.videoDecode(playerCode);
    if (decodeModel.data?.length == 0) {
      print("此视频不需要解析___________${videoString}");
      MGVideoParseResModel model = MGVideoParseResModel();
      model.setUrl(videoString);
      model.setCookie("");
      if (handle != null) {
        handle(model);
      }
    } else {
      String parseUrl = await _loadData(decodeModel.data ?? "");
      _parseUrl(parseUrl, videoString, handle);
    }
  }

  Future<String> _loadData(String message) async {
    RSAUtil rsa = RSAUtil.getInstance(publicKeyString, "");
    var rsaResult = rsa.decryptByPublicKey(message);
    return rsaResult;
  }

  Future _parseUrl(String parseUrl, String videoString,
      MGVideoParseModelHandle handle) async {
    //获取毫秒级时间戳：
    String timeStampString =
        new DateTime.now().millisecondsSinceEpoch.toString();
    HiCache.getInstance().setString("milliseconds", timeStampString);
    String saltString = "043730226d9ada98";
    String secretString = "${saltString}${timeStampString}";
    var data = {
      "url": videoString,
      "tm": HiCache.getInstance().get("milliseconds")
    };
    String ParseUrlString =
        "${parseUrl}".contains("?") ? "${parseUrl}" : "${parseUrl}?";
    MGVideoParseModel parseModel = await MGHomeVideoDao.videoParse(
        "${ParseUrlString}&url=${data["url"]}&tm=${data["tm"]}",
        EncryptUtil.encodeMd5(secretString));
    bool code = parseModel.code == "200" || parseModel.code == "1";
    bool status = parseModel.status == "200";
    MGVideoParseResModel model = MGVideoParseResModel();
    print("此视频需要解析___________${parseModel.url}");
    if (code || status) {
      // __puus=d9bbd0ce4beb17cf0e8ab60fecffd9ebAASFJKosjNAtXxc6knkmwBTqzelqKJlLZ6PsgoKotdxp5DSd6N1jq5UQR+/X5hOobrgmlKOlDag7sfL+LM8SD3/Ck6fpHA46FG3Rj8aVjxI67CPD9hQDnRx6ONVOyUWJ9TkRk2xecHw9MAmnrxAMsknq;
      model.setUrl(parseModel.url ?? "");
      model.setUserAgent("");
      model.setCookie(parseModel.cookies != null
          ? fomatCookieString(parseModel.cookies!)
          : "");
      if (handle != null) {
        handle(model);
      }
    } else {
      Fluttertoast.showToast(msg: "解析失败", gravity: ToastGravity.CENTER);
      model.setUrl(videoString);
      model.setCookie("");
      if (handle != null) {
        handle(model);
      }
    }
  }

  String fomatCookieString(MGVideoCookies cookies) {
    Map map = cookies.toJson();
    String cookieString = "";
    map.forEach((key, value) {
      cookieString = "${key}=${value};";
    });
    return cookieString;
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

// 定制UI配置项
class PlayerShowConfig implements ShowConfigAbs {
  @override
  bool drawerBtn = true;
  @override
  bool nextBtn = true;
  @override
  bool speedBtn = true;
  @override
  bool topBar = true;
  @override
  bool lockBtn = true;
  @override
  bool autoNext = true;
  @override
  bool bottomPro = true;
  @override
  bool stateAuto = true;
  @override
  bool isAutoPlay = false;
}
