import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/theme/app_colors.dart';

class AppTypography {
  static const double displayLargeSize = 48;
  static const double headlineLargeSize = 36;
  static const double headlineMediumSize = 28;
  static const double titleLargeSize = 22;
  static const double bodyLargeSize = 16;
  static const double bodyMediumSize = 14;
  static const double bodySmallSize = 13;
  static const double bodyTinySize = 12;
  static const double portfolioTitleSize = 20;
  static const double headingHeight = 1.1;
  static const double bodyLargeHeight = 1.7;
  static const double bodyMediumHeight = 1.6;
  static const double bodyCompactHeight = 1.55;
  static const double bodyTightHeight = 1.5;
  static const double heroIntroMobile = 28;
  static const double heroIntroTablet = 32;
  static const double heroIntroDesktop = 36;
  static const double heroNameMobile = 34;
  static const double heroNameTablet = 40;
  static const double heroNameDesktop = 44;

  static TextTheme buildTextTheme(TextTheme base, AppPalette palette) {
    final textTheme = GoogleFonts.poppinsTextTheme(
      base,
    ).apply(bodyColor: palette.textPrimary, displayColor: palette.textPrimary);

    TextStyle headingStyle(TextStyle? style) {
      return GoogleFonts.playfairDisplay(
        textStyle: style,
        color: palette.textPrimary,
        fontWeight: FontWeight.w700,
        height: headingHeight,
      );
    }

    return textTheme.copyWith(
      displayLarge: headingStyle(
        textTheme.displayLarge,
      ).copyWith(fontSize: displayLargeSize),
      headlineLarge: headingStyle(
        textTheme.headlineLarge,
      ).copyWith(fontSize: headlineLargeSize),
      headlineMedium: headingStyle(
        textTheme.headlineMedium,
      ).copyWith(fontSize: headlineMediumSize),
      titleLarge: headingStyle(
        textTheme.titleLarge,
      ).copyWith(fontSize: titleLargeSize),
      bodyLarge: textTheme.bodyLarge?.copyWith(
        fontSize: bodyLargeSize,
        color: palette.textMuted,
        height: bodyLargeHeight,
      ),
      bodyMedium: textTheme.bodyMedium?.copyWith(
        fontSize: bodyMediumSize,
        color: palette.textMuted,
        height: bodyMediumHeight,
      ),
    );
  }
}
