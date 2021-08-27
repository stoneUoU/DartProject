import 'package:dart_demo/base/config/YLZStyle.dart';
import 'package:dart_demo/logic/home/model/YLZModuleModel.dart';
import 'package:flutter/material.dart';

class YLZHomeQueryServiceWidget extends StatelessWidget {
  const YLZHomeQueryServiceWidget({
    Key? key,
    required this.cellWidth,
    required this.insureModel,
    required this.payModel,
    required this.consumeModel,
  }) : super(key: key);

  final double cellWidth;
  final Childs insureModel;
  final Childs payModel;
  final Childs consumeModel;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        child: Row(
          children: [
            Stack(children: [
              Container(
                width: (cellWidth - 8) / 2,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(24.0)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(colorC15),
                      Color(colorC16),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 12, 0, 0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${insureModel.item?.content ?? ""}",
                        style: TextStyle(
                            color: Color(colorC14),
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 12, 0, 0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${insureModel.item?.subContent ?? ""}",
                        style: TextStyle(
                            color: Color(colorC14),
                            fontSize: 14,
                            fontWeight: FontWeight.w300),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/images/ylz_blank_circular.jpg",
                  image: insureModel.item?.imgUrl ?? "",
                  fit: BoxFit.cover,
                  width: 42,
                  height: 46,
                ),
                bottom: 6,
                right: 6,
              )
            ]),
            Container(
              margin: EdgeInsets.only(left: 8),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: (cellWidth - 8) / 2,
                        height: 55,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(colorC18),
                              Color(colorC19),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "${payModel.content}",
                            style:
                                TextStyle(color: Color(colorC17), fontSize: 16),
                          ),
                        ),
                      ),
                      Positioned(
                        child: FadeInImage.assetNetwork(
                          placeholder: "assets/images/ylz_blank_circular.jpg",
                          image: payModel.item?.imgUrl ?? "",
                          fit: BoxFit.cover,
                          width: 28,
                          height: 28,
                        ),
                        bottom: 6,
                        right: 6,
                      )
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        width: (cellWidth - 8) / 2,
                        height: 55,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(colorC21),
                              Color(colorC22),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "${consumeModel.content}",
                            style:
                                TextStyle(color: Color(colorC20), fontSize: 16),
                          ),
                        ),
                      ),
                      Positioned(
                        child: FadeInImage.assetNetwork(
                          placeholder: "assets/images/ylz_blank_circular.jpg",
                          image: consumeModel.item?.imgUrl ?? "",
                          fit: BoxFit.cover,
                          width: 28,
                          height: 28,
                        ),
                        bottom: 6,
                        right: 6,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
