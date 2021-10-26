import 'package:flutter/material.dart';

class YLZUnFixHeaderDelegate extends SliverPersistentHeaderDelegate {
  YLZUnFixHeaderDelegate(
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  );

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(child: child);
  }

  @override
  bool shouldRebuild(YLZUnFixHeaderDelegate oldDelegate) {
    return false;
  }
}
