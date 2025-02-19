import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle heading = GoogleFonts.raleway(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static TextStyle subHeading = GoogleFonts.raleway(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static TextStyle body = GoogleFonts.raleway(
    fontSize: 14,
  );

  static TextStyle small = GoogleFonts.raleway(
    fontSize: 12,
    color: Colors.black54,
  );
}
