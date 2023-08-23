import 'package:flutter/cupertino.dart';

import 'overflow_widget.dart';

class AdaptiveHeightDelegate extends SliverPersistentHeaderDelegate {
  AdaptiveHeightDelegate({
    required this.height,
    required this.child,
    this.needRepaint = false,
    this.onSizeChange,
  });
  final ValueChanged<double>? onSizeChange;
  final Widget child;
  final bool needRepaint;
  double height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return OverflowContainer(
      onSizeChange: (value) {
        height = value.height;
        onSizeChange?.call(height);
      },
      alignment: Alignment.topCenter,
      child: child,
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return needRepaint ? needRepaint : oldDelegate.maxExtent != height;
  }
}
