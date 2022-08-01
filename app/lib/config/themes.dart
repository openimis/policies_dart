import 'package:flutter/material.dart';

const _paletteOpenIMIS = ColorScheme(
  brightness: Brightness.light,
  // 076375
  // b2d0d5
  // 80b0b9
  // 32818f
  primary: Color(0xFF076375),
  onPrimary: Color(0xFF010202),
  secondary: Color(0xFF32818f), // TODO
  onSecondary: Color(0xFFFFFFFF),
  error: Colors.red,
  onError: Colors.white,
  background: Colors.white,
  onBackground: Color(0xFF010202),
  surface: Color(0xFFE5E5E5),
  onSurface: Color(0xFF010202),
);

final lightTheme = ThemeData.from(
  colorScheme: _paletteOpenIMIS,
).copyWith(
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: _paletteOpenIMIS.onPrimary,
      backgroundColor: _paletteOpenIMIS.primary,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: _paletteOpenIMIS.surface,
    filled: true,
    // TODO: Move label text above the input field to get the look defined in the UI
  ),
);
