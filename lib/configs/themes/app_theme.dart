import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      fontFamily: GoogleFonts.roboto().fontFamily,
      primaryColor: ColorStyle.primary,
      brightness: Brightness.light,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(
          color: ColorStyle.black,
        ),
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ColorStyle.primary.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: ColorStyle.primary,
            width: 2,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ColorStyle.primary.withOpacity(0.5),
            width: 1.5,
          ),
        ),
      ),
      scaffoldBackgroundColor: ColorStyle.white,
    );
  }
}

class ElevatedButtonStyles {
  static ButtonStyle primary = ElevatedButton.styleFrom(
    backgroundColor: ColorStyle.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: const BorderSide(color: ColorStyle.primary),
    ),
    foregroundColor: Colors.white,
  );

  static ButtonStyle secondary = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: const BorderSide(color: ColorStyle.primary),
    ),
    foregroundColor: ColorStyle.primary,
  );
}
