import 'package:flutter/material.dart';

///
/// Definition of App colors.
///
class AppColors {
  static const Color primary = Color(0xFFE8552A);
  static const Color primaryLight = Color(0xFFFAD9CE);

  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textGrey = Color(0xFF6B6B6B);

  static const Color background = Color(0xFFFFFFFF);
  static const Color backgroundAlt = Color(0xFFF5F6FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE2E2E2);
  static const Color disabled = Color(0xFFCCCCCC);
  static const Color cardDisabled = Color(0xFFE8E9EE);

  static const Color error = Color(0xFFD32F2F);

  /// Subtle shadow: equivalent to Colors.black12 (opacity 0.07)
  static const Color shadowLight = Color(0x1F000000);

  /// Medium shadow: equivalent to Colors.black26 (opacity 0.26)
  static const Color shadowMedium = Color(0x42000000);
}

///
/// Definition of App text styles.
///
class AppTextStyles {
  static TextStyle heading = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );

  /// Heavy heading – same size as [heading] but w900 weight.
  static TextStyle headingHeavy = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w900,
  );

  static TextStyle title = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  /// Bold title – 17 px / w700, used for modal and section headers.
  static TextStyle titleBold = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
  );

  static TextStyle body = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static TextStyle label = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );

  /// Small bold caption – 11 px / w700, used for badge and uppercase labels.
  static TextStyle caption = const TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w700,
  );

  static TextStyle price = const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
  );

  /// Medium price display – 18 px / w800.
  static TextStyle priceMedium = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
  );

  static TextStyle button = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
  );
}

///
/// Definition of App spacings, in pixels.
///
class AppSpacing {
  static const double xs = 4;
  static const double s = 8;
  static const double m = 16;
  static const double l = 24;
  static const double xl = 32;

  static const double radius = 12;
  static const double radiusLarge = 24;
}

///
/// Definition of App Theme.
///
ThemeData appTheme = ThemeData(
  fontFamily: 'Eesti',
  scaffoldBackgroundColor: AppColors.background,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: Colors.white,
    surface: AppColors.surface,
    onSurface: AppColors.textDark,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.background,
    foregroundColor: AppColors.textDark,
    elevation: 0,
    centerTitle: true,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      disabledBackgroundColor: AppColors.disabled,
      shape: const StadiumBorder(),
      elevation: 0,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.textGrey,
    type: BottomNavigationBarType.fixed,
  ),
);
