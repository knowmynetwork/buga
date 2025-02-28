import 'package:buga/route/navigation.dart';
import 'package:buga/screens/rider_view/onboarding_rider_view/onboarding.dart';
import 'package:buga/theme/app_colors.dart';
import 'package:buga/theme/app_text_styles.dart';
import 'package:buga/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'register_view.dart';

class RiderLoginView extends StatefulWidget {
  const RiderLoginView({super.key});

  @override
  State<RiderLoginView> createState() => _RiderLoginViewState();
}

class _RiderLoginViewState extends State<RiderLoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberLogin = false;

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
            AuthWidgets.headerText('Welcome back!'),
            SizedBox(height: 0.1.h),
            Center(
              child: Text(
                'Login to your rider account',
                style: AppTextStyle.bold(
                  FontWeight.w700,
                  fontSize: FontSize.font18,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            CustomTextField(
              hintText: 'Email Address',
              prefixIcon: Icons.email,
              controller: _emailController,
            ),
            SizedBox(height: 2.h),
            CustomTextField(
              hintText: 'Password',
              prefixIcon: Icons.lock,
              obscureText: true,
              controller: _passwordController,
            ),
            SizedBox(height: 2.h),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberLogin,
                        onChanged: (value) {
                          setState(() {
                            _rememberLogin = value!;
                          });
                        },
                      ),
                      Text(
                        'Remember Login',
                        style: AppTextStyle.medium(
                          FontWeight.w500,
                          fontSize: FontSize.font12,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot your password?',
                      style: AppTextStyle.medium(
                        FontWeight.w500,
                        fontSize: FontSize.font12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.h),
            MaterialButton(
              minWidth: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 2.h),
              onPressed: () {},
              color: AppColors.lightYellow,
              child: Center(
                child: Text(
                  'Login',
                  style: AppTextStyle.medium(
                    FontWeight.w700,
                    fontSize: FontSize.font18,
                  ),
                ),
              ),
            ),
            SizedBox(height: 3.h),
            Center(
              child: GestureDetector(
                onTap: () {
                  navigateTo(RiderRegisterView());
                },
                child: Text(
                  'New to Buga? Sign up!',
                  style: TextStyle(
                    fontSize: FontSize.font13,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationThickness: 2.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class AuthWidgets {
  static Widget headerText(String text) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: AppTextStyle.bold(
          FontWeight.w700,
          fontSize: FontSize.font24,
        ),
      ),
    );
  }
}
