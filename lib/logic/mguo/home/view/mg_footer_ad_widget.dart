import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:FlutterProject/logic/mguo/home/model/mg_home_model.dart';
import 'package:flutter/material.dart';

class MGFooterAdWidget extends StatelessWidget {
  final AdModel adModel;

  const MGFooterAdWidget({Key? key, required this.adModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                height: 32,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: Text(
                        "${adModel.title}",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      padding: EdgeInsets.fromLTRB(6, 2, 6, 2),
                      decoration: new BoxDecoration(
                        border: new Border.all(
                          color: Color(YLZColorRedView),
                          width: 1.0,
                        ),
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(4.0)),
                      ),
                      child: Text(
                        "广告",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Stack(
            children: [
              Container(
                height: 120,
                margin: EdgeInsets.only(top: 10),
                width: ScreenW(context) - 32,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: new FadeInImage.assetNetwork(
                      placeholder: "assets/images/ylz_blank_rectangle.png",
                      image: "${adModel.img}",
                      fit: BoxFit.cover,
                    )),
              ),
              Positioned(
                child: Container(
                  margin: EdgeInsets.only(left: 16),
                  padding: EdgeInsets.fromLTRB(6, 2, 6, 2),
                  decoration: new BoxDecoration(
                    border: new Border.all(
                      color: Color(YLZColorRedView),
                      width: 1.0,
                    ),
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(4.0)),
                  ),
                  child: Text(
                    "广告",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                right: 6,
                bottom: 6,
              )
            ],
          )
        ],
      ),
    );
  }
}
