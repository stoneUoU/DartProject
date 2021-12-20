import 'package:DartProject/base/config/YLZStyle.dart';
import 'package:DartProject/logic/mguo/home/model/MGHomeModel.dart';
import 'package:flutter/material.dart';

class MGHomeHeaderWidget extends StatelessWidget {
  final Video video;
  const MGHomeHeaderWidget({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (video.headType == 0) {
      // 图片 + 查看更多
      String pic = "";
      if (video.id == 1) {
        pic = "mg_home_movie_icon.png";
      } else if (video.id == 4) {
        pic = "mg_home_action_icon.png";
      } else {
        pic = "mg_home_zongyi_icon.png";
      }
      return Container(
        alignment: Alignment.centerLeft,
        height: 44,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Container(
                    child: Image.asset(
                  'assets/images/${pic}',
                )),
                Container(
                  margin: EdgeInsets.only(left: 12.0),
                  child: Text(
                    "${video.name}",
                    style:
                        TextStyle(color: Color(YLZColorTitleOne), fontSize: 16),
                  ),
                )
              ]),
              InkWell(
                child: Container(
                  margin: EdgeInsets.only(right: 16),
                  width: 72,
                  height: 28,
                  decoration: new BoxDecoration(
                    color: Color(YLZColorMZTLightBlueView),
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(15.0)),
                  ),
                  child: Center(
                    child: Text(
                      "查看更多",
                      style: TextStyle(
                        color: Color(YLZColorMZTBlueView),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } else if (video.headType == 1) {
      // 查看更多
      return Container(
        alignment: Alignment.centerLeft,
        height: 44,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 12.0),
                child: Text(
                  "${video.name}",
                  style:
                      TextStyle(color: Color(YLZColorTitleOne), fontSize: 16),
                ),
              ),
              InkWell(
                child: Container(
                  margin: EdgeInsets.only(right: 16),
                  width: 72,
                  height: 28,
                  decoration: new BoxDecoration(
                    color: Color(YLZColorMZTLightBlueView),
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(15.0)),
                  ),
                  child: Center(
                    child: Text(
                      "查看更多",
                      style: TextStyle(
                        color: Color(YLZColorMZTBlueView),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
    return Container(
      alignment: Alignment.centerLeft,
      height: 44,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(left: 16),
        child: Text(
          "${video.name}",
          style: TextStyle(color: Color(YLZColorTitleOne), fontSize: 16),
        ),
      ),
    );
  }
}
