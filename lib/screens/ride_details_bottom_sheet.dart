import 'package:buga/Provider/ride_details_provider.dart';
import 'package:buga/screens/onboarding_driver_view/screen/shared_ride.dart';
import 'package:buga/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RideDetailsBottomSheet extends ConsumerWidget {
  final String rideTitle;
  final bool showSubmitButton;
  const RideDetailsBottomSheet(
      {super.key, required this.rideTitle, required this.showSubmitButton});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rideDetails = ref.watch(rideDetailsProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with close button:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                rideTitle,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          // Ride option cards:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildOptionCard(
                'Saloon Car',
                '2 riders',
                isSelected: rideDetails.rideOption == 'Saloon Car',
                onTap: () => ref
                    .read(rideDetailsProvider.notifier)
                    .updateRideOption('Saloon Car'),
              ),
              _buildOptionCard(
                'SUV/Minibus',
                '2+ riders',
                isSelected: rideDetails.rideOption == 'SUV/Minibus',
                onTap: () => ref
                    .read(rideDetailsProvider.notifier)
                    .updateRideOption('SUV/Minibus'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Counter rows for riders and luggage:
          _buildCounterRow('Total No of Riders', rideDetails.riders, max: 2,
              onChanged: (value) {
            ref.read(rideDetailsProvider.notifier).updateRiders(value);
          }),
          const SizedBox(height: 12),
          _buildCounterRow('Total Luggage Number', rideDetails.luggage, max: 4,
              onChanged: (value) {
            ref.read(rideDetailsProvider.notifier).updateLuggage(value);
          }),
          const SizedBox(height: 16),
          // Proceed button:
          Visibility(
            visible: showSubmitButton,
            child: ElevatedButton(
              onPressed: () async {
                await ref
                    .read(rideDetailsProvider.notifier)
                    .submitRideDetails();
                // Replace navigateTo with your navigation logic:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SharedRideScreen(
                              rideType: "Rider",
                            )));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lightYellow,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Center(child: Text('Proceed')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard(String title, String subtitle,
      {bool isSelected = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.lightYellow : AppColors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? AppColors.lightYellow : AppColors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? AppColors.lightYellow : AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterRow(String label, int value,
      {required int max, required ValueChanged<int> onChanged}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            IconButton(
              onPressed: value > 0 ? () => onChanged(value - 1) : null,
              icon: const Icon(Icons.remove_circle_outline),
            ),
            Text(value.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold)),
            IconButton(
              onPressed: value < max ? () => onChanged(value + 1) : null,
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
      ],
    );
  }
}
