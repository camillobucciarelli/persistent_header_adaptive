import 'package:flutter/cupertino.dart';

import 'overflow_widget.dart';

class AdaptiveHeightDelegate extends SliverPersistentHeaderDelegate {
  final ValueChanged<double>? onSizeChange;
  final Widget child;
  double height;

  AdaptiveHeightDelegate({
    required this.height,
    required this.child,
    this.onSizeChange,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
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
    return oldDelegate.maxExtent != height;
  }
}
