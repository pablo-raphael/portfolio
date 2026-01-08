import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/core/design_system/app_durations.dart';
import 'package:portfolio/core/design_system/app_radii.dart';
import 'package:portfolio/core/design_system/app_shadows.dart';
import 'package:portfolio/core/design_system/app_spacing.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/models/skills_content.dart';
import 'package:portfolio/core/utils/icon_mapper.dart';

class SkillCard extends StatelessWidget {
  const SkillCard({
    super.key,
    required this.item,
    required this.isHighlighted,
    required this.onTap,
    required this.onEnter,
    required this.onExit,
    this.width = 140,
    this.height = 132,
  });

  final SkillContent item;
  final bool isHighlighted;
  final VoidCallback? onTap;
  final VoidCallback? onEnter;
  final VoidCallback? onExit;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final background = isHighlighted ? AppColors.accent : AppColors.surface;
    final textColor = isHighlighted
        ? AppColors.surfaceDark
        : AppColors.textPrimary;
    final icons = _buildIcons(item);

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
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(AppRadii.sm),
            boxShadow: [
              if (isHighlighted) AppShadows.skillHighlighted,
              if (!isHighlighted) AppShadows.skillDefault,
            ],
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SkillIconRow(icons: icons),
              const SizedBox(height: AppSpacing.md),
              Text(
                item.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<_IconSpec> _buildIcons(SkillContent item) {
  if (item.iconKey == 'html5') {
    return const [
      _IconSpec(
        icon: FontAwesomeIcons.html5,
        color: Color(0xFFE44D26),
        size: AppSpacing.xxl,
      ),
      _IconSpec(
        icon: FontAwesomeIcons.css3Alt,
        color: Color(0xFF1572B6),
        size: AppSpacing.xxl,
      ),
    ];
  }

  return [
    _IconSpec(
      icon: mapSkillIcon(item.iconKey),
      color: mapSkillColor(item.iconKey),
      size: AppSpacing.xxxl,
    ),
  ];
}

class _IconSpec {
  const _IconSpec({
    required this.icon,
    required this.color,
    required this.size,
  });

  final IconData icon;
  final Color color;
  final double size;
}

class _SkillIconRow extends StatelessWidget {
  const _SkillIconRow({required this.icons});

  final List<_IconSpec> icons;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: icons
          .map(
            (visual) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
              child: _SkillIcon(visual: visual),
            ),
          )
          .toList(),
    );
  }
}

class _SkillIcon extends StatelessWidget {
  const _SkillIcon({required this.visual});

  final _IconSpec visual;

  @override
  Widget build(BuildContext context) {
    return Icon(visual.icon, color: visual.color, size: visual.size);
  }
}
