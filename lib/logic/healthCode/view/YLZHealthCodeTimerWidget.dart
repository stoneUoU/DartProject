import 'dart:async';

import 'package:flutter/material.dart';

class YLZHealthCodeTimerWidget extends StatefulWidget {
  const YLZHealthCodeTimerWidget({Key? key}) : super(key: key);

  @override
  _YLZHealthCodeTimerWidgetState createState() =>
      _YLZHealthCodeTimerWidgetState();
}

class _YLZHealthCodeTimerWidgetState extends State<YLZHealthCodeTimerWidget> {
  String fireTime() {
    DateTime dateTime = DateTime.now();
    return dateTime.toString().substring(0, 19);
  }

  String timeString = "";
  late Timer timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    const timeout = const Duration(seconds: 1);
    this.timer = Timer.periodic(timeout, (timer) {
      if (!mounted) return;
      setState(() {
        this.timeString = "${fireTime()}";
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    this.timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "${this.timeString}".length == 0 ? "${fireTime()}" : "${this.timeString}",
      style: TextStyle(
          color: Colors.blue, fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
