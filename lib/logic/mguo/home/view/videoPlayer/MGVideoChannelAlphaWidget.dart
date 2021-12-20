import 'package:DartProject/base/config/YLZStyle.dart';
import 'package:DartProject/logic/mguo/home/model/MGVideoDetailModel.dart';
import 'package:DartProject/logic/mguo/home/model/MGVideoPlayerFatherModel.dart';
import 'package:DartProject/provider/MGVideoDetailProvider.dart';
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
                child: InkWell(
                  child: Container(
                    decoration: new BoxDecoration(
                      color: Color(MGColorMainViewThree),
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(4.0)),
                    ),
                    height: 50 * 4,
                    width: 136,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        MGVideoPlayerFatherModel channelModel =
                            model.totalVideolist[index];
                        print("____-${channelModel.icon}");
                        return InkWell(
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 16),
                                  child: _buildImageView(channelModel),
                                  width: 16,
                                  height: 16,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 16),
                                  height: 50,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 49.5,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${channelModel.show}",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: channelModel.channelChecked
                                                  ? Color(0xffA6AFC4)
                                                  : Color(0xff696F82),
                                              fontSize: 14),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.bottomRight,
                                        width: 88,
                                        height: 0.5,
                                        color:
                                            model.totalVideolist.length - 1 ==
                                                    index
                                                ? Color(MGColorMainViewThree)
                                                : Color(0xff696F82),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
                  ),
                  onTap: () {},
                ),
                right: 16,
                top: playerHeight + 52),
            Positioned(
                child: Image.asset(
                  'assets/images/hsa_switch_movie_up.png',
                ),
                right: 24,
                top: playerHeight + 44)
          ])),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _buildImageView(MGVideoPlayerFatherModel model) {
    if (model.icon?.length == 0) {
      return Image.asset(
        'assets/images/ic_logo_place.png',
        fit: BoxFit.fill,
      );
    } else {
      return ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          child: new FadeInImage.assetNetwork(
            placeholder: "assets/images/ic_logo_place.png",
            image: "${model.icon ?? ""}",
            fit: BoxFit.cover,
          ));
    }
  }
}
