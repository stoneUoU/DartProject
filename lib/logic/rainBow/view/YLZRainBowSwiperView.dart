import 'package:dart_demo/base/config/YLZMacros.dart';
import 'package:dart_demo/logic/rainBow/model/YLZRainBowRotationModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class YLZRainBowSwiperView extends StatefulWidget {
  List dataList = [];
  YLZRainBowSwiperView({Key? key, required this.dataList}) : super(key: key);
  @override
  _YLZRainBowSwiperView createState() => _YLZRainBowSwiperView();
}

class _YLZRainBowSwiperView extends State<YLZRainBowSwiperView> {
  Widget build(BuildContext context) {
    return Container(
      width: ScreenW(context),
      height: 175,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          NewBannerList newBannerList = widget.dataList[index];
          return new FadeInImage.assetNetwork(
            placeholder: "assets/images/ylz_blank_rectangle.png",
            fadeInDuration: const Duration(seconds: 1), // 持续时间，默认 700 ms
            image: "${newBannerList.imgUrl.toString()}",
            fit: BoxFit.cover,
          );
        },
        autoplay: true,
        itemCount: widget.dataList.length,
        loop: true,
        pagination: new SwiperPagination(),
      ),
    );
  }
}
