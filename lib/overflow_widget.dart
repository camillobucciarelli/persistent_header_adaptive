import 'package:flutter/widgets.dart';

import 'size_reporting_widget.dart';

class OverflowContainer extends StatelessWidget {
  final ValueChanged<Size> onSizeChange;
  final Widget child;
  final Alignment alignment;

  const OverflowContainer({
    Key? key,
    required this.onSizeChange,
    required this.child,
    required this.alignment,
  }) : super(key: key);

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
