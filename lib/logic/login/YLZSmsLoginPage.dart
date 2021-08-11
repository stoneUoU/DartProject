import 'dart:async';

import 'package:dart_demo/base/config/YLZMacros.dart';
import 'package:dart_demo/base/config/YLZStyle.dart';
import 'package:dart_demo/base/extent/YLZTextFieldExtent.dart';
import 'package:dart_demo/base/extent/YLZValidatedExtent.dart';
import 'package:flutter/material.dart';

class YLZSmsLoginPage extends StatefulWidget {
  /// 倒计时的秒数，默认60秒。
  final int countdown = 60;

  YLZSmsLoginPage({Key? key}) : super(key: key);

  @override
  _YLZSmsLoginPageState createState() => _YLZSmsLoginPageState();
}

class _YLZSmsLoginPageState extends State<YLZSmsLoginPage> {
  /// 倒计时的计时器。
  late Timer _timer;

  /// 当前倒计时的秒数。
  late int _seconds;

  /// 当前墨水瓶（`InkWell`）的文本。
  String _verifyStr = '获取验证码';

  //手机号的控制器
  TextEditingController telController = TextEditingController();

  //密码的控制器
  TextEditingController smsController = TextEditingController();

  FocusNode _telFocusNode = FocusNode();

  FocusNode _smsFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _seconds = widget.countdown;
  }

  /// 启动倒计时的计时器。
  void _startTimer() {
    // 计时器（`Timer`）组件的定期（`periodic`）构造函数，创建一个新的重复计时器。
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _cancelTimer();
        _seconds = widget.countdown;
        if (!mounted) {
          return;
        }
        setState(() {});
        return;
      }
      _seconds--;
      _verifyStr = '已发送$_seconds' + 's';
      if (!mounted) {
        return;
      }
      setState(() {});
      if (_seconds == 0) {
        _verifyStr = '重新发送';
      }
    });
  }

  /// 取消倒计时的计时器。
  void _cancelTimer() {
    // 计时器（`Timer`）组件的取消（`cancel`）方法，取消计时器。
    _timer.cancel();
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
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // 按下
          print("按下了哈哈哈哈哈");
          _telFocusNode.unfocus();
          _smsFocusNode.unfocus();
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
                      buildSmsRow(),
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
                                  _loginNet("15717914505", "843679");
                                },
                                shape: StadiumBorder(),
                                child: new Text("登录",
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.white)),
                                color: Color(YLZColorBlueView),
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

  Row buildSmsRow() {
    return new Row(
      children: <Widget>[
        new Container(
          margin: EdgeInsets.fromLTRB(5, 15.0, 0, 0),
          height: 50,
          width: ScreenW(context) - 30,
          child: new YLZTextFieldExtent(
              focusNode: _smsFocusNode,
              child: TextField(
                autocorrect: false,
                focusNode: _smsFocusNode,
                controller: smsController,
                obscureText: true, //是否是密码
                textAlign: TextAlign.left, //文本对齐方式
                style: TextStyle(fontSize: 16.0, color: Colors.black), //输入文本的样式
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: '请输入验证码',
                  contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                  hintStyle: TextStyle(fontSize: 16.0, color: Colors.black38),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                ),
                cursorColor: Color(YLZColorBlueView),
              )),
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
          width: ScreenW(context) - 140,
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
        GestureDetector(
          onTap: (_seconds == widget.countdown)
              ? () {
                  _telFocusNode.unfocus();
                  _smsFocusNode.unfocus();
                  _smsNet("15717914505");
                }
              : null,
          child: new Container(
              width: 105,
              margin: EdgeInsets.fromLTRB(0, 32.0, 0, 0),
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: new Text(_verifyStr,
                  style: new TextStyle(
                      fontSize: 16.0, color: Color(YLZColorBlueView)),
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
          margin: EdgeInsets.fromLTRB(15.0, StatusH(context), 15.0, 0),
          width: ScreenW(context) - 30.0,
          height: kToolbarHeight,
          child: new Stack(children: <Widget>[
            new Align(
              alignment: FractionalOffset.centerLeft,
              child: GestureDetector(
                onTap: () {
                  // 按下
                  Navigator.pop(context, 1);
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
                  // 按下
                  Navigator.pop(context, 0);
                },
                child: new Text("密码登录",
                    style: new TextStyle(
                        fontSize: 14.0, color: Color(YLZColorBlueView)),
                    textAlign: TextAlign.right),
              ),
            ),
          ]),
        ));
  }

  // 这个接口api有问题
  Future<Null> _smsNet(String telStr) async {
    if (!YLZValidatedExtent.MobileIsValidated(telStr)) {
      return;
    } else {
      _startTimer();
      _verifyStr = '已发送$_seconds' + 's';
      if (!mounted) {
        return;
      }
      setState(() {});
    }
  }

  Future<Null> _loginNet(String telStr, String smsStr) async {}
}
