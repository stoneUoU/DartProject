import 'package:dart_demo/logic/home/model/YLZModuleModel.dart';
import 'package:flutter/material.dart';

class YLZHomeOrganizationWidget extends StatelessWidget {
  const YLZHomeOrganizationWidget({
    Key? key,
    required this.homeSonPage,
  }) : super(key: key);

  final Childs homeSonPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 44,
      // width: (ScreenW(context) - 54) / 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          new Container(
            width: 45.0,
            height: 45.0,
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22.5),
              child: FadeInImage.assetNetwork(
                placeholder: "assets/images/ylz_blank_circular.jpg",
                image: homeSonPage.item?.imgUrl ?? "",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
              child: Text(
            homeSonPage.item?.content ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black54,
            ),
          ))
        ],
      ),
    );
  }
}
