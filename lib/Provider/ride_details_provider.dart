import 'package:buga/screens/rider_view/auth_views/auth_export.dart';

@immutable
class RideDetailsState {
  final int riders;
  final int luggage;
  final String fromLocation;
  final String toLocation;
  final bool isBookRealtimeSelected;
  final String rideOption;

  const RideDetailsState({
    this.riders = 2,
    this.luggage = 0,
    this.fromLocation = '',
    this.toLocation = '',
    this.isBookRealtimeSelected = true,
    this.rideOption = 'Saloon Car',
  });

  RideDetailsState copyWith({
    int? riders,
    int? luggage,
    String? fromLocation,
    String? toLocation,
    bool? isBookRealtimeSelected,
    String? rideOption,
  }) {
    return RideDetailsState(
      riders: riders ?? this.riders,
      luggage: luggage ?? this.luggage,
      fromLocation: fromLocation ?? this.fromLocation,
      toLocation: toLocation ?? this.toLocation,
      isBookRealtimeSelected:
          isBookRealtimeSelected ?? this.isBookRealtimeSelected,
      rideOption: rideOption ?? this.rideOption,
    );
  }
}

class RideDetailsNotifier extends StateNotifier<RideDetailsState> {
  RideDetailsNotifier() : super(const RideDetailsState());

  void updateRiders(int value) {
    state = state.copyWith(riders: value);
  }

  void updateLuggage(int value) {
    state = state.copyWith(luggage: value);
  }

  void updateFromLocation(String value) {
    state = state.copyWith(fromLocation: value);
  }

  void updateToLocation(String value) {
    state = state.copyWith(toLocation: value);
  }

  void toggleBookingType(bool isRealtime) {
    state = state.copyWith(isBookRealtimeSelected: isRealtime);
  }

  void updateRideOption(String option) {
    state = state.copyWith(rideOption: option);
  }

  Future<void> submitRideDetails() async {
    // TODO: Implement your API submission logic here.
    // Example:
    // await http.post(
    //   Uri.parse('https://yourapi.com/submit'),
    //   body: {
    //     'riders': state.riders.toString(),
    //     'luggage': state.luggage.toString(),
    //     'from': state.fromLocation,
    //     'to': state.toLocation,
    //     'bookingType': state.isBookRealtimeSelected ? 'realtime' : 'scheduled',
    //     'rideOption': state.rideOption,
    //   },
    // );
  }
}

final rideDetailsProvider =
    StateNotifierProvider<RideDetailsNotifier, RideDetailsState>(
  (ref) => RideDetailsNotifier(),
);
