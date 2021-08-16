import 'package:dart_demo/base/config/YLZMacros.dart';
import 'package:dart_demo/base/config/YLZStyle.dart';
import 'package:flutter/material.dart';

class MGHomeNavigatorWidget extends StatefulWidget {
  const MGHomeNavigatorWidget({Key? key}) : super(key: key);

  @override
  _MGHomeNavigatorWidgetState createState() => _MGHomeNavigatorWidgetState();
}

class _MGHomeNavigatorWidgetState extends State<MGHomeNavigatorWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(MGColorMainView),
      width: ScreenW(context),
      height: StatusH(context) + NaviH,
      child: Column(
        children: [
          Container(width: ScreenW(context), height: StatusH(context)),
          Container(
              width: ScreenW(context),
              height: NaviH,
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
                          width: ScreenW(context) - (44 + 80),
                          height: 32,
                          alignment: Alignment.center,
                          child: Text(
                            "Mac Pro",
                            style: TextStyle(color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              border: new Border.all(
                                color: Color(MGColorLightBlueView),
                                width: 1.0,
                              ))),
                      Positioned(
                          child: Container(
                            width: 22,
                            height: 22,
                            child: Image.asset(
                              'assets/images/mg_search.png',
                            ),
                          ),
                          right: 6,
                          top: 5)
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
                    width: 44 + 48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          margin: EdgeInsets.only(right: 16),
                          child: Image.asset(
                            'assets/images/mg_watch_history.png',
                          ),
                        ),
                        Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11.0),
                              color: Colors.greenAccent,
                            ))
                      ],
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
