import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:portfolio/core/design_system/app_layout.dart';
import 'package:portfolio/core/design_system/app_spacing.dart';
import 'package:portfolio/core/design_system/app_typography.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/models/header_content.dart';
import 'package:portfolio/ui/home/widgets/toggle_switch.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({
    super.key,
    required this.themeMode,
    required this.onToggleTheme,
    required this.isEnglish,
    required this.onToggleLanguage,
    required this.anchors,
    required this.onAnchorTap,
  });

  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;
  final bool isEnglish;
  final Future<void> Function() onToggleLanguage;
  final List<HeaderAnchor> anchors;
  final ValueChanged<String> onAnchorTap;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = AppLayout.horizontalPadding(constraints.maxWidth);
        const linkSpacing = AppSpacing.xxxl;
        const linkHorizontalPadding = AppSpacing.lg;
        final isCompact = constraints.maxWidth < AppLayout.navCollapseMaxWidth;
        final toggleWidth = isCompact ? AppSpacing.peta : AppSpacing.max;
        final toggleSpacing = isCompact ? AppSpacing.sm : AppSpacing.md;
        final maxWidth = math.min(
          constraints.maxWidth,
          AppLayout.maxContentWidth,
        );
        final contentWidth = maxWidth - (padding * 2);
        final linkStyle =
            Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600) ??
            const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: AppTypography.bodyMediumSize,
            );
        final anchorsWidth = _measureAnchorsWidth(
          context,
          anchors,
          linkStyle,
          linkHorizontalPadding,
          linkSpacing,
        );
        final togglesWidth = (toggleWidth * 2) + toggleSpacing;
        final shouldCollapse =
            isCompact || anchorsWidth + togglesWidth > contentWidth;

        return Container(
          color: AppColors.background,
          alignment: Alignment.center,
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: AppLayout.maxContentWidth,
            ),
            padding: EdgeInsets.symmetric(horizontal: padding),
            height: kToolbarHeight,
            child: shouldCollapse
                ? Row(
                    children: [
                      _HeaderMenu(anchors: anchors, onAnchorTap: onAnchorTap),
                      const Spacer(),
                      LanguageToggle(
                        isEnglish: isEnglish,
                        onToggle: onToggleLanguage,
                      ),
                      SizedBox(width: toggleSpacing),
                      ThemeToggle(
                        themeMode: themeMode,
                        onToggle: onToggleTheme,
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            spacing: linkSpacing,
                            children: [
                              for (final anchor in anchors)
                                _HeaderLink(
                                  label: anchor.label,
                                  onTap: () => onAnchorTap(anchor.targetId),
                                ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          LanguageToggle(
                            isEnglish: isEnglish,
                            onToggle: onToggleLanguage,
                          ),
                          SizedBox(width: toggleSpacing),
                          ThemeToggle(
                            themeMode: themeMode,
                            onToggle: onToggleTheme,
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

double _measureAnchorsWidth(
  BuildContext context,
  List<HeaderAnchor> anchors,
  TextStyle? textStyle,
  double horizontalPadding,
  double spacing,
) {
  if (anchors.isEmpty) {
    return 0;
  }
  final textPainter = TextPainter(
    textDirection: Directionality.of(context),
    maxLines: 1,
    textScaler: MediaQuery.textScalerOf(context),
  );
  var totalWidth = 0.0;
  for (final anchor in anchors) {
    textPainter.text = TextSpan(text: anchor.label, style: textStyle);
    textPainter.layout();
    totalWidth += textPainter.width + (horizontalPadding * 2);
  }
  totalWidth += spacing * (anchors.length - 1);
  return totalWidth;
}

class _HeaderMenu extends StatelessWidget {
  const _HeaderMenu({required this.anchors, required this.onAnchorTap});

  final List<HeaderAnchor> anchors;
  final ValueChanged<String> onAnchorTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: PopupMenuButton<int>(
        tooltip: 'Menu',
        offset: const Offset(0, kToolbarHeight),
        icon: const Icon(Icons.menu),
        itemBuilder: (context) {
          return [
            for (var index = 0; index < anchors.length; index++)
              PopupMenuItem<int>(
                value: index,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(anchors[index].label),
                  ),
                ),
              ),
          ];
        },
        onSelected: (index) {
          if (index >= 0 && index < anchors.length) {
            onAnchorTap(anchors[index].targetId);
          }
        },
      ),
    );
  }
}

class _HeaderLink extends StatelessWidget {
  const _HeaderLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: AppColors.textMuted,
          textStyle: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        child: Text(label),
      ),
    );
  }
}
