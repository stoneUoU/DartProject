import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:FlutterProject/logic/mguo/topics/model/MGListModel.dart';
import 'package:flutter/material.dart';

typedef void MGTopicCellWidgetClickListener(int idStr);

class MGTopicCellWidget extends StatefulWidget {
  final MGListModel listModel;
  final MGTopicCellWidgetClickListener topicCellWidgetClickListener;

  const MGTopicCellWidget(
      {Key? key,
      required this.listModel,
      required this.topicCellWidgetClickListener})
      : super(key: key);

  @override
  _MGTopicCellWidgetState createState() => _MGTopicCellWidgetState();
}

class _MGTopicCellWidgetState extends State<MGTopicCellWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 176,
        color: Colors.white,
        child: InkWell(
          onTap: () {
            if (widget.topicCellWidgetClickListener != null) {
              widget.topicCellWidgetClickListener(widget.listModel.id!);
            }
          },
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(16, 20, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: _buildPicWidget(widget.listModel),
                      width: 95,
                      height: 95,
                      margin: EdgeInsets.only(right: 16),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
                            child: Text("${widget.listModel.title}",
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color(YLZColorTitleOne),
                                    fontWeight: FontWeight.w500)),
                          ),
                          //${widget.listModel.desc}
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                            child: Text(
                                "看完之后大受震撼，冲在这么多国手捧场的情况下，还是愿意给及格分，而且有的东西也的确能让人思考的，以下是几点感想：1.有的人只可共患难，有的人只可共享福，有的人既可以共患难，也可以共享福",
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(YLZColorTitleThree),
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Image.asset("assets/images/topic_clock.png"),
                          ),
                          Container(
                              child: Text(
                            " ${widget.listModel.addTime}",
                            style: TextStyle(
                              color: Color(YLZColorTitleTwo),
                              fontSize: 14,
                            ),
                          ))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      height: 26,
                      decoration: new BoxDecoration(
                        color: Color(0xffF5F7F9),
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(13.0)),
                      ),
                      child: Center(
                        child: Text(
                          "阅读 ${widget.listModel.readCount}",
                          style: TextStyle(
                            color: Color(YLZColorTitleTwo),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      Positioned(
          child: Container(
            width: ScreenW(context),
            height: 1.0,
            color: Color(YLZColorTableSeparatorView),
          ),
          left: 0,
          bottom: 0)
    ]);
  }

  Widget _buildPicWidget(MGListModel model) {
    if (model.imgs!.length == 0) {
      return new Image.asset(
        "assets/images/ylz_blank_rectangle.png",
        fit: BoxFit.fill,
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: new FadeInImage.assetNetwork(
          placeholder: "assets/images/ylz_blank_rectangle.png",
          fadeInDuration: const Duration(seconds: 1), // 持续时间，默认 700 ms
          image: "${model.imgs![0].toString()}",
          fit: BoxFit.cover,
        ),
      );
    }
  }
}
