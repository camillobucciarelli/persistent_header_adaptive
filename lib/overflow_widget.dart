import 'package:flutter/widgets.dart';

import 'size_reporting_widget.dart';

class OverflowContainer extends StatelessWidget {
  const OverflowContainer({
    super.key,
    required this.onSizeChange,
    required this.child,
    required this.alignment,
  });
  final ValueChanged<Size> onSizeChange;
  final Widget child;
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
