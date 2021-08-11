import 'package:flutter/material.dart';

class YLZHomeHeaderWidget extends StatelessWidget {
  const YLZHomeHeaderWidget(
      {Key? key, required this.titleString, required this.homePageKey})
      : super(key: key);

  final String? titleString;
  final String? homePageKey;

  @override
  Widget build(BuildContext context) {
    bool showMore = (homePageKey ?? "") != "hot_service";
    if (showMore) {
      return Container(
        height: 44,
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titleString ?? "",
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Row(
              children: [
                Text(
                  '查看更多',
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                ),
                Image.asset(
                  'assets/images/ylz_arrow_right.png',
                  width: 12,
                  height: 12,
                )
              ],
            )
          ],
        ),
      );
    } else {
      return Container(
          height: 44,
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          alignment: Alignment.centerLeft,
          child: Text(
            titleString ?? "",
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ));
    }
  }
}
