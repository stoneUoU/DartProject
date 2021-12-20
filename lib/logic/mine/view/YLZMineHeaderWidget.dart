import 'package:DartProject/base/config/YLZMacros.dart';
import 'package:DartProject/base/config/YLZStyle.dart';
import 'package:flutter/material.dart';

class YLZMineHeaderWidget extends StatelessWidget {
  const YLZMineHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenW(context),
      height: 154,
      child: Stack(
        children: [
          Container(
              width: ScreenW(context),
              height: 126,
              child: Image.asset('assets/images/ylz_mine_bg.png',
                  fit: BoxFit.fill)),
          Positioned(
            child: Container(
              width: 120,
              height: 44,
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: InkWell(
                      child: Image.asset('assets/images/ylz_mine_notice.png',
                          fit: BoxFit.fill),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(3.0)),
                    ),
                    width: 6,
                    height: 6,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 16),
                    child: InkWell(
                      child: Image.asset('assets/images/ylz_mine_scan.png',
                          fit: BoxFit.fill),
                    ),
                  ),
                ],
              ),
            ),
            right: 0,
            top: 0,
          ),
          Positioned(
            child: Card(
              elevation: 15,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                ),
                width: ScreenW(context) - 32,
                height: 94,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Row(
                        children: [
                          Image.asset('assets/images/ylz_mine_male_avater.png',
                              fit: BoxFit.fill),
                          Container(
                            margin: EdgeInsets.only(left: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 6.0),
                                  child: Text(
                                    "157****4505",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Color(YLZColorTitleTwo),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                        'assets/images/ylz_mine_real_sign.png',
                                        fit: BoxFit.fill),
                                    Text(
                                      " 已实人认证",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Color(YLZColorLightBlueView),
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 16),
                      child: Image.asset('assets/images/ylz_arrow_right.png',
                          fit: BoxFit.fill),
                    )
                  ],
                ),
              ),
            ),
            left: 12,
            bottom: 0,
          )
        ],
      ),
    );
  }
}
