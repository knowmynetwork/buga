import 'package:buga/constant/images.dart';
import 'package:buga/route/navigation.dart';
import 'package:buga/screens/onboarding_driver_view/screen/login_page.dart';
import 'package:buga/theme/app_colors.dart';
import 'package:buga/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              onboardingImage2,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Container(
            width: 100.w,
            padding: EdgeInsetsDirectional.symmetric(horizontal: 5.w),
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 9.h),
                Container(
                  width: 100.w,
                  height: 7.h,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      tabView("Rider", AppColors.black, AppColors.white),
                      SizedBox(width: 3.w),
                      GestureDetector(
                          onTap: () {
                            navigateTo(LoginScreen());
                          },
                          child: tabView(
                              "Driver", AppColors.white, AppColors.black))
                    ],
                  ),
                ),
                SizedBox(height: 60.h),
                Text(
                  'Skip',
                  style: TextStyle(
                    color: AppColors.lightYellow,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.lightYellow,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationThickness: 2.0,
                  ),
                ),
                SizedBox(height: 2.h),
                SizedBox(
                  width: 19.w,
                  height: 8.h,
                  child: MaterialButton(
                    onPressed: () {},
                    color: AppColors.lightYellow,
                    child: Icon(Icons.arrow_forward),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget tabView(String text, Color bkColor, textColor) {
    return Container(
      width: 41.w,
      height: 6.h,
      decoration:
          BoxDecoration(color: bkColor, borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: Text(
          text,
          style: AppTextStyle.medium(FontWeight.w400,
              fontSize: FontSize.font13, color: textColor),
        ),
      ),
    );
  }
}
