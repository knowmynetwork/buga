import 'package:buga/screens/rider_view/auth_views/auth_export.dart';
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
  final String date; // New property for the date

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

  // Mock list of locations
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

  // For the "From" field suggestions
  List<String> _filteredFromLocations = [];
  List<String> get filteredFromLocations => _filteredFromLocations;
  bool _isFromSuggestionsVisible = false;
  bool get isFromSuggestionsVisible => _isFromSuggestionsVisible;

  // For the "To" field suggestions
  List<String> _filteredToLocations = [];
  List<String> get filteredToLocations => _filteredToLocations;
  bool _isToSuggestionsVisible = false;
  bool get isToSuggestionsVisible => _isToSuggestionsVisible;

  void updateRiders(int value) {
    state = state.copyWith(riders: value);
  }

  void updateLuggage(int value) {
    state = state.copyWith(luggage: value);
  }

  void updateFromLocation(String value) {
    state = state.copyWith(fromLocation: value);
    _filteredFromLocations = value.isEmpty
        ? []
        : _allLocations
            .where((location) =>
                location.toLowerCase().contains(value.toLowerCase()))
            .toList();
    _isFromSuggestionsVisible = value.isNotEmpty;
    state = state.copyWith(); // Trigger UI update
  }

  void selectFromLocation(String value) {
    state = state.copyWith(fromLocation: value);
    _isFromSuggestionsVisible = false; // Hide suggestions
    state = state.copyWith(); // Trigger UI update
  }

  void updateToLocation(String value) {
    state = state.copyWith(toLocation: value);
    _filteredToLocations = value.isEmpty
        ? []
        : _allLocations
            .where((location) =>
                location.toLowerCase().contains(value.toLowerCase()))
            .toList();
    _isToSuggestionsVisible = value.isNotEmpty;
    state = state.copyWith(); // Trigger UI update
  }

  void selectToLocation(String value) {
    state = state.copyWith(toLocation: value);
    _isToSuggestionsVisible = false; // Hide suggestions
    state = state.copyWith(); // Trigger UI update
  }

  void addSavedPlace(String from, String to) {
    final updatedSavedPlaces = List<Map<String, String>>.from(state.savedPlaces)
      ..add({'from': from, 'to': to});
    state = state.copyWith(savedPlaces: updatedSavedPlaces);
  }

  void removeSavedPlace(int index) {
    final updatedSavedPlaces = List<Map<String, String>>.from(state.savedPlaces)
      ..removeAt(index);
    state = state.copyWith(savedPlaces: updatedSavedPlaces);
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
    // TODO: Implement your API submission logic here.
  }
}

final rideDetailsProvider =
    StateNotifierProvider<RideDetailsNotifier, RideDetailsState>(
  (ref) => RideDetailsNotifier(),
);
