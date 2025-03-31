import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MutedYellowTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: const Color(0xFFFAF3E0), // Cream background
      scaffoldBackgroundColor: const Color(0xFFFFFFFF), // White
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFFFAF3E0),
        elevation: 0,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
      buttonTheme: ButtonThemeData(
        buttonColor: const Color(0xFFFFEB3B), // Muted yellow buttons
        textTheme: ButtonTextTheme.primary,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Color(0xFFFFEB3B), // Muted yellow
        unselectedItemColor: Colors.black54,
      ),
    );
  }
}
