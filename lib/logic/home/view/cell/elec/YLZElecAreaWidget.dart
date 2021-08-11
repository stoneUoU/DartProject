import 'package:dart_demo/base/config/YLZMacros.dart';
import 'package:dart_demo/base/config/YLZStyle.dart';
import 'package:dart_demo/logic/home/model/YLZInsuredLandModel.dart';
import 'package:flutter/material.dart';

class YLZElecAreaWidget extends StatefulWidget {
  const YLZElecAreaWidget({Key? key}) : super(key: key);

  @override
  _YLZElecAreaWidgetState createState() => _YLZElecAreaWidgetState();
}

class _YLZElecAreaWidgetState extends State<YLZElecAreaWidget> {
  final _areaLists = <YLZInsuredLandModel>[
    YLZInsuredLandModel(orgName: "上饶市", orgCode: "336600", insuStas: "0"),
    YLZInsuredLandModel(orgName: "厦门市市本级", orgCode: "669900", insuStas: "0")
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        new Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(20.0), right: Radius.circular(20.0)),
          ),
          height: TabbarSafeBottomM(context) + 320,
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  new Container(
                      height: 54,
                      width: ScreenW(context),
                      alignment: Alignment.center,
                      child: Text(
                        "选择参保账户",
                        style: TextStyle(
                            color: Color(YLZColorTitleOne),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )),
                  Positioned(
                      child: InkWell(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(24, 16, 0, 0),
                          child: Text(
                            "取消",
                            style: TextStyle(
                                color: Color(YLZColorTitleOne), fontSize: 16),
                          ),
                        ),
                        onTap: () {},
                      ),
                      left: 0,
                      top: 0)
                ],
              ),
              new Container(
                  padding: EdgeInsets.fromLTRB(16, 10, 0, 10),
                  width: ScreenW(context),
                  color: Color(YLZColorTableSeparatorView),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "温馨提示：仅支持部分城市、暂未支持的城市不会显示",
                    style: TextStyle(
                        color: Color(YLZColorTitleTwo),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  )),
              Container(
                width: ScreenW(context),
                height: 44 * 4,
                child: ListView.builder(
                    //创建ListView
                    itemCount: _areaLists.length,
                    itemBuilder: (contentx, i) {
                      if (i.isOdd) return Divider(); // 间隔线
                      return _buildRow(_areaLists[i]);
                    }),
              )
            ],
          ),
        ),
        Positioned(
          child: Container(
            alignment: Alignment.center,
            width: ScreenW(context),
            child: Text(
              "没有正确的参保地？点此反馈",
              textAlign: TextAlign.center,
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 12,
                  color: Color(YLZColorLightBlueView)),
            ),
          ),
          left: 0,
          bottom: TabbarSafeBottomM(context),
        )
      ],
    );
  }

  Widget _buildRow(YLZInsuredLandModel model) {
    return Container(
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16),
            child: Text("${model.orgName}"),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.check,
              color: Color(YLZColorLightBlueView),
            ),
          )
        ],
      ),
    );
  }
}
