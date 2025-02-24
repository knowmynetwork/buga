import 'package:buga/route/navigation.dart';
import 'package:buga/screens/rider_view/onboarding_rider_view/onboarding.dart';
import 'package:buga/theme/app_colors.dart';
import 'package:buga/theme/app_text_styles.dart';
import 'package:buga/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'login_view.dart';
import 'otp_view.dart';

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
        padding: EdgeInsets.symmetric(horizontal: 5.w),
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
                  fontSize: FontSize.font18,
                ),
              ),
            ),
            SizedBox(height: 5.h),
            appLabel('What would you like us to call you?'),
            SizedBox(height: 1.h),
            CustomTextField(
              hintText: 'Name',
              prefixIcon: Icons.email,
              keyboardType: TextInputType.text,
              controller: TextEditingController(),
            ),
            SizedBox(height: 2.h),
            appLabel('Your best Email?'),
            SizedBox(height: 1.h),
            CustomTextField(
              hintText: 'E.g yourname@gmail.com',
              prefixIcon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              controller: TextEditingController(),
            ),
            SizedBox(height: 2.h),
            appLabel('Your Phone Number (We’ll send a verification code)'),
            SizedBox(height: 1.h),
            CustomTextField(
              hintText: '+23400007654',
              prefixIcon: Icons.email,
              keyboardType: TextInputType.number,
              controller: TextEditingController(),
            ),
            SizedBox(height: 2.h),
            appLabel('An alternative phone number '),
            Text(
              'To ensure we can absolutely reach you',
              style: AppTextStyle.medium(
                FontWeight.w500,
                fontSize: FontSize.font12,
              ),
            ),
            SizedBox(height: 1.h),
            CustomTextField(
              hintText: '+23400007654',
              prefixIcon: Icons.email,
              keyboardType: TextInputType.number,
              controller: TextEditingController(),
            ),
            SizedBox(height: 2.h),
            appLabel('Secure your account'),
            SizedBox(height: 1.h),
            PasswordInputField(
              controller: TextEditingController(),
              label: 'Password',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                return null;
              },
            ),
            SizedBox(height: 1.h),
            PasswordInputField(
              controller: TextEditingController(),
              label: 'Password',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                return null;
              },
            ),
            SizedBox(height: 3.h),
            MaterialButton(
              minWidth: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 2.h),
              onPressed: () {
                navigateTo(RiderOtpView());
              },
              color: AppColors.lightYellow,
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Proceed',
                      style: AppTextStyle.medium(
                        FontWeight.w700,
                        fontSize: FontSize.font18,
                      ),
                    ),
                    SizedBox(width: 1.w),
                    Icon(Icons.arrow_circle_right_sharp)
                  ],
                ),
              ),
            ),
            SizedBox(height: 4.h),
          ],
        ),
      )),
    );
  }
}
