import 'package:buga/constant/global_variable.dart';
import 'package:buga/constant/snackbar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

// Check user internet connection across app
class InternetChecks {
  static String message = 'Internet connection is needed';
  static final isUserConnected = StateProvider((ref) => false);

  // all driver internet checks
  static Future<void> internetCheck() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result) {
      provider.read(loadingAnimationSpinkit.notifier).state = true;
      provider.read(isUserConnected.notifier).state = true;
      debugPrint('user hes connected');
    } else {
      provider.read(isUserConnected.notifier).state = false;
      SnackBarView.showSnackBar(message);
    }
  }
}
