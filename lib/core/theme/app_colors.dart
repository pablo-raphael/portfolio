import 'package:flutter/material.dart';

class AppPalette {
  const AppPalette({
    required this.background,
    required this.backgroundAlt,
    required this.surface,
    required this.surfaceDark,
    required this.accent,
    required this.accentDark,
    required this.textPrimary,
    required this.textMuted,
    required this.divider,
    required this.input,
  });

  final Color background;
  final Color backgroundAlt;
  final Color surface;
  final Color surfaceDark;
  final Color accent;
  final Color accentDark;
  final Color textPrimary;
  final Color textMuted;
  final Color divider;
  final Color input;

  static const AppPalette dark = AppPalette(
    background: Color(0xFF2F3138),
    backgroundAlt: Color(0xFF343640),
    surface: Color(0xFF3A3D46),
    surfaceDark: Color(0xFF2A2C33),
    accent: Color(0xFFF2B352),
    accentDark: Color(0xFFD59A3B),
    textPrimary: Color(0xFFF5F5F5),
    textMuted: Color(0xFFB8BBC3),
    divider: Color(0xFF3E414A),
    input: Color(0xFF3B3E47),
  );

  static const AppPalette light = AppPalette(
    background: Color(0xFFF1EDE6),
    backgroundAlt: Color(0xFFE9E2D8),
    surface: Color(0xFFFDFBF7),
    surfaceDark: Color(0xFF2A2D35),
    accent: Color(0xFFF2B352),
    accentDark: Color(0xFFD59A3B),
    textPrimary: Color(0xFF2A2D35),
    textMuted: Color(0xFF6B6F78),
    divider: Color(0xFFD8D0C4),
    input: Color(0xFFF6F1EA),
  );
}

class AppColors {
  static AppPalette _current = AppPalette.dark;
  static const Color pattern = Color(0xFF8C7A4A);

  static void setMode(ThemeMode mode) {
    _current = mode == ThemeMode.dark ? AppPalette.dark : AppPalette.light;
  }

  static Color get background => _current.background;

  static Color get backgroundAlt => _current.backgroundAlt;

  static Color get surface => _current.surface;

  static Color get surfaceDark => _current.surfaceDark;

  static Color get accent => _current.accent;

  static Color get accentDark => _current.accentDark;

  static Color get textPrimary => _current.textPrimary;

  static Color get textMuted => _current.textMuted;

  static Color get divider => _current.divider;

  static Color get input => _current.input;
}
