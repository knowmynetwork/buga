import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class RideDetailsState {
  final int riders;
  final int luggage;
  final List<Map<String, String>> savedPlaces;
  final String fromLocation;
  final String toLocation;
  final bool isBookRealtimeSelected;
  final String rideOption;
  final String date;

  const RideDetailsState({
    this.savedPlaces = const [],
    this.riders = 2,
    this.luggage = 0,
    this.fromLocation = '',
    this.toLocation = '',
    this.isBookRealtimeSelected = false,
    this.rideOption = 'Saloon Car',
    this.date = '',
  });

  RideDetailsState copyWith({
    List<Map<String, String>>? savedPlaces,
    int? riders,
    int? luggage,
    String? fromLocation,
    String? toLocation,
    bool? isBookRealtimeSelected,
    String? rideOption,
    String? date,
  }) {
    return RideDetailsState(
      savedPlaces: savedPlaces ?? this.savedPlaces,
      riders: riders ?? this.riders,
      luggage: luggage ?? this.luggage,
      fromLocation: fromLocation ?? this.fromLocation,
      toLocation: toLocation ?? this.toLocation,
      isBookRealtimeSelected:
          isBookRealtimeSelected ?? this.isBookRealtimeSelected,
      rideOption: rideOption ?? this.rideOption,
      date: date ?? this.date,
    );
  }
}

class RideDetailsNotifier extends StateNotifier<RideDetailsState> {
  RideDetailsNotifier()
      : super(RideDetailsState(
          date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        ));

  // Full list of available locations.
  final List<String> _allLocations = [
    'New York',
    'Los Angeles',
    'Chicago',
    'Houston',
    'Phoenix',
    'Philadelphia',
    'San Antonio',
    'San Diego',
    'Dallas',
    'San Jose',
  ];

  // Public getter to allow the UI to access the locations.
  List<String> get allLocations => _allLocations;

  void updateRiders(int value) {
    state = state.copyWith(riders: value);
  }

  void updateLuggage(int value) {
    state = state.copyWith(luggage: value);
  }

  void updateFromLocation(String value) {
    state = state.copyWith(fromLocation: value);
  }

  void selectFromLocation(String value) {
    state = state.copyWith(fromLocation: value);
  }

  void updateToLocation(String value) {
    state = state.copyWith(toLocation: value);
  }

  void selectToLocation(String value) {
    state = state.copyWith(toLocation: value);
  }

  void toggleBookingType(bool isRealtime) {
    state = state.copyWith(isBookRealtimeSelected: isRealtime);
  }

  void updateRideOption(String option) {
    state = state.copyWith(rideOption: option);
  }

  void updateDate(String value) {
    state = state.copyWith(date: value);
  }

  Future<void> submitRideDetails() async {
    debugPrint('Submitting Ride Details:');
    debugPrint('Riders: ${state.riders}');
    debugPrint('Luggage: ${state.luggage}');
    debugPrint('From Location: ${state.fromLocation}');
    debugPrint('To Location: ${state.toLocation}');
    debugPrint(
        'Booking Type: ${state.isBookRealtimeSelected ? 'Realtime' : 'Scheduled'}');
    debugPrint('Ride Option: ${state.rideOption}');
    debugPrint('Date: ${state.date}');
    // TODO: Implement your API submission logic here.
  }
}

final rideDetailsProvider =
    StateNotifierProvider<RideDetailsNotifier, RideDetailsState>(
  (ref) => RideDetailsNotifier(),
);
