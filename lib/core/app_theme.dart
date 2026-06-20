import 'package:flutter/material.dart';

abstract class AppTheme {
  static const _lightColorScheme = ColorScheme.light(
    primary: Color(0xFF4a7c59),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFFdedede),

    surface: Color(0xFFF5F5F5),
    onSurface: Color(0xFF212121),
  );

  static final TextTheme _textTheme = TextTheme(
    headlineLarge: TextStyle(color: _lightColorScheme.primary, fontSize: 20),
    headlineMedium: TextStyle(
      color: _lightColorScheme.primary,
      fontSize: 80,
      fontWeight: FontWeight.w900,
    ),
  );

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: _lightColorScheme,
      fontFamily: 'Noto Serif',
      textTheme: _textTheme,
    );
  }
}
