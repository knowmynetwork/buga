import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YellowDominantTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: const Color(0xFFFFC107), // Yellow
      scaffoldBackgroundColor: const Color(0xFFF5F5F5), // Light gray
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFFFFC107),
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
        buttonColor: const Color(0xFFFFC107), // Yellow buttons
        textTheme: ButtonTextTheme.primary,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Color(0xFFFFC107),
        unselectedItemColor: Color(0xFF424242),
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
