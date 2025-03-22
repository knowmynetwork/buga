import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:buga/Provider/ride_details_provider.dart';
import 'package:buga/screens/global_screens/buga_form_field_autocomple.dart';
import 'package:buga/screens/onboarding_driver_view/screen/find_driver.dart';

// The main SharedRideScreen widget using BugaFormFieldAutocomple for suggestions.
class SharedRideScreen extends ConsumerWidget {
  final String rideType;
  const SharedRideScreen({super.key, required this.rideType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rideDetails = ref.watch(rideDetailsProvider);
    final rideDetailsNotifier = ref.read(rideDetailsProvider.notifier);

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
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            // Dismiss the keyboard when tapping outside.
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // "From" Field using BugaFormFieldAutocomple
                BugaFormFieldAutocomple(
                  label: 'From',
                  icon: Icons.location_on,
                  placeholder: 'Enter Starting Point',
                  initialValue: rideDetails.fromLocation,
                  options: rideDetailsNotifier.allLocations,
                  onSelected: (selection) {
                    rideDetailsNotifier.selectFromLocation(selection);
                  },
                  onChanged: (value) {
                    rideDetailsNotifier.updateFromLocation(value);
                  },
                ),
                const SizedBox(height: 8),
                // "To" Field using BugaFormFieldAutocomple
                BugaFormFieldAutocomple(
                  label: 'To',
                  icon: Icons.location_on,
                  placeholder: 'Enter Destination',
                  initialValue: rideDetails.toLocation,
                  options: rideDetailsNotifier.allLocations,
                  onSelected: (selection) {
                    rideDetailsNotifier.selectToLocation(selection);
                  },
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
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (selectedDate != null) {
                      final formattedDate =
                          DateFormat('yyyy-MM-dd').format(selectedDate);
                      rideDetailsNotifier.updateDate(formattedDate);
                    }
                  },
                ),
                const SizedBox(height: 16),
                // GestureDetector around Passenger and Luggage Info to dismiss the keyboard on tap.
                GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: PassengerAndLuggageInfo(rideDetails: rideDetails),
                ),
                const SizedBox(height: 16),
                // Proceed Button at the bottom.
                ElevatedButton(
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
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.black),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget for the Date Picker field.
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

// Widget for displaying passenger and luggage information.
class PassengerAndLuggageInfo extends StatelessWidget {
  final RideDetailsState rideDetails;
  const PassengerAndLuggageInfo({Key? key, required this.rideDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
