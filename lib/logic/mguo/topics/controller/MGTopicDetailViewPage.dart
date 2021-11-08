import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:FlutterProject/logic/mguo/topics/model/MGDetailModel.dart';
import 'package:FlutterProject/net/dao/mguo/mg_topics_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MGTopicDetailViewPage extends StatefulWidget {
  int topicId;

  //构造函数
  MGTopicDetailViewPage({Key? key, required this.topicId}) : super(key: key);

  @override
  _MGTopicDetailViewPageState createState() => _MGTopicDetailViewPageState();
}

class _MGTopicDetailViewPageState extends State<MGTopicDetailViewPage> {
  late Future _futureBuilderFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    if (!mounted) return;
    _futureBuilderFuture = _start();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Scaffold(
        body: FutureBuilder(
            future: _futureBuilderFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                MGDetailModel model = snapshot.data as MGDetailModel;
                return _buildContainerWidget(model);
              } else {
                return Center(child: SpinKitFadingCircle(
                  itemBuilder: (_, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: index.isEven ? Colors.red : Colors.green,
                      ),
                    );
                  },
                ));
              }
            }),
      ),
    );
  }

  Widget _buildContainerWidget(MGDetailModel detailModel) {
    return Column(
      children: [
        Container(
          width: ScreenW(context),
          height: StatusH(context) + kToolbarHeight,
          color: Colors.white,
          child: Column(
            children: [
              Container(width: ScreenW(context), height: StatusH(context)),
              Stack(children: [
                Container(width: ScreenW(context), height: kToolbarHeight),
                Positioned(
                    child: InkWell(
                      child: Container(
                        child: Image.asset("assets/images/topic_back.png"),
                        padding: EdgeInsets.fromLTRB(16, 20, 36, 20),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    left: 0,
                    top: 0)
              ])
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
          alignment: Alignment.topLeft,
          child: Text("${detailModel.title}",
              maxLines: 2,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 18,
                  color: Color(YLZColorTitleOne),
                  fontWeight: FontWeight.w500)),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(16, 12, 16, 16),
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              Container(
                  child: Text(
                " ${detailModel.addTime}  ",
                style: TextStyle(
                  color: Color(YLZColorTitleTwo),
                  fontSize: 14,
                ),
              )),
              Container(
                margin: EdgeInsets.only(left: 12),
                child: Image.asset("assets/images/topic_liurang.png"),
              ),
              Container(
                child: Text(
                  "  ${detailModel.readCount}",
                  style: TextStyle(
                    color: Color(YLZColorTitleTwo),
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 16),
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: buildHtmlContainer(detailModel),
          ),
        )
      ],
    );
  }

  Widget buildHtmlContainer(MGDetailModel detailModel) {
    if (detailModel.content == null) {
      return Container();
    }
    return Html(
      data: detailModel.content
          .toString()
          .replaceAll("<img src=\"", "<img src=\"http:"),
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
        'p': Style(
            fontSize: FontSize.large,
            color: Color(YLZColorTitleOne),
            fontWeight: FontWeight.w500)
      },
      onLinkTap: (url, _, __, ___) {
        print("Opening $url...");
      },
      onImageTap: (src, _, __, ___) {},
    );
  }

  Future _start() async {
    MGDetailModel detailModel = await MGTopicDao.detail(widget.topicId);
    return detailModel;
  }
}
