import 'package:flutter/material.dart';

/// App-wide color palette
class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF1565C0); // Blue 800
  static const Color primaryDark = Color(0xFF0D47A1); // Blue 900
  
  // Background colors
  static const Color background = Color(0xFF17172F);
  static const Color surface = Colors.white;
  static const Color surfaceDark = Colors.black;
  
  // Text colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF9CC5E6); // Light blue text
  static const Color textMuted = Colors.grey;
  
  // Accent colors
  static const Color success = Colors.green;
  static const Color accent = Colors.blue;
  
  // Border colors
  static const Color border = Colors.grey;
  static const Color borderLight = Color(0xFF677C8E);
}

/// App-wide text styles
class AppTextStyles {
  static const TextStyle heading = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle headingSecondary = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle body = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 14,
  );
  
  static const TextStyle bodySecondary = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 12,
  );
  
  static const TextStyle caption = TextStyle(
    color: AppColors.textMuted,
    fontSize: 10,
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle amountLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  
  static const TextStyle label = TextStyle(
    fontSize: 12,
    color: Colors.black54,
  );
  
  static const TextStyle rate = TextStyle(
    fontSize: 10,
    color: AppColors.success,
  );
}

/// App-wide spacing values
class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 20.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
}

/// App-wide border radius values
class AppRadius {
  static const double sm = 5.0;
  static const double md = 10.0;
  static const double lg = 20.0;
  static const double xl = 30.0;
}

/// App-wide animation durations
class AppDurations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 500);
  static const Duration slow = Duration(milliseconds: 600);
}

/// App theme configuration
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: AppColors.textPrimary,
      ),
    );
  }
}
