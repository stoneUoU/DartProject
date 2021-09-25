import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:FlutterProject/base/extent/YLZTextFieldExtent.dart';
import 'package:FlutterProject/base/navigator/HiNavigator.dart';
import 'package:FlutterProject/net/db/hi_cache.dart';
import 'package:flutter/material.dart';

typedef void OnCodeLoginPageListener(bool isSuccess);

class YLZCodeLoginPage extends StatefulWidget {
  OnCodeLoginPageListener? onCodeLoginPageListener;

  YLZCodeLoginPage({Key? key, this.onCodeLoginPageListener}) : super(key: key);

  @override
  _YLZCodeLoginPageState createState() => _YLZCodeLoginPageState();
}

class _YLZCodeLoginPageState extends State<YLZCodeLoginPage> {
  //手机号的控制器
  TextEditingController telController = TextEditingController();

  //密码的控制器
  TextEditingController codeController = TextEditingController();

  FocusNode _telFocusNode = FocusNode();

  FocusNode _codeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new SingleChildScrollView(
      child: _getBody(),
    ));
  }

  Widget _getBody() {
    return GestureDetector(
        onTap: () {
          // 按下
          print("按下了哈哈哈哈哈");
          _telFocusNode.unfocus();
          _codeFocusNode.unfocus();
        },
        child: new Column(
          children: <Widget>[
            new Stack(
              children: <Widget>[
                new Container(
                  height: ScreenH(context) - TabbarSafeBottomM(context),
                  width: ScreenW(context),
                  padding: EdgeInsets.fromLTRB(
                      15, StatusH(context) + kToolbarHeight, 0, 0),
                  color: Colors.white,
                  child: new Column(
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Container(
                            margin: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                            child:
                                new Image.asset('assets/images/login_pic.png'),
                          ),
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Container(
                            margin: EdgeInsets.fromLTRB(0, 50.0, 0, 0),
                            child: new Text("欢迎回来",
                                style: new TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                    color: Color(YLZColorTitleOne)),
                                textAlign: TextAlign.left),
                          ),
                        ],
                      ),
                      buildPhoneRow(),
                      new Row(
                        children: <Widget>[
                          new Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              height: 1,
                              width: ScreenW(context) - 30,
                              color: Color(YLZColorLine)),
                        ],
                      ),
                      buildCodeRow(),
                      new Row(
                        children: <Widget>[
                          new Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              height: 1,
                              width: ScreenW(context) - 30,
                              color: Color(YLZColorLine)),
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Container(
                              margin: EdgeInsets.fromLTRB(0, 58.0, 0, 0),
                              height: 45,
                              width: ScreenW(context) - 30,
                              child: new RaisedButton(
                                onPressed: () {
                                  _loginNet("15717914505", "000000");
                                },
                                shape: StadiumBorder(),
                                child: new Text("登录",
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.white)),
                                color: Color(YLZColorLightBlueView),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                new Positioned(
                  left: 0.0,
                  right: 0.0,
                  top: 0.0,
                  child: _makeStatusAndNaviBar(),
                ),
              ],
            )
          ],
        ));
  }

  Row buildCodeRow() {
    return new Row(
      children: <Widget>[
        new Container(
          margin: EdgeInsets.fromLTRB(5, 15.0, 0, 0),
          height: 50,
          width: ScreenW(context) - 120,
          child: new YLZTextFieldExtent(
              focusNode: _codeFocusNode,
              child: TextField(
                autocorrect: false,
                focusNode: _codeFocusNode,
                controller: codeController,
                obscureText: true, //是否是密码
                textAlign: TextAlign.left, //文本对齐方式
                style: TextStyle(fontSize: 16.0, color: Colors.black), //输入文本的样式
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: '登录密码',
                  contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                  hintStyle: TextStyle(fontSize: 16.0, color: Colors.black38),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                ),
                cursorColor: Color(YLZColorBlueView),
              )),
        ),
        GestureDetector(
          onTap: () {
            // 按下
            _telFocusNode.unfocus();
            _codeFocusNode.unfocus();
            print("忘记密码");
          },
          child: new Container(
              margin: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
              child: new Text("忘记密码",
                  style: new TextStyle(
                      fontSize: 16.0, color: Color(YLZColorLightBlueView)),
                  textAlign: TextAlign.right)),
        )
      ],
    );
  }

  Row buildPhoneRow() {
    return new Row(
      children: <Widget>[
        new Container(
          margin: EdgeInsets.fromLTRB(5, 32.0, 0, 0),
          height: 50,
          width: ScreenW(context) - 30,
          child: new YLZTextFieldExtent(
              focusNode: _telFocusNode,
              child: TextField(
                autocorrect: false,
                focusNode: _telFocusNode,
                controller: telController,
                textAlign: TextAlign.left, //文本对齐方式
                style: TextStyle(fontSize: 16.0, color: Colors.black), //输入文本的样式
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                  filled: true,
                  hintText: '手机号',
                  hintStyle: TextStyle(fontSize: 16.0, color: Colors.black38),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                ),
                cursorColor: Color(YLZColorBlueView),
              )),
        ),
      ],
    );
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
                  Navigator.pop(context);
                  if (widget.onCodeLoginPageListener != null) {
                    widget.onCodeLoginPageListener!(false);
                  }
                  ;
                },
                child: new Container(
                  width: 60,
                  color: Colors.white,
                  height: kToolbarHeight,
                  child: Row(
                    children: <Widget>[
                      new Image.asset('assets/images/login_icon_guanbi.png')
                    ],
                  ),
                ),
              ),
            ),
            new Align(
              alignment: FractionalOffset.centerRight,
              child: GestureDetector(
                onTap: () {
                  print("AAAAA");
                  HiNavigator().onJumpTo(RouteStatus.smsLogin);
                },
                child: new Text("短信登录",
                    style: new TextStyle(
                        fontSize: 14.0, color: Color(YLZColorLightBlueView)),
                    textAlign: TextAlign.right),
              ),
            ),
          ]),
        ));
  }

  Future<Null> _loginNet(String telStr, String codeStr) async {
    // if (!YLZValidatedExtent.MobileIsValidated(telStr)) {
    //   return;
    // } else if (!YLZValidatedExtent.LoginCodeIsValidated(codeStr)) {
    //   return;
    // } else {
    //   var data = {
    //     "username": telStr,
    //     "password": "AAAAAAAAA",
    //     "registration_id": ""
    //   };
    // }
    HiCache.getInstance()
        .setString("access_token_12", "19E179E5DC29C05E65B90CDE57A1C7E5");
    Navigator.pop(context);
    if (widget.onCodeLoginPageListener != null) {
      widget.onCodeLoginPageListener!(true);
    }
    ;
  }
}
