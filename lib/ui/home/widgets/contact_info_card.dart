import 'package:flutter/material.dart';
import 'package:portfolio/core/design_system/app_durations.dart';
import 'package:portfolio/core/design_system/app_radii.dart';
import 'package:portfolio/core/design_system/app_shadows.dart';
import 'package:portfolio/core/design_system/app_spacing.dart';
import 'package:portfolio/core/theme/app_colors.dart';

class ContactInfoCard extends StatelessWidget {
  const ContactInfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.isHighlighted,
    required this.onTap,
    required this.onEnter,
    required this.onExit,
  });

  final IconData icon;
  final String label;
  final bool isHighlighted;
  final VoidCallback? onTap;
  final VoidCallback? onEnter;
  final VoidCallback? onExit;

  @override
  Widget build(BuildContext context) {
    final background = isHighlighted ? AppColors.accent : AppColors.surface;
    final textColor = isHighlighted
        ? AppColors.surfaceDark
        : AppColors.textPrimary;
    final iconColor = isHighlighted ? AppColors.surfaceDark : AppColors.accent;

    return MouseRegion(
      cursor: onTap == null
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      onEnter: (_) => onEnter?.call(),
      onExit: (_) => onExit?.call(),
      child: GestureDetector(
        behavior: onTap == null
            ? HitTestBehavior.deferToChild
            : HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: AppDurations.fast,
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(AppRadii.sm),
            boxShadow: [if (isHighlighted) AppShadows.hoverMedium],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: AppSpacing.lg),
              const SizedBox(width: AppSpacing.sm),
              Flexible(
                child: Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
