import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _primaryColor = Color(0xFFDF0000);

final themeData = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: _primaryColor,
    onPrimary: Colors.white,
    secondary: _primaryColor,
  ),
  textTheme: GoogleFonts.firaSansExtraCondensedTextTheme(),
);

abstract class AppStyle {
  static const padding = 10.0;
  static const edgeInsets = EdgeInsets.all(padding);
  static const colorBlack = Color(0xFF000000);
  static final h1 = GoogleFonts.firaSansExtraCondensed(
    textStyle: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
  );
}
