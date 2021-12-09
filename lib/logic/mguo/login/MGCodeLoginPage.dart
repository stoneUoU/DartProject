import 'dart:convert';

import 'package:FlutterProject/base/config/YLZMacros.dart';
import 'package:FlutterProject/base/config/YLZStyle.dart';
import 'package:FlutterProject/base/extent/YLZTextFieldExtent.dart';
import 'package:FlutterProject/base/extent/YLZValidatedExtent.dart';
import 'package:FlutterProject/base/navigator/HiNavigator.dart';
import 'package:FlutterProject/net/dao/mguo/mg_login_dao.dart';
import 'package:FlutterProject/net/db/hi_cache.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'model/MGLoginModel.dart';

typedef void OnCodeLoginPageListener(bool isSuccess);

class MGCodeLoginPage extends StatefulWidget {
  OnCodeLoginPageListener? onCodeLoginPageListener;

  MGCodeLoginPage({Key? key, this.onCodeLoginPageListener}) : super(key: key);

  @override
  _MGCodeLoginPageState createState() => _MGCodeLoginPageState();
}

class _MGCodeLoginPageState extends State<MGCodeLoginPage> {
  //手机号的控制器
  TextEditingController telController = TextEditingController();

  //密码的控制器
  TextEditingController codeController = TextEditingController();

  FocusNode _telFocusNode = FocusNode();

  FocusNode _codeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
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
                      16, StatusH(context) + kToolbarHeight, 16, 0),
                  color: Colors.white,
                  child: new Column(
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Container(
                            margin: EdgeInsets.fromLTRB(0, 16.0, 0, 0),
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
                              width: ScreenW(context) - 32,
                              color: Color(YLZColorLine)),
                        ],
                      ),
                      buildCodeRow(),
                      new Row(
                        children: <Widget>[
                          new Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              height: 1,
                              width: ScreenW(context) - 32,
                              color: Color(YLZColorLine)),
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Container(
                              margin: EdgeInsets.fromLTRB(0, 58.0, 0, 0),
                              height: 44,
                              width: ScreenW(context) - 32,
                              child: new RaisedButton(
                                onPressed: () {
                                  String telString = telController.text;
                                  String codeString = codeController.text;
                                  _fireLoginNet(telString, codeString);
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

  Row buildPhoneRow() {
    return new Row(
      children: <Widget>[
        new Container(
          margin: EdgeInsets.fromLTRB(0, 32.0, 0, 0),
          height: 50,
          width: ScreenW(context) - 32,
          child: new YLZTextFieldExtent(
              focusNode: _telFocusNode,
              child: TextField(
                autocorrect: false,
                focusNode: _telFocusNode,
                controller: telController,
                textAlign: TextAlign.left,
                //文本对齐方式
                style: TextStyle(fontSize: 16.0, color: Colors.black),
                //输入文本的样式
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

  Row buildCodeRow() {
    return new Row(
      children: <Widget>[
        new Container(
          margin: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
          height: 50,
          width: ScreenW(context) - 120,
          child: new YLZTextFieldExtent(
              focusNode: _codeFocusNode,
              child: TextField(
                autocorrect: false,
                focusNode: _codeFocusNode,
                controller: codeController,
                obscureText: true,
                //是否是密码
                textAlign: TextAlign.left,
                //文本对齐方式
                style: TextStyle(fontSize: 16.0, color: Colors.black),
                //输入文本的样式
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
            telController.text = "15717914505";
            if (!YLZValidatedExtent.MobileIsValidated(telController.text)) {
              Fluttertoast.showToast(
                  msg: "请输入正确的手机号！", gravity: ToastGravity.CENTER);
              return;
            }
            HiNavigator().onJumpTo(RouteStatus.forgetPwd,
                args: {"telString": telController.text});
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

  Widget _makeStatusAndNaviBar() {
    return new Container(
        width: ScreenW(context),
        height: StatusH(context) + kToolbarHeight,
        child: new Container(
          margin: EdgeInsets.fromLTRB(16.0, StatusH(context), 16.0, 0),
          width: ScreenW(context) - 32.0,
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
                  HiNavigator().onJumpTo(RouteStatus.register, args: {
                    "onCodeLoginPageListener": (bool isSuccess) {
                      Navigator.pop(context);
                      if (widget.onCodeLoginPageListener != null) {
                        widget.onCodeLoginPageListener!(isSuccess);
                      }
                    }
                  });
                },
                child: new Text("注册",
                    style: new TextStyle(
                        fontSize: 16.0, color: Color(YLZColorLightBlueView)),
                    textAlign: TextAlign.right),
              ),
            ),
          ]),
        ));
  }

  Future<Null> _fireLoginNet(String telStr, String codeStr) async {
    if (!YLZValidatedExtent.MobileIsValidated(telStr)) {
      Fluttertoast.showToast(msg: "请输入正确的手机号！", gravity: ToastGravity.CENTER);
      return;
    } else if (!YLZValidatedExtent.LoginCodeIsValidated(codeStr)) {
      Fluttertoast.showToast(msg: "请输入密码！", gravity: ToastGravity.CENTER);
      return;
    } else {
      var result =
          await MGLoginDao.login(telStr, EncryptUtil.encodeMd5(codeStr));
      if (result["code"] != 1) {
        Fluttertoast.showToast(
            msg: result["msg"] ?? "登录失败！", gravity: ToastGravity.CENTER);
        return;
      }
      MGLoginModel model = MGLoginModel.fromJson(result["result"]);
      Fluttertoast.showToast(
          msg: result["msg"] ?? "登录成功！", gravity: ToastGravity.CENTER);
      HiCache.getInstance()
          .setString("personalInfo", json.encode(model.toJson()));
      Navigator.pop(context);
      if (widget.onCodeLoginPageListener != null) {
        widget.onCodeLoginPageListener!(true);
      }
    }
  }
}
