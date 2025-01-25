import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BoldYellowTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: const Color(0xFF000000), // Rich black
      scaffoldBackgroundColor: const Color(0xFFFFFFFF), // White
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF000000),
        elevation: 0,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
      buttonTheme: ButtonThemeData(
        buttonColor: const Color(0xFFFFEB3B), // Yellow buttons
        textTheme: ButtonTextTheme.primary,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Color(0xFFFFEB3B), // Bold yellow
        unselectedItemColor: Colors.white70,
      ),
          textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFFFFC107), // Yellow background
          foregroundColor: Colors.black, // Black text color
          minimumSize: const Size(double.infinity, 48), // Full width
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Rounded corners
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // Define custom ElevatedButton style
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFC107), // Yellow background
          foregroundColor: Colors.black, // Black text color
          minimumSize: const Size(double.infinity, 48), // Full width
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Rounded corners
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    
    
    );
  }
}
