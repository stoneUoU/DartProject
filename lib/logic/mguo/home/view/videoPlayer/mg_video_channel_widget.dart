import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:FlutterProject/logic/mguo/home/model/mg_father_video_player_model.dart';
import 'package:FlutterProject/logic/mguo/home/model/mg_video_detail_model.dart';
import 'package:FlutterProject/provider/MGVideoDetailProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef void MGVideoChannelWidgetClickListener(int index);

class MGVideoChannelWidget extends StatelessWidget {
  final MGVideoDetailModel model;

  final MGVideoChannelWidgetClickListener channelClickListener;

  const MGVideoChannelWidget(
      {Key? key, required this.model, required this.channelClickListener})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < model.totalVideolist.length; i++) {
      MGFatherVideoPlayerModel channelModel = model.totalVideolist[i];
      channelModel.channelChecked =
          i == context.watch<MGVideoDetailProvider>().selectedChannel;
    }
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
                      Container(height: 1.0, color: Color(MGColorMainViewTwo))
                    ],
                  ),
                  onTap: () {
                    context
                        .read<MGVideoDetailProvider>()
                        .changeSelectedChannel(index);
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
    );
  }
}
