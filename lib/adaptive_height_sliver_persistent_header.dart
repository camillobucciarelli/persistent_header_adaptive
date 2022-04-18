import 'package:flutter/widgets.dart';

import 'adaptive_height_delegate.dart';

class AdaptiveHeightSliverPersistentHeader extends StatefulWidget {
  final Widget child;
  final bool pinned;
  final bool floating;
  final double initialHeight;

  const AdaptiveHeightSliverPersistentHeader({
    Key? key,
    required this.child,
    this.pinned = false,
    this.floating = false,
    this.initialHeight = .0,
  }) : super(key: key);

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
        onSizeChange: (height) {
          _height = height;
          _headerKey.currentContext?.findRenderObject()?.markNeedsLayout();
        },
      ),
    );
  }
}
