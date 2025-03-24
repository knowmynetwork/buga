import 'screen_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      // updateFirstView();
      pushReplacementScreen(const OnboardingView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      provider = ref;
      return Scaffold(
          backgroundColor: AppColors.yellow,
          body: PopScope(
              canPop: true,
              onPopInvoked: (didPop) {
                SystemNavigator.pop();
              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    appLogo,
                  ),
                ),
              )));
    });
  }
}
