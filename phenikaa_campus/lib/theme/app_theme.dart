import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme.dart';

class AppTheme {
  static ThemeData theme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Palette.rhinoDark800,
    appBarTheme: const AppBarTheme(
      backgroundColor: Palette.rhinoDark800,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Palette.blueColor,
    ),
    textTheme: TextTheme(
      bodyText2: GoogleFonts.manrope(color: Colors.white, fontSize: 16),
    ),
  );
}
