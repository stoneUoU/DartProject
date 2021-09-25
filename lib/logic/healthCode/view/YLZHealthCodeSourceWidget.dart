import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:flutter/material.dart';

class YLZHealthCodeSourceWidget extends StatelessWidget {
  const YLZHealthCodeSourceWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenW(context),
      height: 188 + 64,
      child: Column(
        children: [
          Container(
              width: ScreenW(context),
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
              ),
              margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 16, 0, 0),
                    child: Text(
                      "信息说明",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Color(YLZColorTitleOne),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 16, 0, 0),
                    child: Row(
                      children: [
                        Text(
                          ".数据来源：   ",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(YLZColorTitleOne),
                          ),
                        ),
                        Text(
                          "国家政务服务平台和福建省相关部门。",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(YLZColorTitleOne),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 8, 0, 0),
                    child: Row(
                      children: [
                        Text(
                          ".注意事项：   ",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(YLZColorTitleOne),
                          ),
                        ),
                        Text(
                          "使用健康码时不要离开本页面且需本人操作确认。",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(YLZColorTitleOne),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ".使用范围：   ",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(YLZColorTitleOne),
                          ),
                        ),
                        Expanded(
                            child: Text(
                          "依托国家政务服务平台，实现跨省（区、市）数据共享和互通互认。",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(YLZColorTitleOne),
                          ),
                        ))
                      ],
                    ),
                  )
                ],
              ),
              height: 188),
          Expanded(
              child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 12),
                child: Text(
                  "客服电话：12320 0591-62623959 8:00-12:00 14:00-18:00",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: Text(
                  "本应用由福建省数字办 卫健委 医保局主办 福建省经济信息中心承办",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
