import 'package:buga/Provider/ride_details_provider.dart';
import 'package:buga/screens/global_screens/ride_form_field.dart';
import 'package:buga/screens/onboarding_driver_view/screen/find_driver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// The main SharedRideScreen widget
class SharedRideScreen extends ConsumerWidget {
  final String rideType;
  const SharedRideScreen({super.key, required this.rideType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the ride details state and get the notifier
    final rideDetails = ref.watch(rideDetailsProvider);
    final rideDetailsNotifier = ref.read(rideDetailsProvider.notifier);

    // Create controllers initialized with current state values.
    final fromController =
        TextEditingController(text: rideDetails.fromLocation);
    final toController = TextEditingController(text: rideDetails.toLocation);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFD700),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Shared Ride',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          // Hide suggestions when the user taps outside the suggestions list
          rideDetailsNotifier.hideFromSuggestions();
          rideDetailsNotifier.hideToSuggestions();
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            // Main Content
            Column(
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // "From" Field (Start Location)
                      RideFormField(
                        label: 'From',
                        icon: Icons.circle_outlined,
                        placeholder: rideDetails.fromLocation.isEmpty
                            ? 'Enter Starting Point'
                            : rideDetails.fromLocation,
                        isEditable: true,
                        controller: fromController, // NEW
                        onChanged: (value) {
                          rideDetailsNotifier.updateFromLocation(value);
                        },
                      ),
                      const SizedBox(height: 8),
                      // "To" Field (End Location)
                      RideFormField(
                        label: 'To',
                        icon: Icons.location_on,
                        placeholder: rideDetails.toLocation.isEmpty
                            ? 'Enter Destination'
                            : rideDetails.toLocation,
                        isEditable: true,
                        controller: toController, // NEW
                        onChanged: (value) {
                          rideDetailsNotifier.updateToLocation(value);
                        },
                      ),
                      const SizedBox(height: 16),
                      // Date Picker Field
                      _DatePickerField(
                        selectedDate: rideDetails.date,
                        onTap: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)),
                          );
                          if (selectedDate != null) {
                            final formattedDate =
                                '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
                            rideDetailsNotifier.updateDate(formattedDate);
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      // Passenger and Luggage Info Widget
                      PassengerAndLuggageInfo(rideDetails: rideDetails),
                    ],
                  ),
                ),
                const Spacer(),
                // Proceed Button
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () async {
                      await rideDetailsNotifier.submitRideDetails();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RideDetailsScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Proceed',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.black),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Suggestions List Overlay for the "From" Field
            if (rideDetailsNotifier.isFromSuggestionsVisible)
              Positioned(
                top: 120, // Adjust based on the "From" field position
                left: 16,
                right: 16,
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 200),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: rideDetailsNotifier.filteredFromLocations.length,
                    itemBuilder: (context, index) {
                      final location =
                          rideDetailsNotifier.filteredFromLocations[index];
                      return ListTile(
                        title: Text(location),
                        onTap: () {
                          rideDetailsNotifier.selectFromLocation(location);
                        },
                      );
                    },
                  ),
                ),
              ),
            // Suggestions List Overlay for the "To" Field
            if (rideDetailsNotifier.isToSuggestionsVisible)
              Positioned(
                top: 180, // Adjust based on the "To" field position
                left: 16,
                right: 16,
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 200),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: rideDetailsNotifier.filteredToLocations.length,
                    itemBuilder: (context, index) {
                      final location =
                          rideDetailsNotifier.filteredToLocations[index];
                      return ListTile(
                        title: Text(location),
                        onTap: () {
                          rideDetailsNotifier.selectToLocation(location);
                        },
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Widget for displaying passenger and luggage information
class PassengerAndLuggageInfo extends StatelessWidget {
  final RideDetailsState rideDetails;
  const PassengerAndLuggageInfo({super.key, required this.rideDetails});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // You can add a bottom sheet trigger here if needed
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              const Icon(Icons.person, size: 20, color: Colors.black),
              const SizedBox(width: 4),
              Text(
                '${rideDetails.riders} Passengers',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Row(
            children: [
              const Icon(Icons.luggage, size: 20, color: Colors.black),
              const SizedBox(width: 4),
              Text(
                '${rideDetails.luggage} Luggage',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(width: 16),
          const Icon(Icons.edit, size: 20, color: Colors.black),
        ],
      ),
    );
  }
}

// Widget for the Date Picker field
class _DatePickerField extends StatelessWidget {
  final String selectedDate;
  final VoidCallback onTap;
  const _DatePickerField(
      {Key? key, required this.selectedDate, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          const Icon(Icons.calendar_today, size: 20, color: Colors.black),
          const SizedBox(width: 8),
          Text(
            selectedDate.isEmpty ? 'When' : selectedDate,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: selectedDate.isEmpty ? Colors.grey : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
