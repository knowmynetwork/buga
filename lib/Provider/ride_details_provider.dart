import 'dart:async';

import 'package:buga/Models/ride_details_state.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class RideDetailsNotifier extends AsyncNotifier<RideDetailsState> {
  @override
  FutureOr<RideDetailsState> build() {
    // Initialize state (you could even fetch from API here)
    return RideDetailsState(
      date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    );
  }

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
    state = state.whenData((current) => current.copyWith(riders: value));
  }

  void updateLuggage(int value) {
    state = state.whenData((current) => current.copyWith(luggage: value));
  }

  void updateFromLocation(String value) {
    state = state.whenData(
      (current) => current.copyWith(fromLocation: value),
    );
  }

  void selectFromLocation(String value) {
    state = state.whenData((current) => current.copyWith(fromLocation: value));
  }

  void updateToLocation(String value) {
    state = state.whenData((current) => current.copyWith(toLocation: value));
  }

  void selectToLocation(String value) {
    state = state.whenData((current) => current.copyWith(toLocation: value));
  }

  void toggleBookingType(bool isRealtime) {
    state = state.whenData(
        (current) => current.copyWith(isBookRealtimeSelected: isRealtime));
  }

  void updateRideOption(String option) {
    state = state.whenData((current) => current.copyWith(rideOption: option));
  }

  void updateDate(String value) {
    state = state.whenData((current) => current.copyWith(date: value));
  }

  void updateEstimatedPrice(String value) {
    state =
        state.whenData((current) => current.copyWith(estimatedPrice: value));
  }

  void updateYourOwnPrice(String value) {
    state = state.whenData((current) => current.copyWith(yourOwnPrice: value));
  }

  void updateMessageToDrivers(String value) {
    state =
        state.whenData((current) => current.copyWith(messageToDrivers: value));
  }

  void updateEstimatedTravelTime(String value) {
    state = state
        .whenData((current) => current.copyWith(estimatedTravelTime: value));
  }

  Future<void> submitRideForm() async {
    await submitRideDetailsAndGetMoreRideDetails();
    // You can also extend this to notify other listeners or analytics
  }

  Future<void> submitRideDetailsAndGetMoreRideDetails() async {
    state = const AsyncValue.loading();

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      final current = state.requireValue;

      final updated = current.copyWith(
        estimatedPrice: '₦15,500 - ₦16,500',
        estimatedTravelTime: '1 hour 10 mins',
      );

      state = AsyncValue.data(updated);

      debugPrint('Submitting Ride Details:');
      debugPrint('Riders: ${updated.riders}');
      debugPrint('Luggage: ${updated.luggage}');
      debugPrint('From Location: ${updated.fromLocation}');
      debugPrint('To Location: ${updated.toLocation}');
      debugPrint(
          'Booking Type: ${updated.isBookRealtimeSelected ? 'Realtime' : 'Scheduled'}');
      debugPrint('Ride Option: ${updated.rideOption}');
      debugPrint('Date: ${updated.date}');
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> submitRideDetailsAndFindDriver() async {
    state = const AsyncValue.loading();

    try {
      await Future.delayed(const Duration(seconds: 1));
      final current = state.requireValue;

      debugPrint('Submitting Ride Request...');
      debugPrint('Estimated Price: ${current.estimatedPrice}');
      debugPrint('Your Own Price: ${current.yourOwnPrice}');
      debugPrint('Estimated Travel Time: ${current.estimatedTravelTime}');
      debugPrint('Message to drivers: ${current.messageToDrivers}');

      // You might also update the state with a flag like `submitted: true` if needed

      state = AsyncValue.data(current);
      debugPrint('Ride request submitted.');
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final rideDetailsProvider =
    AsyncNotifierProvider<RideDetailsNotifier, RideDetailsState>(
  RideDetailsNotifier.new,
);
