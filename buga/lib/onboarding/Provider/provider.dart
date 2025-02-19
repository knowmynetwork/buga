import 'package:buga/onboarding/screen/loader_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Loading State Provider (No longer needed!)
final isLoadingProvider = StateProvider<bool>((ref) => true);
@override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: someAsynchronousOperation(), // The operation that needs to complete
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          ref.read(isLoadingProvider.notifier).state = true; // Show loading
          return const LoadingIndicator();
        } else if (snapshot.hasError) {
          ref.read(isLoadingProvider.notifier).state = false; // Hide on error
          return Center(child: Text('Error: ${snapshot.error}')); // Show error
        } else {
          ref.read(isLoadingProvider.notifier).state = false; // Hide loading
          return const Text("Setup Complete!", style: TextStyle(fontSize: 16));
        }
      },
    );
  }

  Future<void> someAsynchronousOperation() async {
    // Simulate some work
    await Future.delayed(const Duration(seconds: 2));
    // Or fetch data, etc.
  }
  

// Driver provider
final driverAccountFormProvider = StateNotifierProvider<DriverAccountFormNotifier, DriverAccountFormData>(
  (ref) => DriverAccountFormNotifier(),
);

// 2. Define the Data Class with copyWith
class DriverAccountFormData {
  String name;
  String email;
  String phone;
  String altPhone;
  String address;
  String city;
  String state;
  String password;
  String confirmPassword;

  DriverAccountFormData({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.altPhone = '',
    this.address = '',
    this.city = '',
    this.state = '',
    this.password = '',
    this.confirmPassword = '',
  });

  DriverAccountFormData copyWith({
    String? name,
    String? email,
    String? phone,
    String? altPhone,
    String? address,
    String? city,
    String? state,
    String? password,
    String? confirmPassword,
  }) {
    return DriverAccountFormData(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      altPhone: altPhone ?? this.altPhone,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }
  
  toJson() {}
}

// 3. Define the StateNotifier
class DriverAccountFormNotifier extends StateNotifier<DriverAccountFormData> {
  DriverAccountFormNotifier() : super(DriverAccountFormData());

  void updateField(String fieldName, String value) {
    state = state.copyWith(
      name: fieldName == 'name' ? value : null,
      email: fieldName == 'email' ? value : null,
      phone: fieldName == 'phone' ? value : null,
      altPhone: fieldName == 'altPhone' ? value : null,
      address: fieldName == 'address' ? value : null,
      city: fieldName == 'city' ? value : null,
      state: fieldName == 'state' ? value : null,
      password: fieldName == 'password' ? value : null,
      confirmPassword: fieldName == 'confirmPassword' ? value : null,
    );
  }

  void resetForm() {
    state = DriverAccountFormData();
  }
}

// Providers for form data (Email and Password)
final emailProvider = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String>((ref) => '');

// Provider for Remember Me state
final rememberMeProvider = StateProvider<bool>((ref) => false);