import 'package:flutter/material.dart';
import 'package:portfolio/core/design_system/app_layout.dart';

class ResponsiveInfo {
  const ResponsiveInfo(this.width);

  final double width;

  bool get isMobile => AppLayout.isMobile(width);

  bool get isTablet => AppLayout.isTablet(width);

  bool get isNarrow => AppLayout.isNarrow(width);

  bool get showDecorations => AppLayout.showDecorations(width);

  EdgeInsets sectionPadding({double? vertical}) {
    return AppLayout.sectionPadding(width, vertical: vertical);
  }

  double horizontalPadding() => AppLayout.horizontalPadding(width);
}

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({super.key, required this.builder});

  final Widget Function(BuildContext context, ResponsiveInfo info) builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return builder(context, ResponsiveInfo(constraints.maxWidth));
      },
    );
  }
}
