import 'package:dart_demo/base/config/YLZMacros.dart';
import 'package:dart_demo/logic/rainBow/model/YLZReportCarouselModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class YLZHomeBannerView extends StatefulWidget {
  List<YLZCarouselChildModel> carouselChildMs;
  YLZHomeBannerView({Key? key, required this.carouselChildMs})
      : super(key: key);
  @override
  _YLZHomeBannerView createState() => _YLZHomeBannerView();
}

class _YLZHomeBannerView extends State<YLZHomeBannerView> {
  Widget build(BuildContext context) {
    return Container(
      width: ScreenW(context),
      height: 160,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new FadeInImage.assetNetwork(
            placeholder: "assets/images/ylz_blank_rectangle.png",
            fadeInDuration: const Duration(seconds: 1),
            // 持续时间，默认 700 ms
            image: "${widget.carouselChildMs[index].imagePath.toString()}",
            fit: BoxFit.cover,
          );
        },
        duration: 5,
        autoplay: true,
        itemCount: widget.carouselChildMs.length == 0
            ? 0
            : widget.carouselChildMs.length,
        loop: true,
        pagination: new SwiperPagination(alignment: Alignment.bottomRight),
      ),
    );
  }
}
