import 'package:flutter/widgets.dart';
import 'package:persistent_header_adaptive/src/size_reporting_widget.dart';

/// A container widget that allows its child to overflow its bounds while
/// reporting the actual size of its content.
///
/// This widget uses [OverflowBox] to render the child without height constraints
/// and [SizeReportingWidget] to measure the resulting size.
///
/// Used internally by [AdaptiveHeightDelegate] to measure the intrinsic height
/// of header content.
class OverflowContainer extends StatelessWidget {
  /// Creates an overflow container.
  ///
  /// All parameters are required.
  const OverflowContainer({
    super.key,
    required this.onSizeChange,
    required this.child,
    required this.alignment,
  });

  /// Callback invoked when the size of the child changes.
  final ValueChanged<Size> onSizeChange;
  
  /// The widget to display and measure.
  final Widget child;
  
  /// Alignment of the child within the overflow box.
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      minHeight: 0,
      maxHeight: double.infinity,
      alignment: alignment,
      child: SizeReportingWidget(
        onSizeChange: onSizeChange,
        child: child,
      ),
    );
  }
}
