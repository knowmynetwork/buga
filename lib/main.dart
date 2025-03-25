import 'package:buga/local_storage/pref.dart';
import 'package:buga/screens/global_screens/onboarding.dart';
import 'package:buga/riders/onboarding/screen/export.dart';
import 'package:buga/riders/onboarding/screen/forget_password.dart';
import 'package:buga/riders/onboarding/screen/login_page.dart';
import 'package:buga/screens/global_screens/splash_view.dart';
import 'package:buga/riders/auth/login_view.dart';
import 'package:buga/theme/app_theme.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'screens/global_screens/bottom_nav.dart';

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
                forgotPageRoute: (context) => ForgotPasswordScreen(),
              },
              home: Consumer(
                builder: (context, ref, _) {
                  provider = ref;
                  return TokenCheck();
                },
              )),
        );
      },
    );
  }
}

class TokenCheck extends StatefulWidget {
  const TokenCheck({super.key});

  @override
  State createState() => _TokenCheckState();
}

class _TokenCheckState extends State<TokenCheck> {
  bool navigationCompleted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          _checkToken();
        }
      });
    });
  }

  void _checkToken() async {
    if (navigationCompleted) {
      debugPrint(
          ' Navigation already completed - preventing duplicate navigation');
      return;
    }

    try {
      final userType = await Pref.getStringValue(userTypeKey);
      final token = await Pref.getStringValue(tokenKey);

      debugPrint('token its $token');
      debugPrint(' User TYPE is: $userType');

      if (token.isEmpty) {
        _navigateBasedOnUserType(userType);
      } else {
        debugPrint('Checking token expiration');
        final bool hasExpired = JwtDecoder.isExpired(token);
        debugPrint('Token expired? $hasExpired');

        if (hasExpired) {
          debugPrint('Token expired - going to onboarding');
          _safeNavigate(() {
            pushReplacementScreen(const OnboardingView());
          });
        } else {
          debugPrint('Token valid - going to home screen');
          _safeNavigate(() {
            pushReplacementScreen(const MainHomeView());
          });
        }
      }
    } catch (e) {
      debugPrint('ERROR during token check: $e');
      _safeNavigate(() {
        pushReplacementScreen(const OnboardingView());
      });
    }
  }

  void _navigateBasedOnUserType(String userType) {
    if (userType == 'Driver') {
      debugPrint('Empty token, userType is Driver - going to driver login');
      _safeNavigate(() {
        pushReplacementScreen(const LoginScreen());
      });
    } else if (userType == 'Passenger') {
      debugPrint('Empty token, userType is Passenger - going to rider login');
      _safeNavigate(() {
        pushReplacementScreen(const RiderLoginView());
      });
    } else {
      debugPrint('Empty token, userType unknown - going to onboarding');
      _safeNavigate(() {
        pushReplacementScreen(const OnboardingView());
      });
    }
  }

  void _safeNavigate(Function() navigationAction) {
    if (!mounted || navigationCompleted) {
      debugPrint(
          'Not navigating: widget not mounted or navigation already completed');
      return;
    }

    navigationCompleted = true;
    navigationAction();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}


