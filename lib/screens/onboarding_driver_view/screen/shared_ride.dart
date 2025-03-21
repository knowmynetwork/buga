import 'package:buga/Provider/ride_details_provider.dart';
import 'package:buga/screens/global_screens/__ride_form_field.dart';
import 'package:buga/screens/onboarding_driver_view/screen/find_driver.dart';
import 'package:buga/screens/ride_details_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SharedRideScreen extends ConsumerWidget {
  final String rideType;
  const SharedRideScreen({super.key, required this.rideType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rideDetails = ref.watch(rideDetailsProvider);
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
      body: Column(
        children: [
          // Tab Section:
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
          // Form Section:
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                RideFormField(
                  label: 'From',
                  icon: Icons.circle_outlined,
                  placeholder: rideDetails.fromLocation.isEmpty
                      ? 'Enter Starting Point'
                      : rideDetails.fromLocation,
                  isEditable: true,
                  onChanged: (value) {
                    ref
                        .read(rideDetailsProvider.notifier)
                        .updateFromLocation(value);
                  },
                ),
                const SizedBox(height: 8),
                RideFormField(
                  label: 'To',
                  icon: Icons.location_on,
                  placeholder: rideDetails.toLocation.isEmpty
                      ? 'Enter Destination'
                      : rideDetails.toLocation,
                  isEditable: true,
                  onChanged: (value) {
                    ref
                        .read(rideDetailsProvider.notifier)
                        .updateToLocation(value);
                  },
                ),
                const SizedBox(height: 16),
                _DatePickerField(
                  selectedDate: rideDetails.date,
                  onTap: () async {
                    debugPrint('Opening date picker...');
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (selectedDate != null) {
                      final formattedDate =
                          '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
                      ref
                          .read(rideDetailsProvider.notifier)
                          .updateDate(formattedDate);
                    }
                  },
                ),
                const SizedBox(height: 16),
                PassengerAndLuggageInfo(rideDetails: rideDetails),
              ],
            ),
          ),

          const Spacer(),
          _buildSavedPlacesSection(ref),
          // Proceed Button:
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () async {
                await ref
                    .read(rideDetailsProvider.notifier)
                    .submitRideDetails();
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '${rideDetails.riders} Passengers',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 16),
          Text(
            '${rideDetails.luggage} Luggage',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        builder: (context) {
          return RideDetailsBottomSheet(rideTitle: 'Ride Details');
        },
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

Widget _buildSavedPlacesSection(WidgetRef ref) {
  final rideDetails = ref.watch(rideDetailsProvider);
  final rideDetailsNotifier = ref.read(rideDetailsProvider.notifier);

  return Expanded(
    child: ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: rideDetails.savedPlaces.length + 1,
      itemBuilder: (context, index) {
        if (index < rideDetails.savedPlaces.length) {
          final location = rideDetails.savedPlaces[index];
          return Column(
            children: [
              ListTile(
                leading: const Icon(Icons.location_pin, color: Colors.black),
                title: Text(
                  '${location['from']} → ${location['to']}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // Remove the saved place using the provider
                    rideDetailsNotifier.removeSavedPlace(index);
                  },
                ),
                onTap: () {
                  // Update the "From" and "To" locations using the provider
                  rideDetailsNotifier.updateFromLocation(location['from']!);
                  rideDetailsNotifier.updateToLocation(location['to']!);
                },
              ),
              const Divider(),
            ],
          );
        } else {
          return ListTile(
            leading: const Icon(Icons.add, color: Colors.black),
            title: const Text(
              'Add Saved Place',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              _showLocationBottomSheet(context, rideDetailsNotifier);
            },
          );
        }
      },
    ),
  );
}

class _DatePickerField extends StatelessWidget {
  final String selectedDate;
  final VoidCallback onTap;

  const _DatePickerField({
    Key? key,
    required this.selectedDate,
    required this.onTap,
  }) : super(key: key);

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

void _showLocationBottomSheet(
    BuildContext context, RideDetailsNotifier notifier) {
  final fromController = TextEditingController();
  final toController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: fromController,
              decoration: const InputDecoration(
                labelText: 'From',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: toController,
              decoration: const InputDecoration(
                labelText: 'To',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final from = fromController.text.trim();
                final to = toController.text.trim();
                if (from.isNotEmpty && to.isNotEmpty) {
                  notifier.addSavedPlace(from, to);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save Place'),
            ),
          ],
        ),
      );
    },
  );
}
