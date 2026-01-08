import 'package:flutter/material.dart';
import 'package:portfolio/core/design_system/app_opacity.dart';
import 'package:portfolio/core/design_system/app_spacing.dart';

class AppShadows {
  static final BoxShadow hoverSmall = BoxShadow(
    color: Colors.black.withValues(alpha: AppOpacity.alpha18),
    blurRadius: AppSpacing.sm,
    offset: const Offset(0, AppSpacing.xs),
  );

  static final BoxShadow hoverMedium = BoxShadow(
    color: Colors.black.withValues(alpha: AppOpacity.alpha18),
    blurRadius: AppSpacing.sm,
    offset: const Offset(0, AppSpacing.xs),
  );

  static final BoxShadow card = BoxShadow(
    color: Colors.black.withValues(alpha: AppOpacity.alpha25),
    blurRadius: AppSpacing.lg,
    offset: const Offset(0, AppSpacing.sm),
  );

  static final BoxShadow cardStrong = BoxShadow(
    color: Colors.black.withValues(alpha: AppOpacity.alpha35),
    blurRadius: AppSpacing.lg,
    offset: const Offset(0, AppSpacing.sm),
  );

  static final BoxShadow skillDefault = BoxShadow(
    color: Colors.black.withValues(alpha: AppOpacity.alpha25),
    blurRadius: AppSpacing.sm,
    offset: const Offset(0, AppSpacing.xs),
  );

  static final BoxShadow skillHighlighted = BoxShadow(
    color: Colors.black.withValues(alpha: AppOpacity.alpha35),
    blurRadius: AppSpacing.md,
    offset: const Offset(0, AppSpacing.xs),
  );
}
