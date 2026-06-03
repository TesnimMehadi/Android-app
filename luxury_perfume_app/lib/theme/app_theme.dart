import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';


abstract final class AppTheme {
  static const double borderRadius = 35;
  static const double borderRadiusSmall = 24;
  static const double cardElevation = 8;

  static ThemeData get lightTheme {
    final serif = GoogleFonts.playfairDisplayTextTheme();
    final sans = GoogleFonts.latoTextTheme();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.light(
        primary: AppColors.cardRose,
        onPrimary: AppColors.white,
        secondary: AppColors.textPrimary,
        surface: AppColors.background,
        onSurface: AppColors.textPrimary,
      ),
      textTheme: TextTheme(
        displayLarge: serif.displayLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
        displayMedium: serif.displayMedium?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        headlineLarge: serif.headlineLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: serif.headlineMedium?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
        titleLarge: serif.titleLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: sans.titleMedium?.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        ),
        bodyLarge: sans.bodyLarge?.copyWith(color: AppColors.textPrimary),
        bodyMedium: sans.bodyMedium?.copyWith(color: AppColors.textSecondary),
        labelLarge: sans.labelLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.textPrimary,
        size: 22,
      ),
    );
  }

  static ThemeData get darkTheme {
    final serif = GoogleFonts.playfairDisplayTextTheme(
      ThemeData.dark().textTheme,
    );
    final sans = GoogleFonts.latoTextTheme(ThemeData.dark().textTheme);
    const darkBg = Color(0xFF1D1517);
    const darkCard = Color(0xFF2B2023);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBg,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.cardRose,
        secondary: AppColors.cardRoseLight,
        surface: darkCard,
      ),
      textTheme: TextTheme(
        displayLarge: serif.displayLarge?.copyWith(color: Colors.white),
        displayMedium: serif.displayMedium?.copyWith(color: Colors.white),
        headlineLarge: serif.headlineLarge?.copyWith(color: Colors.white),
        headlineMedium: serif.headlineMedium?.copyWith(color: Colors.white),
        titleLarge: serif.titleLarge?.copyWith(color: Colors.white),
        titleMedium: sans.titleMedium?.copyWith(color: Colors.white70),
        bodyLarge: sans.bodyLarge?.copyWith(color: Colors.white),
        bodyMedium: sans.bodyMedium?.copyWith(color: Colors.white70),
        labelLarge: sans.labelLarge?.copyWith(color: Colors.white),
      ),
    );
  }

  static List<BoxShadow> get softShadow => [
        BoxShadow(
          color: AppColors.shadow,
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ];

  static List<BoxShadow> get elevatedCardShadow => [
        const BoxShadow(
          color: Color.fromRGBO(74, 31, 37, 0.18),
          blurRadius: 32,
          offset: Offset(0, 12),
        ),
      ];
}
