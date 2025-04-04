import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterDriverModel {
  final String email;
  final String name;
  final String number;
  final String altNumber;
  final String password;
  final String otp;
  final String address;
  final String city;
  final String state;
  final String category;

  RegisterDriverModel({
    required this.email,
    required this.name,
    required this.number,
    required this.altNumber,
    required this.password,
    required this.otp,
    required this.address,
    required this.city,
    required this.state,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "name": name,
      "phoneNumber": number,
      "alternativePhoneNumber": altNumber,
      "password": password,
      "otp": otp,
      "streetAddress": address,
      "city": city,
      "state": state,
      "driverCategory": category,
    };
  }
}

class RegisterProviders {
  static final name = StateProvider((ref) => '');
  static final email = StateProvider((ref) => '');
  static final id = StateProvider((ref) => '');
  static final phoneNumber = StateProvider((ref) => '');
  static final altNumber = StateProvider((ref) => '');
  static final password = StateProvider((ref) => '');
  static final otp = StateProvider((ref) => '');
  static final address = StateProvider((ref) => '');
  static final city = StateProvider((ref) => '');
  static final state = StateProvider((ref) => '');
  static final category = StateProvider((ref) => '');
}

class RegisterRiderModel {
  final String email;
  final String name;
  final String number;
  final String altNumber;
  final String password;
  final String? otp;
  final String? category;
  final String? id;

  RegisterRiderModel({
    required this.email,
    required this.name,
    required this.number,
    required this.altNumber,
    required this.password,
    required this.otp,
    required this.category,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "name": name,
      "phoneNumber": number,
      "alternativePhoneNumber": altNumber,
      "password": password,
      "otp": otp,
      "passengerType": category,
      "organizationId": id,
    };
  }
}
