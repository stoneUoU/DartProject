import 'package:DartProject/base/config/YLZMacros.dart';
import 'package:DartProject/base/config/YLZStyle.dart';
import 'package:DartProject/logic/mguo/topics/model/MGTopModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

typedef void MGTopicSwiperViewClickListener(int index);

class MGTopicSwiperView extends StatefulWidget {
  List dataList = [];

  final MGTopicSwiperViewClickListener clickListener;

  MGTopicSwiperView(
      {Key? key, required this.dataList, required this.clickListener})
      : super(key: key);

  @override
  _MGTopicSwiperView createState() => _MGTopicSwiperView();
}

class _MGTopicSwiperView extends State<MGTopicSwiperView> {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: ScreenW(context) - 32,
      height: 180,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          MGTopModel topModel = widget.dataList[index];
          return _buildWidget(topModel);
        },
        onTap: (int index) {
          MGTopModel topModel = widget.dataList[index];
          if (widget.clickListener != null) {
            widget.clickListener(topModel.id!);
          }
        },
        autoplay: true,
        itemCount: widget.dataList.length,
        loop: true,
        pagination: new SwiperPagination(
            margin: EdgeInsets.all(10),
            builder: new DotSwiperPaginationBuilder(
                space: 6.0,
                size: 6,
                activeColor: Color(YLZSwiperPaginationActiveColor))),
      ),
    );
  }

  Widget _buildWidget(MGTopModel topModel) {
    if ("${topModel.img.toString()}".length == 0) {
      return new Image.asset(
        "assets/images/ylz_blank_rectangle.png",
        fit: BoxFit.fill,
      );
    } else {
      if (topModel.img.toString().contains("www.xigtv.com/")) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: new FadeInImage.assetNetwork(
            placeholder: "assets/images/ylz_blank_rectangle.png",
            fadeInDuration: const Duration(seconds: 1), // 持续时间，默认 700 ms
            image:
                "${topModel.img.toString().replaceAll("www.xigtv.com/", "")}",
            fit: BoxFit.cover,
          ),
        );
      }
      if (!(topModel.img.toString().contains("https://") ||
          topModel.img.toString().contains("http://"))) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: new FadeInImage.assetNetwork(
            placeholder: "assets/images/ylz_blank_rectangle.png",
            fadeInDuration: const Duration(seconds: 1), // 持续时间，默认 700 ms
            image: "https:${topModel.img.toString()}",
            fit: BoxFit.cover,
          ),
        );
      }
      return ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: new FadeInImage.assetNetwork(
          placeholder: "assets/images/ylz_blank_rectangle.png",
          fadeInDuration: const Duration(seconds: 1), // 持续时间，默认 700 ms
          image: "${topModel.img.toString()}",
          fit: BoxFit.cover,
        ),
      );
    }
  }
}
