import 'package:buga/constant/global_variable.dart';
import 'package:buga/constant/snackbar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

// Check user internet connection across app
class InternetChecks {
  static String message = 'Internet connection is needed';
  static final isloginDataOn = StateProvider((ref) => false);

  // all driver internet checks
  static Future<void> dLoginInternetCheck() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result) {
      provider.read(isloginDataOn.notifier).state = true;
      debugPrint('user hes connected');
    } else {
      provider.read(isloginDataOn.notifier).state = false;
      SnackBarView.showSnackBar(message);
    }
  }

  static Future<void> dRegisterInternetCheck() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result) {
      debugPrint('user hes connected');
    } else {
      SnackBarView.showSnackBar(message);
    }
  }

  static Future<void> dForgotPassWordInternetCheck() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result) {
      debugPrint('user hes connected');
    } else {
      SnackBarView.showSnackBar(message);
    }
  }
}
