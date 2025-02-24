import 'package:buga/route/navigation.dart';
import 'package:buga/theme/app_colors.dart';
import 'package:buga/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'login_view.dart';

class RiderOtpView extends StatelessWidget {
  const RiderOtpView({super.key});

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
                          popScreen();
                        },
                        icon: Icon(Icons.arrow_back))
                  ],
                ),
                SizedBox(height: 3.h),
                AuthWidgets.headerText('We sent you a verification code!'),
              ],
            ),
          ),
        )));
  }
}
