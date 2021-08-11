import 'package:dart_demo/base/config/YLZMacros.dart';
import 'package:flutter/material.dart';

class YLZElecCodeBannerWidget extends StatelessWidget {
  const YLZElecCodeBannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenW(context) - 16,
      height: 204,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
            width: ScreenW(context) - 16,
            child: Image.asset(
              'assets/images/ylz_elec_code_bg.png',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            child: Container(
              margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
              width: ScreenW(context) - 16,
              height: 204,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(34, 26, 0, 0),
                        child: Image.asset(
                          'assets/images/ylz_logo.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(8, 32, 0, 0),
                        child: Text(
                          "医保电子凭证",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(37, 18, 0, 0),
                        child: Text(
                          "姓        名",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(24, 18, 0, 0),
                        child: Text(
                          "iOS开发工程师",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(37, 6, 0, 0),
                        child: Text(
                          "身份证号",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(24, 6, 0, 0),
                        child: Text(
                          "362324199610016010",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    alignment: Alignment.center,
                    child: Text(
                      "国家医疗保障局监制",
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  )
                ],
              ),
            ),
            top: 0,
            left: 0,
          )
        ],
      ),
    );
  }
}
