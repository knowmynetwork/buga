import 'package:buga/constant/global_variable.dart';
import 'package:buga/onboarding/emergency_cont.dart';
import 'package:buga/onboarding/forget_password.dart';
import 'package:buga/onboarding/loader_screen.dart';
import 'package:buga/onboarding/login_page.dart';
import 'package:buga/onboarding/otp_verification.dart';
import 'package:buga/onboarding/sign_up_page.dart';
import 'package:buga/screens/home_screen.dart';
import 'package:buga/screens/login_page.dart';
import 'package:buga/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/otp_validation_page.dart';
import 'screens/sign_up_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // to avoid screen rotation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const RideSharingApp());
}

class RideSharingApp extends StatelessWidget {
  const RideSharingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return ProviderScope(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigationKey,
            title: 'Ride Sharing App',
            theme: AppThemeManager.activeTheme, // Global theme
            initialRoute: '/login', // Set the initial route
            routes: {
              '/login': (context) => LoginScreen(),
              '/signup': (context) => DriverAccountForm(),
              '/otp': (context) => OtpValidationPage(),
              '/home': (context) => HomeScreen(),
              '/otp_verification': (context) => VerificationCodeScreen(),
               '/emergency': (context) => EmergencyContactForm(),
                 '/loader': (context) => LoadingScreen(),
                 '/forgot': (context) => ForgotPasswordScreen(),
            },
          ),
        );
      },
    );
  }
}
