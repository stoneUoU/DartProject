import 'package:dart_demo/base/config/YLZStyle.dart';
import 'package:dart_demo/logic/area/model/YLZGeneralModel.dart';
import 'package:flutter/material.dart';

class YLZMineListWidget extends StatelessWidget {
  YLZGeneralModel? model;

  YLZMineListWidget({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Image.asset("assets/images/${model!.picUrl ?? ""}.png",
                    fit: BoxFit.fill),
              ),
              Padding(
                padding: EdgeInsets.all(0),
                child: Text(
                  model!.title ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(YLZColorTitleOne),
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
          Image.asset('assets/images/ylz_arrow_right.png', fit: BoxFit.fill),
        ],
      ),
    );
  }
}
