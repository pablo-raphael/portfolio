import 'package:flutter/material.dart';
import 'package:portfolio/core/design_system/app_layout.dart';
import 'package:portfolio/core/design_system/app_spacing.dart';
import 'package:portfolio/core/design_system/responsive_builder.dart';

class SectionContainer extends StatelessWidget {
  const SectionContainer({
    super.key,
    required this.child,
    required this.backgroundColor,
    this.verticalPadding = AppSpacing.sectionVertical,
  });

  final Widget child;
  final Color backgroundColor;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      width: double.infinity,
      child: ResponsiveBuilder(
        builder: (context, info) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppLayout.maxContentWidth,
              ),
              child: Padding(
                padding: info.sectionPadding(vertical: verticalPadding),
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }
}
