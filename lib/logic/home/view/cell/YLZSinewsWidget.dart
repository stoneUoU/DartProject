import 'package:dart_demo/base/config/YLZStyle.dart';
import 'package:dart_demo/base/view/YLZSeparatorView.dart';
import 'package:dart_demo/logic/home/model/YLZDynamicModel.dart';
import 'package:flutter/material.dart';

class YLZSinewsWidget extends StatelessWidget {
  int index;
  YLZDynamicModel? dynamicModel;
  YLZSinewsWidget(
    this.index,
    this.dynamicModel, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    YLZDynamicModelList model = dynamicModel!.list![index];
    return Container(
        child: Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Text(
                        model.title ?? "",
                        textAlign: TextAlign.left,
                        maxLines: 2,
                      ),
                      alignment: Alignment.topLeft),
                  Container(
                    child: Row(
                      children: [
                        Text(
                          model.rlsDateStr ?? "",
                          style: TextStyle(color: Color(YLZColorTitleThree)),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text("${model.visitCount}  ",
                                  style: TextStyle(
                                      color: Color(YLZColorTitleThree))),
                              Image.asset(
                                'assets/images/ylz_eye_open.png',
                                width: 12,
                                height: 12,
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          margin: EdgeInsets.only(right: 10),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    margin: EdgeInsets.only(top: 16),
                  )
                ],
              ),
            ),
            Container(
                width: 108,
                height: 72,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                ),
                child: _buildImage(model.picUrl ?? ""))
          ],
        ),
        Positioned(
          child: YLZSeparatorView(
              color: (index == 0 ? Color(YLZColorLine) : Colors.transparent)),
          left: 0,
          right: 0,
          bottom: 0,
        )
      ],
    ));
  }

  Widget _buildImage(String picUrl) {
    if (picUrl.length != 0) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(6.0),
          child: FadeInImage.assetNetwork(
            placeholder: "assets/images/ylz_blank_circular.jpg",
            image: picUrl,
            fit: BoxFit.cover,
          ));
    } else {
      return Container();
    }
  }
}
