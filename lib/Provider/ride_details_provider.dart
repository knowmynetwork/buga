import 'package:buga/screens/rider_view/auth_views/auth_export.dart';
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
          date: DateFormat('yyyy-MM-dd')
              .format(DateTime.now()), // Initialize date
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

  // Filtered locations for the dropdown
  List<String> _filteredLocations = [];
  List<String> get filteredLocations => _filteredLocations;

// Visibility flag for the suggestions list
  bool _isSuggestionsVisible = false;
  bool get isSuggestionsVisible => _isSuggestionsVisible;

  void updateRiders(int value) {
    state = state.copyWith(riders: value);
  }

  void updateLuggage(int value) {
    state = state.copyWith(luggage: value);
  }

  void updateFromLocation(String value) {
    state = state.copyWith(fromLocation: value);
    _filterLocations(value);
    _isSuggestionsVisible = value.isNotEmpty;
    state = state.copyWith(); // Trigger UI update
  }

  void selectFromLocation(String value) {
    state = state.copyWith(fromLocation: value);
    _isSuggestionsVisible = false; // Hide suggestions
    state = state.copyWith(); // Trigger UI update
  }

  void updateToLocation(String value) {
    state = state.copyWith(toLocation: value);
    _filterLocations(value);
  }

  void _filterLocations(String query) {
    if (query.isEmpty) {
      _filteredLocations = [];
    } else {
      _filteredLocations = _allLocations
          .where((location) =>
              location.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    // Notify listeners about the change
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
