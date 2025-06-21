import 'package:flutter/widgets.dart';

/// A widget that reports its size whenever it changes.
///
/// This widget wraps its child in a [SizeChangedLayoutNotifier] and measures the
/// resulting size after layout. When the size changes, it invokes the [onSizeChange]
/// callback.
///
/// Used internally by [OverflowContainer] to track the actual size of the header content.
class SizeReportingWidget extends StatefulWidget {
  /// Creates a size reporting widget.
  ///
  /// Both [child] and [onSizeChange] parameters are required.
  const SizeReportingWidget({
    super.key,
    required this.child,
    required this.onSizeChange,
  });

  /// The widget to display and measure.
  final Widget child;
  
  /// Callback invoked when the measured size of the child changes.
  final ValueChanged<Size> onSizeChange;

  @override
  State<SizeReportingWidget> createState() => _SizeReportingWidgetState();
}

class _SizeReportingWidgetState extends State<SizeReportingWidget> {
  final _widgetKey = GlobalKey();
  Size? _oldSize;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (_) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
        return true;
      },
      child: SizeChangedLayoutNotifier(
        child: Container(
          key: _widgetKey,
          child: widget.child,
        ),
      ),
    );
  }

  void _notifySize() {
    final context = _widgetKey.currentContext;
    if (context != null) {
      final size = context.size;
      if (_oldSize != size) {
        _oldSize = size;
        widget.onSizeChange(size!);
      }
    }
  }
}
