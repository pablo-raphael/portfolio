import 'package:flutter/material.dart';
import 'package:portfolio/core/design_system/app_breakpoints.dart';
import 'package:portfolio/core/design_system/app_spacing.dart';

class AppLayout {
  static const double _compactVerticalFactor = 0.6;
  static const double _tabletVerticalFactor = 0.8;

  static const double maxContentWidth = AppBreakpoints.maxContentWidth;
  static const double navCollapseMaxWidth = AppBreakpoints.navCollapseMax;

  static bool isMobile(double width) => width < AppBreakpoints.mobileMax;

  static bool isTablet(double width) {
    return width >= AppBreakpoints.mobileMax &&
        width < AppBreakpoints.tabletMax;
  }

  static bool isNarrow(double width) => width < AppBreakpoints.tabletMax;

  static bool showDecorations(double width) =>
      width >= AppBreakpoints.tabletMax;

  static EdgeInsets sectionPadding(double width, {double? vertical}) {
    final verticalPadding = vertical ?? AppSpacing.sectionVertical;
    final horizontal = horizontalPadding(width);
    final adjustedVertical = width < AppBreakpoints.mobileMax
        ? verticalPadding * _compactVerticalFactor
        : width < AppBreakpoints.tabletMax
        ? verticalPadding * _tabletVerticalFactor
        : verticalPadding;
    return EdgeInsets.symmetric(
      horizontal: horizontal,
      vertical: adjustedVertical,
    );
  }

  static double horizontalPadding(double width) {
    return width < AppBreakpoints.mobileMax
        ? AppSpacing.horizontalMobile
        : width < AppBreakpoints.tabletMax
        ? AppSpacing.horizontalTablet
        : AppSpacing.horizontalDesktop;
  }
}
