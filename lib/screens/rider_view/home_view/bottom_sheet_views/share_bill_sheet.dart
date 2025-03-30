import 'package:buga/constant/global_variable.dart';
import 'package:buga/route/navigation.dart';
import 'package:buga/theme/app_colors.dart';
import 'package:buga/theme/app_text_styles.dart';
import 'package:buga/viewmodels/ridermodel/rides_type.dart';
import 'package:buga/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ShareBillView extends ConsumerWidget {
  const ShareBillView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    provider = ref;
    final rideData = ref.watch(StoreRideType.rideTypeProvider);

    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 4.h),
          Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            child: IconButton(
                onPressed: () {
                  // close the bottom sheet
                  popScreen();
                },
                icon: Icon(Icons.arrow_back_rounded)),
          ),
          Icon(
            Icons.directions_car,
            size: 33.w,
          ),
          Text(
            rideData.rideType,
            style:
                AppTextStyle.bold(FontWeight.w700, fontSize: FontSize.font18),
          ),
          Text(
            rideData.rideMode,
            style: AppTextStyle.medium(FontWeight.w500,
                fontSize: FontSize.font16, color: AppColors.gray),
          ),
          SizedBox(height: 4.h),
          Text(
            "Total Cash Due",
            style: AppTextStyle.medium(
              FontWeight.w700,
              fontSize: FontSize.font18,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            "₦12000",
            style: AppTextStyle.bold(
              FontWeight.w900,
              fontSize: FontSize.font20,
            ),
          ),
          SizedBox(height: 3.h),
          topUpView(),
          SizedBox(height: 6.h),
          materialButton(
            buttonBkColor: AppColors.yellow,
            onPres: () async {},
            height: 7.h,
            width: double.infinity,
            borderRadiusSize: 5,
            widget: Text('Share'),
          ),
        ],
      ),
    );
  }

  Widget topUpView() {
    return Container(
      color: AppColors.lightGray1.withOpacity(0.5),
      height: 10.h,
      child: Row(
        children: [
          Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                child: Icon(
                  Icons.account_balance_wallet,
                  size: 34,
                ),
              )),
          Flexible(
              flex: 5,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('15,500'), Text('Wallet Balance')],
                ),
              )),
          Flexible(
              flex: 3,
              child: Container(
                width: double.infinity,
                height: 5.h,
                decoration: BoxDecoration(
                    color: AppColors.yellow,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Text('Top up'), Icon(Icons.add_circle_outlined)],
                ),
              )),
        ],
      ),
    );
  }
}
