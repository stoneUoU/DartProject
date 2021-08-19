import 'dart:developer';

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

  @override
  void initState() {
    // TODO: implement initState
    _futureBuilderFuture = _start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

  // [self.playlistArray removeAllObjects];
  // [self.videoPlayerView.playlistModelArray removeAllObjects];
  // self.playlistArray = [[self.videoPlayerModel.playlist componentsSeparatedByString:@"$$$"] mutableCopy];
  // for (int i = 0; i<self.videoPlayerModel.playerInfo.count; i++) {
  // NSString *sectionUrlStr = self.playlistArray[i];
  // //拆分出来有可能[@"A",""];
  // NSArray *sectionUrlNullArray = [sectionUrlStr componentsSeparatedByString:@"#"];
  // NSMutableArray *sectionUrlArray = [NSMutableArray array];
  // for (int a = 0; a < sectionUrlNullArray.count; a++) {
  // NSString *str = sectionUrlNullArray[a];
  // if (str.length != 0) {
  // [sectionUrlArray addObject:str];
  // }
  // }
  // NSMutableArray *sectionUrlModelArray = [NSMutableArray array];
  // PlayerInfoModel *playerInfoModel = self.videoPlayerModel.playerInfo[i];
  // for (int j = 0; j<sectionUrlArray.count; j++) {
  // NSString *endUrlStr = sectionUrlArray[j];
  // NSArray *endUrlArray = [endUrlStr componentsSeparatedByString:@"$"];
  // //这一步纯粹为了YYModel使用:
  // NSDictionary *endUrlDictonary = @{@"from":playerInfoModel.from,@"videoName":self.videoPlayerModel.name,@"img":self.videoPlayerModel.img,@"sectionName":endUrlArray[0],@"playerUrl":endUrlArray[1],@"isMovie":@(self.videoPlayerModel.isMovie),@"show":playerInfoModel.show,@"videoId":self.id};
  // VideoModel *videoModel = [VideoModel modelWithDictionary:endUrlDictonary];
  // [sectionUrlModelArray addObject:videoModel];
  // }
  // NSDictionary *sectionUrlModelDictonary = @{@"videoModel":sectionUrlModelArray,@"from":playerInfoModel.from,@"show":playerInfoModel.show,@"icon":playerInfoModel.icon};
  // [self.videoPlayerView.playlistModelArray addObject:[VideoFatherModel modelWithDictionary:sectionUrlModelDictonary]];
  // }

  void dealRecord(MGVideoDetailModel model) {
    String exampleString = model.playlist ?? "";
    List<String> stringList = [];
    stringList = exampleString.split("\$\$\$");
    log("stringList_______${stringList}");
  }

  Future _start() async {
    MGVideoDetailModel detailModel = await MGHomeVideoDao.videoInfo(widget.id);
    return detailModel;
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
