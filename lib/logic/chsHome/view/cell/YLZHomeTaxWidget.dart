import 'package:DartProject/base/config/YLZStyle.dart';
import 'package:flutter/material.dart';

class YLZHomeTaxWidget extends StatelessWidget {
  const YLZHomeTaxWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Color(YLZColorLightGreenView),
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                        child: Image.asset(
                            "assets/images/home_icon_tax_shape.png")),
                    Positioned(
                      child: Text(
                        "个人所得税大病医疗专项附加扣除",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      left: 4,
                      top: 2,
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text("一键查询 轻松获取",
                      style: TextStyle(fontSize: 12, color: Colors.black38)),
                )
              ],
            ),
            Expanded(
                child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
                            width: 72,
                            child: Text(
                              "年度费用 汇总查询",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black54,
                              ),
                            )),
                        new Container(
                          width: 40.0,
                          height: 40.0,
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: ClipRRect(
                            child: FadeInImage.assetNetwork(
                              placeholder:
                                  "assets/images/ylz_blank_circular.jpg",
                              image:
                                  "https://fuwu-test.nhsa.gov.cn/blacoss54822dd8/JSKU1620452830472.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Color(YLZColorLine),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: 72,
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Text(
                              "年度费用明细查询",
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black54,
                              ),
                            )),
                        new Container(
                          width: 40.0,
                          height: 40.0,
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: ClipRRect(
                            child: FadeInImage.assetNetwork(
                              placeholder:
                                  "assets/images/ylz_blank_circular.jpg",
                              image:
                                  "https://fuwu-test.nhsa.gov.cn/blacoss54822dd8/KUOC1620452857104.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ))
          ],
        ));
  }
}
