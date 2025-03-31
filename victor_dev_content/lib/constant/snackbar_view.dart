import 'package:buga/constant/global_variable.dart';
import 'package:buga/theme/app_colors.dart';
import 'package:buga/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SnackBarView {
  static void showSnackBar(String text, {int sec = 2}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.yellow,
        content: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.bold(
            color: AppColors.black,
            FontWeight.w600,
            fontSize: FontSize.font14,
          ),
        ),
        duration: Duration(seconds: sec),
      ),
    );
  }
}

/// value holding loading animation across app
final loadingAnimationSpinkit = StateProvider((ref) => false);
Widget loadingAnimation() {
  return SpinKitWaveSpinner(
    color: AppColors.white,
  );
}
