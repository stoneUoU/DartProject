import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:FlutterProject/logic/mguo/home/model/mg_home_model.dart';
import 'package:flutter/material.dart';

typedef void MGHomeMoreColumnHeaderWidgetClickListener(int index);

class MGHomeMoreColumnHeaderWidget extends StatefulWidget {
  final MGHomeModel homeModel;
  final MGHomeMoreColumnHeaderWidgetClickListener clickListener;

  const MGHomeMoreColumnHeaderWidget(
      {Key? key, required this.homeModel, required this.clickListener})
      : super(key: key);

  @override
  _MGHomeMoreColumnHeaderWidgetState createState() =>
      _MGHomeMoreColumnHeaderWidgetState();
}

class _MGHomeMoreColumnHeaderWidgetState
    extends State<MGHomeMoreColumnHeaderWidget> {
  /**
   * index 0  排行榜
   * index 1  高分榜
   * index 2  热度榜
   ***/
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      alignment: Alignment.centerLeft,
      height: 44,
      color: Colors.white,
      child: Row(children: [
        InkWell(
          child: Container(
            child: Text("${widget.homeModel.typeName}排行版",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: index == 0 ? 16 : 14,
                  color: Color(
                      index == 0 ? YLZColorMZTBlueView : YLZColorTitleFive),
                )),
          ),
          onTap: () {
            setState(() {
              index = 0;
            });
            if (widget.clickListener != null) {
              widget.clickListener(index);
            }
          },
        ),
        Container(
          margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
          height: 16,
          width: 0.5,
          color: Color(YLZColorTitleFive),
        ),
        InkWell(
          child: Container(
            margin: EdgeInsets.only(right: 16),
            child: Text("高分版",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: index == 1 ? 16 : 14,
                  color: Color(
                      index == 1 ? YLZColorMZTBlueView : YLZColorTitleFive),
                )),
          ),
          onTap: () {
            setState(() {
              index = 1;
            });
            if (widget.clickListener != null) {
              widget.clickListener(index);
            }
          },
        ),
        InkWell(
          child: Container(
            child: Text("热度版",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: index == 2 ? 16 : 14,
                  color: Color(
                      index == 2 ? YLZColorMZTBlueView : YLZColorTitleFive),
                )),
          ),
          onTap: () {
            setState(() {
              index = 2;
            });
            if (widget.clickListener != null) {
              widget.clickListener(index);
            }
          },
        )
      ]),
    );
  }
}
