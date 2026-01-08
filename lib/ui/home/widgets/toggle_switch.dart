import 'package:flutter/material.dart';
import 'package:portfolio/core/design_system/app_durations.dart';
import 'package:portfolio/core/design_system/app_layout.dart';
import 'package:portfolio/core/design_system/app_opacity.dart';
import 'package:portfolio/core/design_system/app_radii.dart';
import 'package:portfolio/core/design_system/app_spacing.dart';
import 'package:portfolio/core/theme/app_colors.dart';

class _PillSegmentedToggle extends StatelessWidget {
  const _PillSegmentedToggle({
    required this.leftSelected,
    required this.onToggle,
    required this.leftChild,
    required this.rightChild,
    this.width = AppSpacing.max,
    this.height = AppSpacing.xxxxxl,
    this.padding = AppSpacing.half,
    this.duration = AppDurations.slow,
    this.curve = Curves.easeOutCubic,
    this.semanticsLabel,
  });

  final bool leftSelected;
  final VoidCallback onToggle;
  final Widget leftChild;
  final Widget rightChild;
  final double width;
  final double height;
  final double padding;
  final Duration duration;
  final Curve curve;
  final String? semanticsLabel;

  Color _blend(Color base, Color overlay, double overlayOpacity) {
    return Color.alphaBlend(overlay.withValues(alpha: overlayOpacity), base);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final baseSurface = AppColors.surface;
    final trackColor = isDark
        ? AppColors.backgroundAlt
        : _blend(baseSurface, Colors.black, 0.04);

    final selectedColor = isDark
        ? _blend(trackColor, Colors.white, 0.06)
        : baseSurface;

    final borderColor = isDark
        ? AppColors.divider.withValues(alpha: 0.45)
        : AppColors.divider.withValues(alpha: 0.55);

    final innerBorder = isDark
        ? AppColors.divider.withValues(alpha: 0.25)
        : AppColors.divider.withValues(alpha: 0.35);

    final selectedShadow = <BoxShadow>[
      BoxShadow(
        color: Colors.black.withValues(alpha: isDark ? 0.22 : 0.10),
        blurRadius: isDark ? AppSpacing.sm : AppSpacing.md,
        offset: const Offset(0, AppSpacing.half),
      ),
    ];

    final innerWidth = width - (padding * 2);
    final innerHeight = height - (padding * 2);
    final segmentWidth = innerWidth / 2;

    return Semantics(
      label: semanticsLabel,
      button: true,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onToggle,
          behavior: HitTestBehavior.opaque,
          child: SizedBox(
            width: width,
            height: height,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: trackColor,
                borderRadius: BorderRadius.circular(AppRadii.pill),
                border: Border.all(color: borderColor, width: 1),
              ),
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Stack(
                  children: [
                    AnimatedAlign(
                      alignment: leftSelected
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      duration: duration,
                      curve: curve,
                      child: Container(
                        width: segmentWidth,
                        height: innerHeight,
                        decoration: BoxDecoration(
                          color: selectedColor,
                          borderRadius: BorderRadius.circular(AppRadii.pill),
                          border: Border.all(color: innerBorder, width: 1),
                          boxShadow: selectedShadow,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(child: Center(child: leftChild)),
                        Expanded(child: Center(child: rightChild)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({
    super.key,
    required this.themeMode,
    required this.onToggle,
  });

  final ThemeMode themeMode;
  final VoidCallback onToggle;

  bool _effectiveIsDark(BuildContext context) {
    final platform = MediaQuery.platformBrightnessOf(context);
    return themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system && platform == Brightness.dark);
  }

  double _toggleWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width < AppLayout.navCollapseMaxWidth
        ? AppSpacing.peta
        : AppSpacing.max;
  }

  double _toggleHeight(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width < AppLayout.navCollapseMaxWidth
        ? AppSpacing.xxxxl
        : AppSpacing.xxxxxl;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = _effectiveIsDark(context);
    final isDarkUi = Theme.of(context).brightness == Brightness.dark;

    final active = isDarkUi ? AppColors.accentDark : AppColors.accent;
    final inactive = AppColors.textMuted.withValues(
      alpha: isDarkUi ? 0.75 : 0.80,
    );

    Widget icon(IconData data, bool selected) {
      return AnimatedSwitcher(
        duration: AppDurations.fast,
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        child: Icon(
          data,
          key: ValueKey(selected),
          size: AppSpacing.xl,
          color: selected ? active : inactive,
        ),
      );
    }

    final leftSelected = !isDarkTheme;

    return _PillSegmentedToggle(
      leftSelected: leftSelected,
      onToggle: onToggle,
      leftChild: icon(Icons.light_mode_outlined, !isDarkTheme),
      rightChild: icon(Icons.dark_mode_outlined, isDarkTheme),
      width: _toggleWidth(context),
      height: _toggleHeight(context),
      padding: AppSpacing.half,
      duration: AppDurations.slow,
      curve: Curves.easeOutCubic,
      semanticsLabel: 'Toggle theme',
    );
  }
}

class LanguageToggle extends StatelessWidget {
  const LanguageToggle({
    super.key,
    required this.isEnglish,
    required this.onToggle,
  });

  final bool isEnglish;
  final VoidCallback onToggle;

  double _toggleWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width < AppLayout.navCollapseMaxWidth
        ? AppSpacing.peta
        : AppSpacing.max;
  }

  double _toggleHeight(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width < AppLayout.navCollapseMaxWidth
        ? AppSpacing.xxxxl
        : AppSpacing.xxxxxl;
  }

  Widget _flag(String emoji, bool selected) {
    return AnimatedOpacity(
      duration: AppDurations.fast,
      curve: Curves.easeOut,
      opacity: selected ? 1.0 : AppOpacity.alpha50,
      child: Text(
        emoji,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: AppSpacing.lg, height: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final leftSelected = isEnglish;
    final rightSelected = !isEnglish;

    return _PillSegmentedToggle(
      leftSelected: leftSelected,
      onToggle: onToggle,
      leftChild: _flag('\u{1F1FA}\u{1F1F8}', leftSelected),
      rightChild: _flag('\u{1F1E7}\u{1F1F7}', rightSelected),
      width: _toggleWidth(context),
      height: _toggleHeight(context),
      padding: AppSpacing.half,
      duration: AppDurations.slow,
      curve: Curves.easeOutCubic,
      semanticsLabel: 'Toggle language',
    );
  }
}
