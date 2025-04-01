import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserLatLong {
  double userLat;
  double userLong;
  UserLatLong({required this.userLat, required this.userLong});

  ////////
  static final userLatLongProvider = StateProvider<UserLatLong>(
    (ref) => UserLatLong(userLat: 0.0, userLong: 0.0),
  );

  static final userLocationSearch = StateProvider((ref) => '');
}
