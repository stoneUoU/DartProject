import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:FlutterProject/logic/mguo/home/model/MGHomeModel.dart';
import 'package:flutter/material.dart';

class MGHomeSquareCell extends StatelessWidget {
  const MGHomeSquareCell({
    Key? key,
    required this.videoModel,
    required this.cellWidth,
  }) : super(key: key);

  final VideoModel? videoModel;
  final double cellWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Stack(
          children: [
            Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  child: new FadeInImage.assetNetwork(
                    placeholder: "assets/images/ylz_blank_rectangle.png",
                    image: "${videoModel?.img ?? ""}",
                    fit: BoxFit.cover,
                  )),
              width: cellWidth,
              height: 160,
            ),
            Positioned(
                right: 6,
                bottom: 6,
                child: Text(
                  "${videoModel?.score ?? ""}",
                  style: TextStyle(color: Colors.deepOrange, fontSize: 16),
                ))
          ],
        ),
        Container(
          alignment: Alignment.centerLeft,
          width: cellWidth,
          height: 36,
          child: Text(
            "${videoModel?.name ?? ""}",
            style: TextStyle(color: Color(YLZColorTitleOne), fontSize: 14),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    ));
  }
}
