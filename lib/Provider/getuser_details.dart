import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserModel {
  final String name;
  final String email;
  final String phoneNumber;
  final String userType;

  UserModel({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.userType,
  });

  //Updated fields
  UserModel copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? userType,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userType: userType ?? this.userType,
    );
  }
}

// StateNotifier to manage the user state
class UserNotifier extends StateNotifier<UserModel?> {
  UserNotifier() : super(null);

  // Set all user details
  void setUserDetails({
    required String name,
    required String email,
    required String phoneNumber,
    required String userType,
  }) {
    state = UserModel(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      userType: userType,
    );
  }

  // Update fields 
  void updateName(String name) {
    if (state != null) {
      state = state!.copyWith(name: name);
    }
  }

  void updateEmail(String email) {
    if (state != null) {
      state = state!.copyWith(email: email);
    }
  }

  void updatePhoneNumber(String phoneNumber) {
    if (state != null) {
      state = state!.copyWith(phoneNumber: phoneNumber);
    }
  }

  void updateUserType(String userType) {
    if (state != null) {
      state = state!.copyWith(userType: userType);
    }
  }

  // Clear user details (during logout)
  void clearUser() {
    state = null;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserModel?>((ref) {
  return UserNotifier();
});
