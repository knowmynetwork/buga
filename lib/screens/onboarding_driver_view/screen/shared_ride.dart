import 'package:buga/Models/ride_details_state.dart';
import 'package:buga/constant/snackbar_view.dart';
import 'package:buga/screens/ride_details_bottom_sheet.dart';
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
    final rideDetailsAsync = ref.watch(rideDetailsProvider);
    final rideDetails = rideDetailsAsync.value;

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
      body: rideDetails == null
          ? const SizedBox.shrink()
          : GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                children: [
                  // Tab Section
                  Visibility(
                    visible: false,
                    child: Container(
                      color: const Color(0xFFFFD700),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _RideOptionButton(
                            label: 'Book Realtime',
                            isSelected: rideDetails.isBookRealtimeSelected,
                            onTap: () {
                              ref
                                  .read(rideDetailsProvider.notifier)
                                  .toggleBookingType(true);
                            },
                          ),
                          _RideOptionButton(
                            label: 'Schedule Trip',
                            isSelected: !rideDetails.isBookRealtimeSelected,
                            onTap: () {
                              ref
                                  .read(rideDetailsProvider.notifier)
                                  .toggleBookingType(false);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        BugaFormFieldAutocomple(
                          label: 'From',
                          icon: Icons.location_on,
                          placeholder: 'Enter Starting Point',
                          initialValue: rideDetails.fromLocation,
                          options: rideDetailsNotifier.allLocations,
                          onSelected: rideDetailsNotifier.selectFromLocation,
                          onChanged: rideDetailsNotifier.updateFromLocation,
                        ),
                        const SizedBox(height: 8),
                        BugaFormFieldAutocomple(
                          label: 'To',
                          icon: Icons.location_on,
                          placeholder: 'Enter Destination',
                          initialValue: rideDetails.toLocation,
                          options: rideDetailsNotifier.allLocations,
                          onSelected: rideDetailsNotifier.selectToLocation,
                          onChanged: rideDetailsNotifier.updateToLocation,
                        ),
                        const SizedBox(height: 16),
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
                                  DateFormat('yyyy-MM-dd').format(selectedDate);
                              rideDetailsNotifier.updateDate(formattedDate);
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        PassengerAndLuggageInfo(rideDetails: rideDetails),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: () async {
                        ref.read(loadingAnimationSpinkit.notifier).state = true;

                        await rideDetailsNotifier
                            .submitRideDetailsAndGetMoreRideDetails();

                        ref.read(loadingAnimationSpinkit.notifier).state =
                            false;

                        final rideState = ref.read(rideDetailsProvider);

                        if (rideState.hasError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Failed to fetch ride details. Please try again.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

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
                      child: ref.watch(loadingAnimationSpinkit)
                          ? loadingAnimation()
                          : Row(
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
                  ),
                ],
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

class _RideOptionButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _RideOptionButton({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class PassengerAndLuggageInfo extends StatelessWidget {
  const PassengerAndLuggageInfo({
    super.key,
    required this.rideDetails,
  });

  final RideDetailsState rideDetails;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        builder: (context) {
          return RideDetailsBottomSheet(
            rideTitle: 'Ride Details',
            showSubmitButton: false,
          );
        },
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Passenger Icon and Text
          Row(
            children: [
              const Icon(Icons.person,
                  size: 20, color: Colors.black), // Passenger Icon
              const SizedBox(width: 4),
              Text(
                '${rideDetails.riders} Passengers',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(width: 16),

          // Luggage Icon and Text
          Row(
            children: [
              const Icon(Icons.luggage,
                  size: 20, color: Colors.black), // Luggage Icon
              const SizedBox(width: 4),
              Text(
                '${rideDetails.luggage} Luggage',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(width: 16),

          // Edit Icon
          const Icon(Icons.edit, size: 20, color: Colors.black), // Edit Icon
        ],
      ),
    );
  }
}
