import 'package:buga/route/route.dart';
import 'package:buga/screens/emergency_cont.dart';
import 'package:buga/screens/forget_password.dart';
import 'package:buga/screens/home_screen.dart';
import 'package:buga/screens/rider_view/login_page.dart';
import 'package:buga/screens/onboarding_driver_view/screen/verification_screen.dart';
import 'package:buga/screens/rider_view/sign_up_page.dart';
import 'package:buga/screens/splash_view.dart';
import 'package:buga/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'constant/global_variable.dart';

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
            initialRoute: splashRoute, // Set the initial route
            routes: {
              loginRoute: (context) => LoginScreen(),
              splashRoute: (context) => SplashScreen(),
              signUpRoute: (context) => RiderSignUpView(),
              // otpRoute: (context) => OtpValidationPage(),
              home: (context) => HomeScreen(),
              verificationOtp: (context) => VerificationCodeScreen(),
              emergencyRoute: (context) => EmergencyContactForm(),
              forgotPageRoute: (context) => ForgotPasswordScreen(),
            },
          ),
        );
      },
    );
  }
}
