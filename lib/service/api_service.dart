import 'dart:async';

class ApiService {
  Future<int> dummyApiCall() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    return 200; // Return success status
  }
}
