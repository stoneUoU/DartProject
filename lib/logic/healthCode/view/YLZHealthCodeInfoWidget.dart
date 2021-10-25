import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:flutter/material.dart';

typedef void YLZHealthCodeInfoWidgetClickListener(int idStr);

class YLZHealthCodeInfoWidget extends StatefulWidget {
  final YLZHealthCodeInfoWidgetClickListener healthCodeInfoWidgetClickListener;
  const YLZHealthCodeInfoWidget(
      {Key? key, required this.healthCodeInfoWidgetClickListener})
      : super(key: key);

  @override
  _YLZHealthCodeInfoWidgetState createState() =>
      _YLZHealthCodeInfoWidgetState();
}

class _YLZHealthCodeInfoWidgetState extends State<YLZHealthCodeInfoWidget> {
  bool isOn = false;
  int clickNum = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenW(context) - 32,
      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
      height: 136,
      child: Stack(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        child: Image.asset(
                          'assets/images/ylz_mzt_logo_blue.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                        child: Text(
                          "福建八闽健康码",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                        width: 24,
                        height: 24,
                        child: InkWell(
                          child: Image.asset(
                            this.isOn
                                ? 'assets/images/ylz_eye_show.png'
                                : 'assets/images/ylz_eye_hide.png',
                            fit: BoxFit.fill,
                          ),
                          onTap: () {
                            setState(() {
                              this.isOn = !this.isOn;
                            });
                          },
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: Text(
                    this.isOn ? "姓名： 彭于晏" : "姓名： 彭*晏",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: Text(
                    this.isOn
                        ? "身份证号:    362324199509185186"
                        : "身份证号:    362324********5186",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: InkWell(
              child: Container(
                width: 96,
                height: 36,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.all(new Radius.circular(18.0)),
                ),
                child: InkWell(
                  child: Center(
                    child: Text(
                      "改变颜色",
                      style: TextStyle(
                          color: Color(YLZColorMZTBlueView), fontSize: 16),
                    ),
                  ),
                  onTap: () {
                    this.clickNum = this.clickNum + 1;
                    if (this.clickNum > 2) {
                      this.clickNum = 0;
                    }
                    if (widget.healthCodeInfoWidgetClickListener != null) {
                      widget.healthCodeInfoWidgetClickListener(this.clickNum);
                    }
                  },
                ),
              ),
            ),
            top: 50,
            right: 16,
          )
        ],
      ),
    );
  }
}
