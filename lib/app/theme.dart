import 'package:flutter/material.dart';

class MercDealTheme {
  static const green = Color(0xFF43FF8A);
  static const blue = Color(0xFF39A7FF);
  static const navy = Color(0xFF050B14);
  static const surface = Color(0xFF08131F);
  static const card = Color(0xFF0B1A29);
  static const card2 = Color(0xFF102437);

  static ThemeData dark() {
    final scheme = ColorScheme.fromSeed(
      seedColor: green,
      brightness: Brightness.dark,
    ).copyWith(
      primary: green,
      secondary: blue,
      surface: surface,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: navy,
      colorScheme: scheme,
      fontFamily: 'Roboto',
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Color(0xFF07111C),
        indicatorColor: Color(0x2943FF8A),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontSize: 11,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w900
                : FontWeight.w600,
            color: states.contains(WidgetState.selected)
                ? green
                : Color(0x8AFFFFFF),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: card,
        hintStyle: const TextStyle(color: Color(0x61FFFFFF)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Color(0x0FFFFFFF)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: green),
        ),
      ),
    );
  }
}
