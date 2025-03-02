import 'package:buga/constant/global_variable.dart';
import 'package:buga/theme/app_colors.dart';
import 'package:buga/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class SnackBarView {
  static void showSnackBar(String text, {int sec = 2}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.lightYellow,
        content: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.medium(
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
