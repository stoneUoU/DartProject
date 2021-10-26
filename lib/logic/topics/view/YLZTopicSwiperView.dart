import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:FlutterProject/logic/topics/model/YLZTopModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

typedef void YLZTopicSwiperViewClickListener(int index);

class YLZTopicSwiperView extends StatefulWidget {
  List dataList = [];

  final YLZTopicSwiperViewClickListener clickListener;

  YLZTopicSwiperView(
      {Key? key, required this.dataList, required this.clickListener})
      : super(key: key);

  @override
  _YLZTopicSwiperView createState() => _YLZTopicSwiperView();
}

class _YLZTopicSwiperView extends State<YLZTopicSwiperView> {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: ScreenW(context) - 32,
      height: 180,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          YLZTopModel topModel = widget.dataList[index];
          return _buildWidget(topModel);
        },
        onTap: (int index) {
          YLZTopModel topModel = widget.dataList[index];
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

  Widget _buildWidget(YLZTopModel topModel) {
    if ("${topModel.img.toString()}".length == 0) {
      return new Image.asset(
        "assets/images/ylz_blank_rectangle.png",
        fit: BoxFit.fill,
      );
    } else {
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
