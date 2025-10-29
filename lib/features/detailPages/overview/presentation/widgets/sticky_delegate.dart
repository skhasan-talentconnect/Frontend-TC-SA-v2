import 'package:flutter/material.dart';

class StickyDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  StickyDelegate({required this.child});

  @override
  double get minExtent => 50.0;

  @override
  double get maxExtent => 50.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(StickyDelegate oldDelegate) {
    return false;
  }
}
