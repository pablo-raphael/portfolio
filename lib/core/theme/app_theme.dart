import 'package:flutter/material.dart';
import 'package:portfolio/core/design_system/app_radii.dart';
import 'package:portfolio/core/design_system/app_spacing.dart';
import 'package:portfolio/core/design_system/app_typography.dart';
import 'package:portfolio/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData build({
    required AppPalette palette,
    required Brightness brightness,
  }) {
    final base = brightness == Brightness.dark
        ? ThemeData.dark()
        : ThemeData.light();
    final textTheme = AppTypography.buildTextTheme(base.textTheme, palette);

    return base.copyWith(
      scaffoldBackgroundColor: palette.background,
      colorScheme: base.colorScheme.copyWith(
        primary: palette.accent,
        secondary: palette.accent,
        surface: palette.surface,
        onSurface: palette.textPrimary,
        onPrimary: palette.surfaceDark,
      ),
      dividerColor: palette.divider,
      textTheme: textTheme,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: palette.input,
        hintStyle: textTheme.bodyMedium?.copyWith(color: palette.textMuted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.xs),
          borderSide: BorderSide(color: palette.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.xs),
          borderSide: BorderSide(color: palette.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.xs),
          borderSide: BorderSide(color: palette.accent),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: palette.accent,
          side: BorderSide(color: palette.accent, width: 1.2),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.xs),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: palette.accent,
          foregroundColor: palette.surfaceDark,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xxl,
            vertical: AppSpacing.md,
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.xs),
          ),
        ),
      ),
    );
  }
}
