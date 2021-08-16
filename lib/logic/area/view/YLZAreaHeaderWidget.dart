import 'package:dart_demo/base/config/YLZMacros.dart';
import 'package:dart_demo/base/config/YLZStyle.dart';
import 'package:flutter/material.dart';

typedef void YLZAreaHeaderWidgetClickListener();

class YLZAreaHeaderWidget extends StatelessWidget {
  final YLZAreaHeaderWidgetClickListener clickListener;

  const YLZAreaHeaderWidget({Key? key, required this.clickListener})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: StatusH(context) + NaviH,
      width: ScreenW(context),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: StatusH(context),
          ),
          Container(
            height: NaviH,
            child: Row(
              children: [
                Container(
                  width: ScreenW(context) / 3,
                  padding: EdgeInsets.only(left: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/ylz_area_location.png',
                          fit: BoxFit.fill),
                      Text(
                        " 福建省 ",
                        style: TextStyle(
                            color: Color(YLZColorTitleOne), fontSize: 16),
                      ),
                      Image.asset('assets/images/ylz_area_arrow.png',
                          fit: BoxFit.fill)
                    ],
                  ),
                ),
                Container(
                  width: ScreenW(context) / 3,
                  child: Text(
                    "地方专区",
                    style: TextStyle(
                        color: Color(YLZColorTitleOne),
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  alignment: Alignment.center,
                ),
                Container(
                  width: ScreenW(context) / 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        child: Padding(
                          child: Image.asset(
                              'assets/images/ylz_area_notice.png',
                              fit: BoxFit.fill),
                          padding: EdgeInsets.all(0),
                        ),
                        onTap: () {
                          if (this.clickListener != Null) {
                            this.clickListener();
                          }
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(3.0)),
                        ),
                        width: 6,
                        height: 6,
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
