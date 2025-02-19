

import 'package:buga/screens/login_page.dart';
import 'package:buga/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'screens/otp_validation_page.dart';
import 'onboarding/screen/sign_up_driver.dart';
import 'package:buga/screens/home_screen.dart';

void main() {
  runApp(const RideSharingApp());
}

class RideSharingApp extends StatelessWidget {
  const RideSharingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ride Sharing App',
      theme: AppThemeManager.activeTheme, // Global theme
      initialRoute: '/login', // Set the initial route
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => DriverAccountScreen(),
        '/otp': (context) => OtpValidationPage(),
        '/home': (context) => HomeScreen(),
      },    
    );
  }
}
