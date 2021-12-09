import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:FlutterProject/logic/mguo/home/model/MGVideoDetailModel.dart';
import 'package:FlutterProject/logic/mguo/home/model/MGVideoPlayerFatherModel.dart';
import 'package:FlutterProject/provider/MGVideoDetailProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef void MGVideoChannelAlphaWidgetClickListener(int index);

class MGVideoChannelAlphaWidget extends StatelessWidget {
  final int videoId;
  final MGVideoDetailModel model;
  final MGVideoChannelAlphaWidgetClickListener channelClickListener;

  const MGVideoChannelAlphaWidget(
      {Key? key,
      required this.videoId,
      required this.model,
      required this.channelClickListener})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < model.totalVideolist.length; i++) {
      MGVideoPlayerFatherModel channelModel = model.totalVideolist[i];
      channelModel.channelChecked = i ==
          context.watch<MGVideoDetailProvider>().selectedChannel(this.videoId);
    }
    double aspectRatio = 16 / 9;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double playerHeight = screenWidth / aspectRatio;
    return InkWell(
      child: Container(
          width: screenWidth,
          height: screenHeight,
          child: Stack(children: [
            Container(
              width: screenWidth,
              height: playerHeight,
            ),
            Positioned(
                child: Container(
                  decoration: new BoxDecoration(
                    color: Color(MGColorMainViewThree),
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(4.0)),
                  ),
                  height: 44 * 4 + TabbarSafeBottomM(context),
                  width: 120,
                  child: Column(
                    children: [
                      Container(
                          height: 44,
                          alignment: Alignment.center,
                          child: Text(
                            "选择播放渠道",
                            style: TextStyle(
                                color: Color(YLZColorTitleThree), fontSize: 16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )),
                      Container(
                        height: 44 * 3,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            MGVideoPlayerFatherModel channelModel =
                                model.totalVideolist[index];
                            return InkWell(
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 43,
                                    child: Text(
                                      "${channelModel.show}",
                                      style: TextStyle(
                                          color: channelModel.channelChecked
                                              ? Colors.red
                                              : Colors.white,
                                          fontSize: 14),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                      height: 1.0,
                                      color: Color(MGColorMainViewTwo))
                                ],
                              ),
                              onTap: () {
                                if (channelModel.channelChecked) {
                                  return;
                                }
                                context
                                    .read<MGVideoDetailProvider>()
                                    .changeSelectedChannel(this.videoId, index);
                                context
                                    .read<MGVideoDetailProvider>()
                                    .changeSelectedRow(this.videoId, 0);
                                if (this.channelClickListener != null) {
                                  this.channelClickListener(index);
                                }
                              },
                            );
                          },
                          itemCount: model.totalVideolist.length,
                        ),
                      )
                    ],
                  ),
                ),
                right: 16,
                top: playerHeight + 44)
          ])),
      onTap: () {
        print("关闭");
      },
    );
  }
}
