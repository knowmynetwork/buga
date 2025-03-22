import 'package:buga/screens/global_screens/ride_form_field.dart';
import 'package:buga/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:buga/Provider/ride_details_provider.dart';

class RideDetailsScreen extends ConsumerWidget {
  const RideDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rideDetails = ref.watch(rideDetailsProvider);
    final yourOwnPriceController = TextEditingController();
    final messageToDriversController = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          // Map Placeholder
          Positioned.fill(
            child: Container(
              color: Colors.grey[200], // Replace with a map widget later
              child: const Center(
                child: Text(
                  'Map Placeholder',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          // Back Button
          Positioned(
            top: 50,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          // Map Markers
          Positioned(
            top: 120,
            left: 80,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.pin_drop, color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  rideDetails.fromLocation,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // Address Pin
          Positioned(
            bottom: 180,
            right: 60,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Text(
                rideDetails.toLocation,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          // Bottom Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recommended Price Range
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          'Recommended Price Range',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          rideDetails.estimatedPrice,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          rideDetails.rideOption,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Est. Travel Time: ${rideDetails.estimatedTravelTime}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  PriceFormField(
                    icon: Icons.money,
                    placeholder: "What's your price?",
                    controller: yourOwnPriceController,
                    onChanged: (value) {
                      ref
                          .read(rideDetailsProvider.notifier)
                          .updateYourOwnPrice(value);
                    },
                  ),
                  const SizedBox(height: 12),
                  RideFormField(
                    label: '',
                    icon: Icons.circle_outlined,
                    placeholder: 'Any comments for the driver?',
                    isEditable: true,
                    onChanged: (value) {
                      ref
                          .read(rideDetailsProvider.notifier)
                          .updateMessageToDrivers(value);
                    },
                  ),
                  const SizedBox(height: 20),
                  // Find Driver Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final rideDetailsNotifier =
                            ref.read(rideDetailsProvider.notifier);
                        rideDetailsNotifier.state =
                            rideDetailsNotifier.state.copyWith(
                          yourOwnPrice: yourOwnPriceController.text,
                          messageToDrivers: messageToDriversController.text,
                        );
                        await rideDetailsNotifier.submitRideRequest();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFD700),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Find Driver',
                        style: AppTextStyle.bold(
                          FontWeight.w500,
                          fontSize: FontSize.font16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
