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
