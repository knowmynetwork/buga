import 'package:buga/local_storage/pref.dart';
import 'package:buga/screens/onboarding_driver_view/screen/export.dart';
import 'package:buga/screens/onboarding_driver_view/screen/forget_password.dart';
import 'package:buga/screens/onboarding_driver_view/screen/login_page.dart';
import 'package:buga/screens/rider_view/splash_view.dart';
import 'package:buga/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // to avoid screen rotation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  // initializing Local storage
  await Pref.init();
  runApp(const RideSharingApp());
}

class RideSharingApp extends StatelessWidget {
  const RideSharingApp({super.key});

  @override
  Widget build(BuildContext context) {
    //   String yourToken = "Your JWT";
    // bool hasExpired = JwtDecoder.isExpired(yourToken);
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
                // home: (context) => HomeScreen(),
                emergencyRoute: (context) => EmergencyContactScreen(),
                forgotPageRoute: (context) => ForgotPasswordScreen(),
              },
              home: Consumer(
                builder: (context, ref, _) {
                  provider = ref;
                  return SplashScreen();
                },
              )),
        );
      },
    );
  }
}
