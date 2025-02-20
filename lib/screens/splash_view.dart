import 'package:buga/constant/global_variable.dart';
import 'package:buga/constant/images.dart';
import 'package:buga/route/navigation.dart';
import 'package:buga/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'rider_view/onboarding_rider_view/onboarding.dart';

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

  // updateFirstView() async {
  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   await pref.setBool(isUserFirstTime, true);
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      provider = ref;
      return Scaffold(
          backgroundColor: AppColors.lightYellow,
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
