import 'package:flutter/material.dart';

// Light Theme Colors (User's provided palette)
class QuranLightColors {
  static const Color primary = Color(0xFF226131); // Green primary color
  static const Color background = Color(0xFFFFFDF9); // #FFFDF9
  static const Color textPrimary = Color(0xFF1F1F1F); // #1F1F1F
  static const Color accent = Color(0xFF923E3E); // #923E3E (moved to accent)
  static const Color surface = Color(0xFFFFFCF8); // #FFFCF8
  static const Color textHint = Color(0xFFE0E0E0); // #E0E0E0
  static const Color cardBackground = Color(0xFFF5F4EE); // #F5F4EE
  static const Color secondary = Color(0xFFEFE9E5); // #EFE9E5
  static const Color onSurface = Color(0xFFFFFFFF); // #FFFFFF
  static const Color primaryVariant = Color(0xFF000279); // #000279
  static const Color success = Color(0xFF348200); // #348200
  static const Color error = Color(0xFF9C0000); // #9C0000
  static const Color textSecondary = Color(0xFF797900); // #797900
}

// Dark Theme Colors (User's provided palette)
class QuranDarkColors {
  static const Color primary =
      Color(0xFF4B9F5F); // Green primary color for dark theme
  static const Color background = Color(0xFF121212); // #121212
  static const Color textPrimary = Color(0xFFEAEAEA); // #EAEAEA
  static const Color accent = Color(0xFFBA5E5E); // #BA5E5E (moved to accent)
  static const Color surface = Color(0xFF121212); // #121212
  static const Color textHint = Color(0xFF5C5C5C); // #5C5C5C
  static const Color cardBackground = Color(0xFF1C1C1C); // #1C1C1C
  static const Color secondary = Color(0xFF1D1D1D); // #1D1D1D
  static const Color onSurface = Color(0xFF353535); // #353535
  static const Color primaryVariant = Color(0xFF7F81FF); // #7F81FF
  static const Color success = Color(0xFF4B9F5F); // #4B9F5F
  static const Color error = Color(0xFFF44C4C); // #F44C4C
  static const Color textSecondary = Color(0xFFFBFF00); // #FBFF00
}

// Theme Helper - Best Practice for accessing colors based on current theme
class ThemeColors {
  static bool _isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color primary(BuildContext context) =>
      _isDarkMode(context) ? QuranDarkColors.primary : QuranLightColors.primary;

  static Color background(BuildContext context) => _isDarkMode(context)
      ? QuranDarkColors.background
      : QuranLightColors.background;

  static Color textPrimary(BuildContext context) => _isDarkMode(context)
      ? QuranDarkColors.textPrimary
      : QuranLightColors.textPrimary;

  static Color accent(BuildContext context) =>
      _isDarkMode(context) ? QuranDarkColors.accent : QuranLightColors.accent;

  static Color surface(BuildContext context) =>
      _isDarkMode(context) ? QuranDarkColors.surface : QuranLightColors.surface;

  static Color textHint(BuildContext context) => _isDarkMode(context)
      ? QuranDarkColors.textHint
      : QuranLightColors.textHint;

  static Color cardBackground(BuildContext context) => _isDarkMode(context)
      ? QuranDarkColors.cardBackground
      : QuranLightColors.cardBackground;

  static Color secondary(BuildContext context) => _isDarkMode(context)
      ? QuranDarkColors.secondary
      : QuranLightColors.secondary;

  static Color onSurface(BuildContext context) => _isDarkMode(context)
      ? QuranDarkColors.onSurface
      : QuranLightColors.onSurface;

  static Color primaryVariant(BuildContext context) => _isDarkMode(context)
      ? QuranDarkColors.primaryVariant
      : QuranLightColors.primaryVariant;

  static Color success(BuildContext context) =>
      _isDarkMode(context) ? QuranDarkColors.success : QuranLightColors.success;

  static Color error(BuildContext context) =>
      _isDarkMode(context) ? QuranDarkColors.error : QuranLightColors.error;

  static Color textSecondary(BuildContext context) => _isDarkMode(context)
      ? QuranDarkColors.textSecondary
      : QuranLightColors.textSecondary;
}

// Legacy QuranColors class for backward compatibility
class QuranColors {
  // Mapped to light theme for backward compatibility
  static const Color primary = QuranLightColors.primary;
  static const Color primaryDark = QuranLightColors.accent;
  static const Color primaryLight = QuranLightColors.cardBackground;
  static const Color background = QuranLightColors.background;
  static const Color surface = QuranLightColors.onSurface;
  static const Color cardBackground = QuranLightColors.surface;
  static const Color textPrimary = QuranLightColors.textPrimary;
  static const Color textSecondary = QuranLightColors.textSecondary;
  static const Color textHint = QuranLightColors.textHint;
  static const Color quranPagesColor = QuranLightColors.secondary;
  static const Color orangeColor = QuranLightColors.primary;
  static const Color blueColor = QuranLightColors.primaryVariant;
}

// Text Styles - Now theme-aware
class QuranTextStyles {
  // Static styles for components that handle their own theming
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle suraTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle suraSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle verseText = TextStyle(
    fontSize: 16,
    height: 1.8,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle arabicNumber = TextStyle(
    fontFamily: "arsura",
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  // Theme-aware text styles (use these for automatic color switching)
  static TextStyle appBarTitleThemed(BuildContext context) =>
      appBarTitle.copyWith(
        color: ThemeColors.onSurface(context),
      );

  static TextStyle suraTitleThemed(BuildContext context) => suraTitle.copyWith(
        color: ThemeColors.textPrimary(context),
      );

  static TextStyle suraSubtitleThemed(BuildContext context) =>
      suraSubtitle.copyWith(
        color: ThemeColors.textSecondary(context),
      );

  static TextStyle verseTextThemed(BuildContext context) => verseText.copyWith(
        color: ThemeColors.textPrimary(context),
      );

  static TextStyle arabicNumberThemed(BuildContext context) =>
      arabicNumber.copyWith(
        color: ThemeColors.primary(context),
      );
}

// App Constants
class QuranConstants {
  static const double borderRadius = 16.0;
  static const double cardBorderRadius = 12.0;
  static const double buttonBorderRadius = 15.0;

  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 20.0;

  static const int maxSearchResults = 10;
  static const int maxQuranPages = 604;
}
