import 'package:flutter_riverpod/flutter_riverpod.dart';

class StoreRideType {
  String rideType;
  String rideMode;

  StoreRideType({required this.rideType, required this.rideMode});

  static final rideTypeProvider = StateProvider<StoreRideType>(
    (ref) => StoreRideType(rideType: '', rideMode: ''), 
  );
}
