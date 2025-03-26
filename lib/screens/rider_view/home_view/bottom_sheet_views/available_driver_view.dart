import 'package:buga/screens/global_screens/setup_bottom_sheet.dart';

import 'share_bill_sheet.dart';
import 'sheet_export.dart';

class AvailableDriverView extends ConsumerStatefulWidget {
  const AvailableDriverView({super.key});

  @override
  ConsumerState<AvailableDriverView> createState() =>
      _AvailableDriverViewState();
}

class _AvailableDriverViewState extends ConsumerState<AvailableDriverView> {
  @override
  Widget build(BuildContext context) {
    provider = ref;
    return SizedBox(
      width: double.infinity,
      height: 80.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) {
            return Container(
              // color: Colors.red,
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                          flex: 2,
                          child: SizedBox(
                              width: double.infinity,
                              child: Container(
                                width: 30.w,
                                height: 7.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[300],
                                ),
                                child: Placeholder(),
                              ))),
                      Flexible(
                          flex: 5,
                          child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(left: 5.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Adekoya Taiwo',
                                    style: AppTextStyle.bold(FontWeight.w700,
                                        fontSize: FontSize.font14),
                                  ),
                                  Text(
                                    'Toyota Camry',
                                    style: AppTextStyle.bold(FontWeight.w500,
                                        fontSize: FontSize.font12,
                                        color: AppColors.lightGray),
                                  ),
                                ],
                              ))),
                      Flexible(
                          flex: 3,
                          child: Container(
                              width: double.infinity,
                              alignment: Alignment.centerRight,
                              child: Column(
                                children: [
                                  Text(
                                    '₦17000',
                                    style: AppTextStyle.bold(FontWeight.w900,
                                        fontSize: FontSize.font16),
                                  ),
                                  Text(
                                    '8 mins away',
                                    style: AppTextStyle.light(FontWeight.w700,
                                        fontSize: FontSize.font12),
                                  ),
                                ],
                              )))
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      outlineButton(
                        child: Text(
                          'View Details',
                          style: AppTextStyle.medium(FontWeight.w500,
                              fontSize: FontSize.font16),
                        ),
                        onPressed: () {},
                        borderColor: AppColors.yellow,
                        borderRadiusSize: 5,
                        height: 6.h,
                        width: 40.w,
                      ),
                      materialButton(
                        buttonBkColor: AppColors.yellow,
                        onPres: () async {
                          SetUpBottomSheet.setUpBottomSheet(ShareBillView());
                        },
                        height: 6.h,
                        width: 40.w,
                        borderRadiusSize: 5,
                        widget: Text(
                          'Accept',
                          style: AppTextStyle.medium(FontWeight.w500,
                              fontSize: FontSize.font16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Divider(),
                  SizedBox(height: 2.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
