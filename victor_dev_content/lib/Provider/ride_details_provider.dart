import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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
  final String estimatedPrice; // Added field
  final String estimatedTravelTime; // Added field
  final String yourOwnPrice; // Added field
  final String messageToDrivers; // Added field

  const RideDetailsState({
    this.savedPlaces = const [],
    this.riders = 2,
    this.luggage = 0,
    this.fromLocation = '',
    this.toLocation = '',
    this.isBookRealtimeSelected = false,
    this.rideOption = 'Saloon Car',
    this.date = '',
    this.estimatedPrice = '', // Default value
    this.estimatedTravelTime = '', // Default value
    this.yourOwnPrice = '', // Default value
    this.messageToDrivers = '', // Default value
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
    String? estimatedPrice, // Added parameter
    String? estimatedTravelTime, // Added parameter
    String? yourOwnPrice, // Added parameter
    String? messageToDrivers, // Added parameter
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
      estimatedPrice: estimatedPrice ?? this.estimatedPrice, // Added line
      estimatedTravelTime:
          estimatedTravelTime ?? this.estimatedTravelTime, // Added line
      yourOwnPrice: yourOwnPrice ?? this.yourOwnPrice, // Added line
      messageToDrivers: messageToDrivers ?? this.messageToDrivers, // Added line
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

  void updateEstimatedPrice(String value) {
    state = state.copyWith(estimatedPrice: value);
  }

  void updateYourOwnPrice(String value) {
    state = state.copyWith(yourOwnPrice: value);
  }

  void updateMessageToDrivers(String value) {
    state = state.copyWith(messageToDrivers: value);
  }

  void updateEstimatedTravelTime(String value) {
    state = state.copyWith(estimatedTravelTime: value);
  }

  Future<void> submitRideForm() async {
    await submitRideDetailsAndGetMoreRideDetails();
    // You can also extend this to notify other listeners or analytics
  }

  Future<void> submitRideDetailsAndGetMoreRideDetails() async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network delay
    state = state.copyWith(
      estimatedPrice: '₦15,500 - ₦16,500',
      estimatedTravelTime: '1 hour 10 mins',
    );
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

  Future<void> submitRideDetailsAndFindDriver() async {
    debugPrint('Submitting Ride Request...');
    debugPrint('Estimated Price: ${state.estimatedPrice}');
    debugPrint('Your Own Price: ${state.yourOwnPrice}');
    debugPrint('Estimated Travel Time: ${state.estimatedTravelTime}');
    debugPrint('Message to drivers: ${state.messageToDrivers}');
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    debugPrint('Ride request submitted.');
  }
}

final rideDetailsProvider =
    StateNotifierProvider<RideDetailsNotifier, RideDetailsState>(
  (ref) => RideDetailsNotifier(),
);
