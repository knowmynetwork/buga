import 'package:buga/constant/global_variable.dart';
import 'package:buga/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SetUpBottomSheet {
  static setUpBottomSheet(Widget display) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return display;
      },
    );
  }
}
