import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YellowAccentTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: const Color(0xFF1E88E5), // Dark blue
      scaffoldBackgroundColor: const Color(0xFFF5F5F5), // Light gray
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF1E88E5),
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
        buttonColor: const Color(0xFF1E88E5), // Blue buttons
        textTheme: ButtonTextTheme.primary,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Color(0xFFFFC107), // Yellow accent
        unselectedItemColor: Colors.black54,
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
