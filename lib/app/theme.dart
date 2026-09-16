import 'package:flutter/material.dart';

/// flutterFriday Material 3 主題（繁體中文介面）
class AppTheme {
  static const Color seed = Color(0xFF6C5CE7);
  static const Color freeBadge = Color(0xFF00B894);
  
  static const Color darkBackground = Color(0xFF0A0A0A);
  static const Color darkSurface = Color(0xFF1A1A1A);
  static const Color darkSurfaceVariant = Color(0xFF252525);
  static const Color accentPurple = Color(0xFF9D7CFF);
  static const Color accentCyan = Color(0xFF00D9FF);

  // UI-B colors
  static const Color lightBackground = Color(0xFFF5F5F7);
  static const Color nearBlack = Color(0xFF1D1D1F);
  static const Color primaryCTA = Color(0xFF0071E3);

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: primaryCTA,
      brightness: Brightness.light,
      surface: lightBackground,
      onSurface: nearBlack,
      primary: primaryCTA,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: lightBackground,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: Colors.white,
        foregroundColor: nearBlack,
        elevation: 0,
        toolbarHeight: 56,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          backgroundColor: primaryCTA,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: nearBlack.withOpacity(0.1)),
        ),
      ),
    );
  }
  
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      colorScheme: ColorScheme.dark(
        primary: accentPurple,
        secondary: accentCyan,
        surface: darkSurface,
        surfaceContainerHighest: darkSurfaceVariant,
        background: darkBackground,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 56,
          fontWeight: FontWeight.bold,
          letterSpacing: -1.5,
          height: 1.1,
        ),
        headlineMedium: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        headlineSmall: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          height: 1.6,
          letterSpacing: 0.15,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          height: 1.5,
        ),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: darkBackground,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(200, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          shadowColor: accentPurple.withOpacity(0.4),
        ),
      ),
      cardTheme: CardThemeData(
        color: darkSurface,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

/// 免費徽章
class FreeBadge extends StatelessWidget {
  const FreeBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.freeBadge.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppTheme.freeBadge),
      ),
      child: const Text(
        '免費',
        style: TextStyle(
          color: AppTheme.freeBadge,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}
