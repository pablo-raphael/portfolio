import 'package:flutter/material.dart';
import 'package:portfolio/core/design_system/app_durations.dart';
import 'package:portfolio/core/design_system/app_opacity.dart';
import 'package:portfolio/core/design_system/app_radii.dart';
import 'package:portfolio/core/design_system/app_shadows.dart';
import 'package:portfolio/core/design_system/app_spacing.dart';
import 'package:portfolio/core/theme/app_colors.dart';

class TestimonialCarouselControls extends StatelessWidget {
  const TestimonialCarouselControls({
    super.key,
    required this.itemCount,
    required this.currentIndex,
    required this.onDotTap,
    required this.onPrevious,
    required this.onNext,
  });

  final int itemCount;
  final int currentIndex;
  final ValueChanged<int>? onDotTap;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _CarouselButton(
          icon: Icons.arrow_back_ios_new_rounded,
          onPressed: onPrevious,
        ),
        const SizedBox(width: AppSpacing.md),
        _CarouselDots(
          count: itemCount,
          currentIndex: currentIndex,
          onTap: onDotTap,
        ),
        const SizedBox(width: AppSpacing.md),
        _CarouselButton(
          icon: Icons.arrow_forward_ios_rounded,
          onPressed: onNext,
        ),
      ],
    );
  }
}

class _CarouselDots extends StatelessWidget {
  const _CarouselDots({
    required this.count,
    required this.currentIndex,
    required this.onTap,
  });

  final int count;
  final int currentIndex;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap == null ? null : () => onTap!(index),
          child: AnimatedContainer(
            duration: AppDurations.fast,
            curve: Curves.easeOut,
            width: isActive ? AppSpacing.lg : AppSpacing.sm,
            height: AppSpacing.sm,
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.accent
                  : AppColors.textMuted.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(AppRadii.pill),
            ),
          ),
        );
      }),
    );
  }
}

class _CarouselButton extends StatelessWidget {
  const _CarouselButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    final background = enabled
        ? AppColors.surface
        : AppColors.surface.withValues(alpha: 0.7);
    final iconColor = enabled
        ? AppColors.textPrimary
        : AppColors.textMuted.withValues(alpha: AppOpacity.alpha60);

    return InkWell(
      onTap: onPressed,
      customBorder: const CircleBorder(),
      child: Container(
        width: AppSpacing.huge,
        height: AppSpacing.huge,
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.divider.withValues(
              alpha: enabled ? AppOpacity.alpha50 : 0.3,
            ),
          ),
          boxShadow: [if (enabled) AppShadows.hoverSmall],
        ),
        child: Icon(icon, size: AppSpacing.lg, color: iconColor),
      ),
    );
  }
}
