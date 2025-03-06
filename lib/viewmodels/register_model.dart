import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterModel {
  final String email;
  final String name;
  final String number;
  final String altNumber;
  final String password;
  final String comPassword;
  final String? otp;
  final String? address;
  final String? city;
  final String? state;
  final String? category;
  // /////// emergency contact
  final String? eName;
  final String? eRelationShip;
  final String? eNumber;
  final String? eAltNumber;

  RegisterModel(
      {required this.email,
      required this.name,
      required this.number,
      required this.altNumber,
      required this.password,
      required this.comPassword,
      required this.otp,
      required this.address,
      required this.city,
      required this.state,
      required this.category,
      required this.eName,
      required this.eRelationShip,
      required this.eNumber,
      required this.eAltNumber});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'phoneNumber': number,
      'alternativePhoneNumber': altNumber,
      'password': password,
      'confirmPassword': comPassword,
      'otp': otp,
      'address': address,
      'city': city,
      'state': state,
      'category': category,
      'emergencyContact': {
        // Added emergencyContact object
        'name': eName,
        'relationship': eRelationShip,
        'phoneNumber': eNumber,
        'alternativePhoneNumber': eAltNumber,
      }
    };
  }
}

class RegisterProviders {
  static final name = StateProvider((ref) => '');
  static final email = StateProvider((ref) => '');
  static final phoneNumber = StateProvider((ref) => '');
  static final altNumber = StateProvider((ref) => '');
  static final password = StateProvider((ref) => '');
  static final otp = StateProvider((ref) => '');
  static final address = StateProvider((ref) => '');
  static final city = StateProvider((ref) => '');
  static final state = StateProvider((ref) => '');
  static final category = StateProvider((ref) => '');
  static final eName = StateProvider((ref) => '');
  static final eRelationShip = StateProvider((ref) => '');
  static final ePhoneNumber = StateProvider((ref) => '');
  static final eAltNumber = StateProvider((ref) => '');
}
