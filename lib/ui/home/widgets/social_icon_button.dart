import 'package:flutter/material.dart';
import 'package:portfolio/core/design_system/app_durations.dart';
import 'package:portfolio/core/design_system/app_shadows.dart';
import 'package:portfolio/core/theme/app_colors.dart';

class SocialIconButton extends StatelessWidget {
  const SocialIconButton({
    super.key,
    required this.icon,
    required this.isHighlighted,
    required this.size,
    required this.onTap,
    required this.onEnter,
    required this.onExit,
  });

  final IconData icon;
  final bool isHighlighted;
  final double size;
  final VoidCallback? onTap;
  final VoidCallback? onEnter;
  final VoidCallback? onExit;

  @override
  Widget build(BuildContext context) {
    final background = isHighlighted ? AppColors.accent : Colors.transparent;
    final iconColor = isHighlighted
        ? AppColors.surfaceDark
        : AppColors.textMuted;

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
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: background,
            shape: BoxShape.circle,
            boxShadow: [if (isHighlighted) AppShadows.hoverSmall],
          ),
          child: Icon(icon, size: size * 0.5, color: iconColor),
        ),
      ),
    );
  }
}
