import 'package:flutter/cupertino.dart';

import 'overflow_widget.dart';

/// A [SliverPersistentHeaderDelegate] implementation that adapts its height
/// based on the intrinsic height of its child widget.
///
/// This delegate is used internally by [AdaptiveHeightSliverPersistentHeader]
/// and handles the measurement and adaptation of the header's height.
class AdaptiveHeightDelegate extends SliverPersistentHeaderDelegate {
  /// Creates an adaptive height delegate.
  ///
  /// The [height] and [child] parameters are required.
  /// [needRepaint] controls whether the delegate should rebuild when the parent rebuilds.
  /// [onSizeChange] is a callback that is invoked when the measured size changes.
  AdaptiveHeightDelegate({
    required this.height,
    required this.child,
    this.needRepaint = false,
    this.onSizeChange,
  });

  /// Callback invoked when the height of the child changes.
  final ValueChanged<double>? onSizeChange;

  /// The widget to display as the header.
  final Widget child;

  /// Whether the header should repaint on rebuild.
  final bool needRepaint;

  /// Current height of the header. This is updated dynamically as the
  /// child's layout changes.
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
