import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserModel {
  final String token;
  final String id;
  final String name;
  final String email;
  final String phoneNumber;

  UserModel({
    required this.token,
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });
}

class UserNotifier extends StateNotifier<UserModel?> {
  UserNotifier() : super(null);

  void setUser(UserModel user) {
    state = user;
  }

  void clearUser() {
    state = null;
  }
}

// Create a provider for the UserNotifier
final userProvider = StateNotifierProvider<UserNotifier, UserModel?>((ref) {
  return UserNotifier();
});
