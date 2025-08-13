import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const backgroundColor = Color(0xffffffff);
  static const containerLost = Color(0xffE8E9FE);
  static const containerFound = Color(0xfffbddde);

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: backgroundColor,
    primaryColor: containerLost,
    colorScheme:const ColorScheme.light(
      primary:  Color.fromARGB(255, 70, 70, 71),
      secondary: containerFound
    ),
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.light().textTheme,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundColor,
      elevation: 6,
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: containerLost,
        foregroundColor: Colors.black,
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}

