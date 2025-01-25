import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EarthyYellowTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: const Color(0xFFFAF3E0), // Cream
      scaffoldBackgroundColor: const Color(0xFFF5F5F5), // Light beige
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFFFAF3E0),
        elevation: 0,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.brown,
        ),
        iconTheme: const IconThemeData(color: Colors.brown),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
      buttonTheme: ButtonThemeData(
        buttonColor: const Color(0xFFFFCA28), // Amber buttons
        textTheme: ButtonTextTheme.primary,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Color(0xFF6D4C41), // Brown
        unselectedItemColor: Colors.brown,
      ),
    );
  }
}
