import 'package:dart_demo/base/config/YLZStyle.dart';
import 'package:flutter/material.dart';

class YLZLoginButton extends StatelessWidget {
  final String title;
  final bool enable;
  final VoidCallback onPressed;

  const YLZLoginButton(this.title,
      {Key? key, this.enable = true, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        height: 45,
        onPressed: enable ? onPressed : null,
        disabledColor: Color(YLZColorDisabled),
        color: Color(YLZColorLightBlueView),
        child: Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
}
