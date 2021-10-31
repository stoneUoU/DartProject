import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

typedef void YLZElecCodeCarouselWidgetClickListener(int idStr);

class YLZElecCodeCarouselWidget extends StatelessWidget {
  final YLZElecCodeCarouselWidgetClickListener
      elecCodeCarouselWidgetClickListener;
  const YLZElecCodeCarouselWidget(
      {Key? key, required this.elecCodeCarouselWidgetClickListener})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          //阴影效果
          BoxShadow(
            offset: Offset(0, 0), //阴影在X轴和Y轴上的偏移
            color: Color(YLZColorBackGround), //阴影颜色
            blurRadius: 3.0, //阴影程度
            spreadRadius: 5, //阴影扩散的程度 取值可以正数,也可以是负数
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: EdgeInsets.fromLTRB(16, 5, 16, 16),
      width: ScreenW(context) - 32,
      height: 88,
      child: Card(
        elevation: 15.0,
        shadowColor: Colors.black38,
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          height: 72,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return new FadeInImage.assetNetwork(
                    placeholder: "assets/images/ylz_blank_rectangle.png",
                    fadeInDuration:
                        const Duration(seconds: 1), // 持续时间，默认 700 ms
                    image:
                        "https://fuwu-test.nhsa.gov.cn/blacoss54822dd8/OCEI1626774546343.png",
                    fit: BoxFit.cover,
                  );
                },
                autoplay: true,
                itemCount: 3,
                loop: true,
                pagination: new SwiperPagination(),
              )),
        ),
      ),
    );
  }
}
