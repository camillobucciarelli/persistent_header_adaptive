import 'package:flutter/widgets.dart';

import 'adaptive_height_delegate.dart';

class AdaptiveHeightSliverPersistentHeader extends StatefulWidget {
  const AdaptiveHeightSliverPersistentHeader({
    super.key,
    required this.child,
    this.pinned = false,
    this.floating = false,
    this.needRepaint = false,
    this.initialHeight = .0,
  });
  final Widget child;
  final bool pinned;
  final bool floating;
  final double initialHeight;
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
