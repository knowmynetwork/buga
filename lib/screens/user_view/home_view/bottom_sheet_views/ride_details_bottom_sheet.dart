import 'package:buga/constant/images.dart';
import 'package:buga/viewmodels/user_model/rides_type.dart';
import 'package:flutter_svg/svg.dart';
import 'sheet_export.dart';

class RideDetailsBottomSheet extends ConsumerStatefulWidget {
  final String rideTitle;
  final bool showSubmitButton;
  const RideDetailsBottomSheet(
      {super.key, required this.rideTitle, required this.showSubmitButton});

  @override
  ConsumerState<RideDetailsBottomSheet> createState() =>
      _RideDetailsBottomSheetState();
}

class _RideDetailsBottomSheetState
    extends ConsumerState<RideDetailsBottomSheet> {
  String getRideType = '';
  String getRideMode = '';
  @override
  Widget build(BuildContext context) {
    provider = ref;
    final rideDetails = ref.watch(rideDetailsProvider);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with close button:
          Row(
            children: [
              Expanded(
                  flex: 6,
                  child: Container(
                    alignment: Alignment.centerRight,
                    width: 100.w,
                    child: Text(
                      widget.rideTitle,
                      style: AppTextStyle.medium(FontWeight.w500,
                          fontSize: FontSize.font20),
                    ),
                  )),
              Expanded(
                  flex: 3,
                  child: Container(
                    width: 100.w,
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => popScreen(),
                    ),
                  ))
            ],
          ),
          SizedBox(height: 2.h),
          // Ride option cards:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildOptionCard(shareRideImg, 'Saloon Car', '2 riders',
                  isSelected: rideDetails.rideOption == 'Saloon Car',
                  onTap: () {
                setState(() {
                  getRideMode = 'Saloon Car';
                  getRideType = widget.rideTitle;
                  debugPrint('type Saloon Car');
                  ref.read(StoreRideType.rideTypeProvider.notifier).state =
                      StoreRideType(
                    rideType: getRideType,
                    rideMode: getRideMode,
                  );
                });
                ref
                    .read(rideDetailsProvider.notifier)
                    .updateRideOption('Saloon Car');
              }),
              _buildOptionCard(interStateImg, 'SUV/Minibus', '2+ riders',
                  isSelected: rideDetails.rideOption == 'SUV/Minibus',
                  onTap: () {
                setState(() {
                  getRideMode = 'SUV/Minibus';
                  getRideType = widget.rideTitle;
                  debugPrint('type SUV/Minibus');
                  ref.read(StoreRideType.rideTypeProvider.notifier).state =
                      StoreRideType(
                    rideType: getRideType,
                    rideMode: getRideMode,
                  );
                });
                ref
                    .read(rideDetailsProvider.notifier)
                    .updateRideOption('SUV/Minibus');
              }),
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
          Visibility(
            visible: widget.showSubmitButton,
            child: materialButton(
              buttonBkColor: AppColors.yellow,
              onPres: () async {
                await ref
                    .read(rideDetailsProvider.notifier)
                    .submitRideDetailsAndGetMoreRideDetails();
                // update the model
                ref.read(StoreRideType.rideTypeProvider.notifier).state =
                    StoreRideType(
                  rideType: getRideType,
                  rideMode: getRideMode,
                );
                navigateTo(SharedRideScreen(
                  rideType: "Rider",
                ));
              },
              height: 7.h,
              width: double.infinity,
              borderRadiusSize: 5,
              widget: Text('Proceed'),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOptionCard(String img, String title, String subtitle,
      {bool isSelected = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.yellow : AppColors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              child: Transform.scale(
                scaleX: -1, // Flip horizontally
                child: SvgPicture.asset(
                  img,
                  height: 9.h,
                ),
              ),
            ),
            Text(
              title,
              style: AppTextStyle.medium(FontWeight.w500,
                  color: isSelected ? AppColors.yellow : AppColors.black,
                  fontSize: FontSize.font16),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: AppTextStyle.light(FontWeight.w500,
                  color: isSelected ? AppColors.yellow : AppColors.white,
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
