import 'package:buga/Provider/ride_details_provider.dart';
import 'package:buga/route/navigation.dart';
import 'package:buga/screens/onboarding_driver_view/screen/shared_ride.dart';
import 'package:buga/theme/app_colors.dart';
import 'package:buga/theme/app_text_styles.dart';
import 'package:buga/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RideDetailsBottomSheet extends ConsumerWidget {
  final String rideTitle;
  const RideDetailsBottomSheet({super.key, required this.rideTitle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rideDetails = ref.watch(rideDetailsProvider);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with close button:
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 31.w),
                child: Text(
                  rideTitle,
                  style: AppTextStyle.medium(FontWeight.w500,
                      fontSize: FontSize.font20),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 1.w, left: 19.w),
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => popScreen(),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          // Ride option cards:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildOptionCard(
                Icons.directions_car,
                'Saloon Car',
                '2 riders',
                isSelected: rideDetails.rideOption == 'Saloon Car',
                onTap: () => ref
                    .read(rideDetailsProvider.notifier)
                    .updateRideOption('Saloon Car'),
              ),
              _buildOptionCard(
                Icons.car_rental,
                'SUV/Minibus',
                '2+ riders',
                isSelected: rideDetails.rideOption == 'SUV/Minibus',
                onTap: () => ref
                    .read(rideDetailsProvider.notifier)
                    .updateRideOption('SUV/Minibus'),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          // Counter rows for riders and luggage:
          _buildCounterRow('Total No of Riders', rideDetails.riders, max: 2,
              onChanged: (value) {
            ref.read(rideDetailsProvider.notifier).updateRiders(value);
          }),
          Text('Maz 2'),
          SizedBox(height: 2.h),
          _buildCounterRow('Total Luggage Number', rideDetails.luggage, max: 4,
              onChanged: (value) {
            ref.read(rideDetailsProvider.notifier).updateLuggage(value);
          }),
          Text('Maz 4'),
          SizedBox(height: 4.h),
          // Proceed button:
          materialButton(
            buttonBkColor: AppColors.lightYellow,
            onPres: () {
              navigateTo(SharedRideScreen(
                rideType: "Rider",
              ));
            },
            height: 7.h,
            width: double.infinity,
            borderRadiusSize: 5,
            widget: Text('Proceed'),
          )
        ],
      ),
    );
  }

  Widget _buildOptionCard(IconData icon, String title, String subtitle,
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
            Icon(icon, size: 50),
            Text(
              title,
              style: AppTextStyle.medium(FontWeight.w500,
                  color: isSelected ? AppColors.lightYellow : AppColors.black,
                  fontSize: FontSize.font16),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: AppTextStyle.light(FontWeight.w500,
                  color: isSelected ? AppColors.lightYellow : AppColors.white,
                  fontSize: FontSize.font13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterRow(String label, int value,
      {required int max, required ValueChanged<int> onChanged}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: AppTextStyle.bold(FontWeight.w500, fontSize: FontSize.font16),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: value > 0 ? () => onChanged(value - 1) : null,
              icon: const Icon(
                Icons.remove_circle_outline,
                size: 26,
              ),
            ),
            SizedBox(width: 1.w),
            Text(
              value.toString(),
              style:
                  AppTextStyle.bold(FontWeight.w500, fontSize: FontSize.font16),
            ),
            SizedBox(width: 1.w),
            IconButton(
              onPressed: value < max ? () => onChanged(value + 1) : null,
              icon: const Icon(
                Icons.add_circle_outline,
                size: 26,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
