import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:FlutterProject/base/view/YLZPhotoView.dart';
import 'package:FlutterProject/logic/rainBow/model/YLZReportDetailModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

typedef void OnYLZReportDetailPageListener(String idStr);

class YLZReportDetailPage extends StatefulWidget {
  int reportId;
  OnYLZReportDetailPageListener? onReportDetailPageListener;
  //构造函数
  YLZReportDetailPage(
      {Key? key, required this.reportId, this.onReportDetailPageListener})
      : super(key: key);

  @override
  _YLZReportDetailPageState createState() => _YLZReportDetailPageState();
}

class _YLZReportDetailPageState extends State<YLZReportDetailPage> {
  List<String> imageLists = [];
  Dio dio = Dio();
  bool flag = true;
  YLZReportDetailModel renderMs = YLZReportDetailModel();

  EasyRefreshController easyRefreshController = new EasyRefreshController();
  final ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      var position = _scrollController.position;
//			print(position);
    });
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: _getBody());
  }

  _showLoadingDialog() {
    //在此处加载进度条
    if (renderMs.reportId == null) {
      return true;
    }
    return false;
  }

  _getProgressDialog() {
    return SpinKitFadingCircle(
      itemBuilder: (_, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Colors.red : Colors.green,
          ),
        );
      },
    );
  }

  _getBody() {
    if (_showLoadingDialog()) {
      return _getProgressDialog();
    } else {
      return new Column(
        children: <Widget>[
          new Stack(
            children: <Widget>[
              new Container(
                height: ScreenH(context) - 50 - TabbarSafeBottomM(context),
                child: EasyRefresh.custom(
                  controller: easyRefreshController, //上面创建的刷新控制器
                  header: ClassicalHeader(
                      refreshText: "下拉可以  刷新",
                      refreshReadyText: "松开立即刷新",
                      refreshingText: "正在刷新数据中" + "...",
                      refreshedText: "刷新完成",
                      bgColor: Colors.transparent,
                      textColor: Colors.black87,
                      infoColor: Colors
                          .black54), //自定义刷新头（如果想更改背景色等，可以在小括号内设置属性，都有哪些属性，可以点击这个类自行查看）
                  onRefresh: () async {
                    _pullRefresh();
                  },
                  slivers: _buildSlivers(context),
                ),
              ),
              new Positioned(
                left: 0.0,
                right: 0.0,
                top: 0.0,
                child: _makeStatusAndNaviBar(),
              ),
            ],
          ),
          _makeFooterView(),
        ],
      );
    }
  }

  Widget _makeStatusAndNaviBar() {
    return new Container(
        width: ScreenW(context),
        height: StatusH(context) + kToolbarHeight,
        child: new Container(
          margin: EdgeInsets.fromLTRB(15.0, StatusH(context), 15.0, 0),
          width: ScreenW(context) - 30.0,
          height: kToolbarHeight,
          child: new Stack(children: <Widget>[
            new Align(
              alignment: FractionalOffset.centerLeft,
              child: GestureDetector(
                onTap: () {
                  // 按下
                  Navigator.pop(context, "哈哈哈");
                  if (widget.onReportDetailPageListener != null) {
                    widget.onReportDetailPageListener!("AAAAAAA");
                  }
                },
                child: new Container(
                  child: new Image.asset('assets/images/clickBack.png'),
                ),
              ),
            ),
            new Align(
              alignment: FractionalOffset.centerRight,
              child: GestureDetector(
                onTap: () {
                  // 按下
                  print("按下了哈哈哈哈哈");
                },
                child: new Container(
                  child: new Image.asset('assets/images/clickBack.png'),
                ),
              ),
            ),
          ]),
        ));
  }

  List<Widget> _buildSlivers(BuildContext context) {
    return <Widget>[
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, position) {
            if (position == 0) {
              return _makeTopView();
            } else if (position == 1) {
              return _makeCenterView();
            } else {
              return _makeBottomView();
            }
          },
          childCount: 3,
        ),
      ),
    ];
  }

  Widget _makeTopView() {
    return new Container(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: new Column(
        children: <Widget>[
          new Container(
            height: 265,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            width: ScreenW(context), //- 30.0,
            child: new FadeInImage.assetNetwork(
              placeholder: "assets/images/ylz_blank_rectangle.png",
              fadeInDuration: const Duration(seconds: 1), // 持续时间，默认 700 ms
              image: renderMs.cover ?? "",
              fit: BoxFit.cover,
            ),
          ),
          new Container(
            margin: EdgeInsets.fromLTRB(15.0, 12.0, 37.0, 0),
            width: ScreenW(context) - 52.0,
            child: new Text(renderMs.title ?? "",
                style: new TextStyle(fontSize: 16.0, color: Colors.black),
                textAlign: TextAlign.left),
          ),
          _makeSubTitleView(renderMs.subTitle ?? ""),
          new Container(
            margin: EdgeInsets.fromLTRB(15.0, 4.0, 15.0, 0),
            width: ScreenW(context) - 30.0,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new Row(
                    children: <Widget>[
                      new Text("￥${renderMs.salesPrice}/份  ",
                          style:
                              new TextStyle(fontSize: 14.0, color: Colors.red),
                          textAlign: TextAlign.left),
                      new Text(
                        "￥${renderMs.price}",
                        style: new TextStyle(
                          fontSize: 14.0,
                          color: Colors.black54,
                          decorationColor: Colors.black54, //线的颜色
                          decoration: TextDecoration
                              .lineThrough, //none无文字装饰   lineThrough删除线   overline文字上面显示线    underline文字下面显示线
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                  flex: 2,
                ),
                new Expanded(
                  child: new Text("全国包邮",
                      style:
                          new TextStyle(fontSize: 16.0, color: Colors.black54),
                      textAlign: TextAlign.right),
                  flex: 1,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // 按下
              print("按下了哈哈哈哈哈");
            },
            child: new Container(
              margin: EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 15.0),
              width: ScreenW(context) - 30.0,
              height: flag ? 50.0 : 40.0,
              color: Color(YLZColorTitleOne),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Container(
                      margin: EdgeInsets.fromLTRB(6.0, 0, 0, 0),
                      child: Text(
                        flag
                            ? "尊贵的全球设计通会员\n您可以全年免费自选5份报告"
                            : "加入全球设计通，全年免费自选5份报告",
                        style: new TextStyle(
                            fontSize: 12.0, color: Color(YLZColorGoldView)),
                      ),
                    ),
                    flex: 6,
                  ),
                  new Expanded(
                    child: new Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 6.0, 0),
                      child: Text(flag ? "咨询客服 >" : "了解详情 > ",
                          style: new TextStyle(
                              fontSize: 14.0, color: Color(YLZColorGoldView)),
                          textAlign: TextAlign.right),
                    ),
                    flex: 2,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _makeSubTitleView(String subTitleStr) {
    if (subTitleStr == "") {
      return new Container();
    }
    return new Container(
      margin: EdgeInsets.fromLTRB(15.0, 2.0, 39.0, 0),
      width: ScreenW(context) - 54.0,
      child: new Text(subTitleStr,
          style: new TextStyle(fontSize: 14.0, color: Colors.black54),
          textAlign: TextAlign.left),
    );
  }

  Widget _makeCenterView() {
    return new Container(
      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: new Column(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
            width: ScreenW(context) - 30.0,
            child: new Row(
              children: <Widget>[
                new Container(
                    width: 3.0, height: 21, color: Color(YLZColorTitleOne)),
                new Container(
                  margin: EdgeInsets.fromLTRB(4.0, 0, 0, 0),
                  child: new Text("报告亮点",
                      style: new TextStyle(
                          fontSize: 16.0,
                          color: Color(YLZColorTitleOne),
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left),
                ),
              ],
            ),
          ),
          new Container(
            margin: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 15.0),
            width: ScreenW(context) - 30.0,
            child: new Text(renderMs.description ?? "",
                style: new TextStyle(
                    fontSize: 16.0, color: Color(YLZColorTitleTwo)),
                textAlign: TextAlign.left),
          ),
        ],
      ),
    );
  }

  Widget _makeBottomView() {
    return new Container(
      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: new Column(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
            width: ScreenW(context) - 30.0,
            child: new Row(
              children: <Widget>[
                new Container(
                    width: 3.0, height: 21, color: Color(YLZColorTitleOne)),
                new Container(
                  margin: EdgeInsets.fromLTRB(4.0, 0, 0, 0),
                  child: new Text("报告介绍",
                      style: new TextStyle(
                          fontSize: 16.0,
                          color: Color(YLZColorTitleOne),
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left),
                ),
              ],
            ),
          ),
          new Container(
            margin: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 15.0),
            width: ScreenW(context) - 30.0,
            child: Html(
              data: renderMs.content,
              style: {
                "table": Style(
                  backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                ),
                "tr": Style(
                  border: Border(bottom: BorderSide(color: Colors.grey)),
                ),
                "th": Style(
                  padding: EdgeInsets.all(6),
                  backgroundColor: Colors.grey,
                ),
                "td": Style(
                  padding: EdgeInsets.all(6),
                  alignment: Alignment.topLeft,
                ),
                'h5': Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
              },
              onLinkTap: (url, _, __, ___) {
                print("Opening $url...");
              },
              onImageTap: (src, _, __, ___) {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _makePhotoView(List list, int index) {
    return new Container(
        child: YLZPhotoView(
      data: list,
      onPageChanged: onPageChanged,
      buildShowView: (index, itemData) {
        print("${index}");
        return new FadeInImage(
            placeholder: AssetImage("images/1.jpg"),
            image: NetworkImage(list[index]));
      },
      onBannerClickListener: (index, itemData) {
        Navigator.pop(context);
      },
    )
        //Image.network(list[index]),
        );
  }

  void onPageChanged(int index) {
    if (mounted) {
      setState(() {});
    }
  }

  //去掉list中重复的数据:
  List<String> getNewList(List<String> li) {
    List<String> list = [];
    for (int i = 0; i < li.length; i++) {
      String str = li[i];
      if (!list.contains(str)) {
        list.add(str);
      }
    }
    return list; //返回集合
  }

  //数值转换
//	int _caluSwitch (int num) {
//		return (num/2).toInt()-1;
//	}

  Widget _makeFooterView() {
    return new Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: new Container(
              height: 50,
              child: new RaisedButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return _makeShareView();
                      });
                },
                child: new Text(
                  "咨询客服",
                  style: TextStyle(
                      fontSize: 16.0, color: Color(YLZColorTitleThree)),
                ),
                color: Colors.white,
              ),
            ),
          ),
          new Expanded(
            flex: 2,
            child: new Container(
              height: 50,
              child: new RaisedButton(
                onPressed: () {},
                child: new Text(
                  "预订报告",
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
                color: Color(YLZColorGreenView),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _makeShareView() {
    return new Container(
      height: 180,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              new Expanded(
                  child: _makeIconBottomView(Icons.call, 'QQ'), flex: 1),
              new Expanded(
                  child: _makeIconBottomView(Icons.chat, '微信'), flex: 1),
              new Expanded(
                  child: _makeIconBottomView(Icons.add_alarm, '朋友圈'), flex: 1),
              new Expanded(
                  child: _makeIconBottomView(Icons.share, '微博'), flex: 1)
            ],
          ),
          Row(
            children: <Widget>[
              new Expanded(
                  child: _makeIconBottomView(Icons.call, 'QQ'), flex: 1),
              new Expanded(
                  child: _makeIconBottomView(Icons.chat, '微信'), flex: 1),
              new Expanded(
                  child: _makeIconBottomView(Icons.add_alarm, '朋友圈'), flex: 1),
              new Expanded(
                  child: _makeIconBottomView(Icons.share, '微博'), flex: 1)
            ],
          ),
          new Container(
            height: 32,
            width: ScreenW(context),
            color: Colors.transparent,
          )
        ],
      ),
    );
  }

  Container _makeIconBottomView(IconData icon, String lab) {
    Color color = Theme.of(context).primaryColor;
    return new Container(
        height: 72,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Icon(
              icon,
              color: color,
            ),
            new Text(
              lab,
              style: new TextStyle(
                  fontSize: 12.0, fontWeight: FontWeight.w400, color: color),
            )
          ],
        ));
  }

  Future<Null> _loadData() async {
    String url = "/Exhibition/GetReportDetail";
    var data = {"reportId": widget.reportId, "userId": "9"};
    var response = await dio.post("${RainBowUrl}${url}", data: data);
    if (response.data["flag"] == 1) {
      if (mounted) {
        setState(() {
          try {
            this.renderMs =
                new YLZReportDetailModel.fromJson(response.data["rs"]);
          } catch (e) {
            print(e);
          }
        });
      }
    } else {
      print(response);
    }
  }

  _pullRefresh() {
    new Future.delayed(const Duration(seconds: 5), () => _loadData());
  }
}
