import 'package:flutter/widgets.dart';

import 'adaptive_height_delegate.dart';

/// A [SliverPersistentHeader] that automatically adapts its height to match
/// its child's intrinsic height.
///
/// Unlike standard [SliverPersistentHeader], this widget doesn't require
/// explicitly specifying minimum and maximum heights. Instead, it measures
/// the height of its child and updates the header's height accordingly.
///
/// This is particularly useful for headers with dynamic content where the
/// exact height isn't known beforehand.
///
/// Example:
/// ```dart
/// AdaptiveHeightSliverPersistentHeader(
///   floating: true,
///   child: MyHeaderWidget(),
/// )
/// ```
class AdaptiveHeightSliverPersistentHeader extends StatefulWidget {
  /// Creates an adaptive height sliver persistent header.
  ///
  /// The [child] parameter is required and represents the widget to be
  /// displayed as the header.
  const AdaptiveHeightSliverPersistentHeader({
    super.key,
    required this.child,
    this.pinned = false,
    this.floating = false,
    this.needRepaint = false,
    this.initialHeight = .0,
  });

  /// The widget to display as the header.
  final Widget child;

  /// Whether the header should remain visible at the start of the viewport.
  ///
  /// If [pinned] is true, the header will stay visible at the top of the
  /// screen even when scrolling further down.
  final bool pinned;

  /// Whether the header should become visible when scrolling up even when not at the top.
  ///
  /// If [floating] is true, the header will appear when the user scrolls up,
  /// even if they're not at the top of the list yet.
  final bool floating;

  /// Initial height to use before the widget's actual height is calculated.
  ///
  /// Providing a reasonable estimate can improve initial rendering performance.
  final double initialHeight;

  /// Whether the header should repaint on rebuild.
  ///
  /// Set to true if the header content changes frequently and needs to be redrawn.
  /// Set to false for better performance when the header content is static.
  final bool needRepaint;

  @override
  State<AdaptiveHeightSliverPersistentHeader> createState() =>
      _InspectionsSliverPersistentHeaderState();
}

class _InspectionsSliverPersistentHeaderState
    extends State<AdaptiveHeightSliverPersistentHeader> {
  late double _height;
  final _headerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _height = widget.initialHeight;
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      key: _headerKey,
      pinned: widget.pinned,
      floating: widget.floating,
      delegate: AdaptiveHeightDelegate(
        height: _height,
        child: widget.child,
        needRepaint: widget.needRepaint,
        onSizeChange: (height) {
          _height = height;
          _headerKey.currentContext?.findRenderObject()?.markNeedsLayout();
        },
      ),
    );
  }
}
