import 'package:buga/service/api_service.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final ApiService apiService;

  AuthViewModel(this.apiService);

  String message = '';

  Future<void> signUp(String email, String password) async {
    try {
      final response = await apiService.dummyApiCall();
      if (response == 200) {
        message = 'Sign-Up Successful!';
      } else {
        message = 'Sign-Up Failed!';
      }
    } catch (e) {
      message = 'Error: $e';
    }
    notifyListeners(); // Notify UI of state changes
  }
}
