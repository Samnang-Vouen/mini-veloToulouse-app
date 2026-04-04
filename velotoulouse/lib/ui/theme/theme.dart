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
  static const Color surface = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE2E2E2);
  static const Color disabled = Color(0xFFCCCCCC);

  static Color get textNormal => AppColors.textDark;
  static Color get textLight => AppColors.textGrey;
  static Color get iconNormal => AppColors.textDark;
  static Color get iconLight => AppColors.textGrey;
}

///
/// Definition of App text styles.
///
class AppTextStyles {
  static TextStyle heading = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );
  static TextStyle title = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static TextStyle body = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static TextStyle label = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );
  static TextStyle price = const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
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
  static const double xxl = 48;

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
