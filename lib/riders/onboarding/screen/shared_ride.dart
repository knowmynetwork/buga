

// The main SharedRideScreen widget using BugaFormFieldAutocomple for suggestions.
import 'package:intl/intl.dart';

import 'export.dart';

class SharedRideScreen extends ConsumerWidget {
  final String rideType;
  const SharedRideScreen({super.key, required this.rideType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    provider = ref;
    final rideDetails = ref.watch(rideDetailsProvider);
    final rideDetailsNotifier = ref.read(rideDetailsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.yellow,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () {
            popScreen();
          },
        ),
        title: Text(
          'Shared Ride',
          style: AppTextStyle.bold(FontWeight.w500, fontSize: FontSize.font20),
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
                // Tab Section:
                Visibility(
                  visible: false,
                  child: Container(
                    color: AppColors.yellow,
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
                SizedBox(height: 3.h),
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
                SizedBox(height: 2.h),
                // GestureDetector around Passenger and Luggage Info to dismiss the keyboard on tap.
                PassengerAndLuggageInfo(rideDetails: rideDetails),
                SizedBox(height: 2.h),
                // Proceed Button at the bottom.
                materialButton(
                  buttonBkColor: AppColors.yellow,
                  onPres: () async {
                    await rideDetailsNotifier
                        .submitRideDetailsAndGetMoreRideDetails();
                    navigateTo(RideDetailsScreen());
                  },
                  height: 7.h,
                  width: double.infinity,
                  borderRadiusSize: 5,
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Proceed',
                        style: AppTextStyle.medium(FontWeight.w500,
                            fontSize: FontSize.font16),
                      ),
                      SizedBox(width: 1.w),
                      Icon(
                        Icons.arrow_forward,
                      ),
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
      {required this.selectedDate, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(Icons.calendar_today, size: 20, color: AppColors.black),
          const SizedBox(width: 8),
          Text(
            selectedDate.isEmpty ? 'When' : selectedDate,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: selectedDate.isEmpty ? AppColors.gray : AppColors.black,
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
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.black : AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.white : AppColors.black,
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
        backgroundColor: AppColors.white,
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
              const Icon(Icons.person, size: 20), // Passenger Icon
              SizedBox(width: 1.w),
              Text(
                '${rideDetails.riders} Passengers',
                style: AppTextStyle.bold(FontWeight.w500,
                    fontSize: FontSize.font16),
              ),
            ],
          ),
          const SizedBox(width: 16),

          // Luggage Icon and Text
          Row(
            children: [
              const Icon(Icons.luggage, size: 20), // Luggage Icon
              SizedBox(width: 1.w),
              Text('${rideDetails.luggage} Luggage',
                  style: AppTextStyle.bold(FontWeight.w500,
                      fontSize: FontSize.font16)),
            ],
          ),
          const SizedBox(width: 16),
          // Edit Icon
          const Icon(
            Icons.edit,
            size: 20,
          ), // Edit Icon
        ],
      ),
    );
  }
}
