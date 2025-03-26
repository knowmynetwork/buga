import 'sheet_export.dart';


// ignore: must_be_immutable
class InputPriceView extends ConsumerWidget {
  InputPriceView({super.key});

  TextEditingController yourOwnPriceController = TextEditingController();
  TextEditingController messageToDriversController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    provider = ref;
    final rideDetails = ref.watch(rideDetailsProvider);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
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
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    decoration: BoxDecoration(
                        color: AppColors.lightYellow,
                        borderRadius: BorderRadius.circular(8)),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Recommended Price Range',
                          style: AppTextStyle.bold(
                            FontWeight.w500,
                            fontSize: FontSize.font16,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          rideDetails.estimatedPrice,
                          style: AppTextStyle.bold(FontWeight.w500,
                              fontSize: FontSize.font20,
                              color: AppColors.green),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          rideDetails.rideOption,
                          style: AppTextStyle.medium(FontWeight.w500,
                              fontSize: FontSize.font14),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Est. Travel Time: ${rideDetails.estimatedTravelTime}',
                    style: AppTextStyle.medium(FontWeight.w500,
                        fontSize: FontSize.font14),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
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
            SizedBox(height: 1.h),
            PriceFormField(
              icon: Icons.chat_bubble_outline,
              placeholder: 'Any comments for the driver?',
              controller: messageToDriversController,
              onChanged: (value) {
                ref
                    .read(rideDetailsProvider.notifier)
                    .updateMessageToDrivers(value);
              },
            ),
            const SizedBox(height: 20),
            // Find Driver Button
            materialButton(
              buttonBkColor: AppColors.yellow,
              onPres: () async {
                final rideDetailsNotifier =
                    ref.read(rideDetailsProvider.notifier);

                await rideDetailsNotifier.submitRideDetailsAndFindDriver();
              },
              height: 7.h,
              width: double.infinity,
              borderRadiusSize: 5,
              widget: Text(
                'Find Driver',
                style: AppTextStyle.medium(FontWeight.w500,
                    fontSize: FontSize.font16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
