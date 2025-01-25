import 'package:flutter/material.dart';
import 'yellow_dominant_theme.dart';
import 'yellow_accent_theme.dart';
import 'muted_yellow_theme.dart';
import 'earthy_yellow_theme.dart';
import 'bold_yellow_theme.dart';

class AppThemeManager {
  // Define available themes
  static final Map<String, ThemeData> themes = {
    'Yellow Dominant': YellowDominantTheme.theme,
    'Yellow Accent': YellowAccentTheme.theme,
    'Muted Yellow': MutedYellowTheme.theme,
    'Earthy Yellow': EarthyYellowTheme.theme,
    'Bold Yellow': BoldYellowTheme.theme,
  };

  // Active theme
  static String currentTheme = 'Yellow Dominant';

  // Get the current theme
  static ThemeData get activeTheme => themes[currentTheme]!;

  // Switch to a new theme
  static void switchTheme(String themeName) {
    if (themes.containsKey(themeName)) {
      currentTheme = themeName;
    } else {
      throw Exception('Theme $themeName not found!');
    }
  }
}
