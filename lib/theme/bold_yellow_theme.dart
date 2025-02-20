import 'package:buga/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BoldYellowTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: AppColors.black, // Rich black
      scaffoldBackgroundColor: AppColors.white, // White
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.black,
        elevation: 0,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
        iconTheme: IconThemeData(color: AppColors.white),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.lightYellow, // Yellow buttons
        textTheme: ButtonTextTheme.primary,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColors.lightYellow, // Bold yellow
        unselectedItemColor: AppColors.white,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: AppColors.lightYellow, // Yellow background
          foregroundColor: AppColors.black, // Black text color
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
          backgroundColor: AppColors.lightYellow, // Yellow background
          foregroundColor: AppColors.black, // Black text color
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
