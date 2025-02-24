import 'package:buga/route/navigation.dart';
import 'package:buga/screens/rider_view/onboarding_rider_view/onboarding.dart';
import 'package:buga/theme/app_colors.dart';
import 'package:buga/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'login_view.dart';

class RiderRegisterView extends StatelessWidget {
  const RiderRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightYellow,
      body: SafeArea(
          child: Container(
        color: AppColors.white,
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: ListView(
            children: [
              SizedBox(height: 1.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        navigateTo(OnboardingView());
                      },
                      icon: Icon(Icons.arrow_back))
                ],
              ),
              SizedBox(height: 3.h),
              AuthWidgets.headerText('Create a rider account'),
              Center(
                child: Text(
                  'It’ll only take a minute',
                  style: AppTextStyle.bold(
                    FontWeight.w700,
                    fontSize: FontSize.font30,
                  ),
                ),
              ),
              appLabel('What would you like us to call you?'),
              appLabel('Your best Email?'),
              appLabel('Your Phone Number (We’ll send a verification code)'),
              appLabel('An alternative phone number '),
              appLabel('Secure your account'),
              MaterialButton(
                minWidth: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 2.h),
                onPressed: () {},
                color: AppColors.lightYellow,
                child: Center(
                  child: Text(
                    'Proceed',
                    style: AppTextStyle.medium(
                      FontWeight.w700,
                      fontSize: FontSize.font18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
