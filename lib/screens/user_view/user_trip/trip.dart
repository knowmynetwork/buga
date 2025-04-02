import 'package:buga/constant/images.dart';
import 'package:buga/screens/global_screens/setup_bottom_sheet.dart';
import 'package:buga/screens/user_view/user_trip/trip_details.dart';
import 'package:buga/theme/app_colors.dart';
import 'package:buga/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TripView extends StatelessWidget {
  const TripView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: SizedBox(
              width: double.infinity,
              child: Center(
                child: Text('Trips',
                    style: AppTextStyle.bold(
                      FontWeight.w700,
                      fontSize: FontSize.font24,
                    )),
              ),
            ),
          ),
          Flexible(
            flex: 9,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      tabs: [
                        Tab(text: 'Past'),
                        Tab(text: 'Upcoming'),
                      ],
                      labelColor: AppColors.black,
                      indicatorColor: Colors.amber,
                      indicatorWeight: 4.0,
                      unselectedLabelColor: AppColors.black,
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          // Past trips tab
                          ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return buildTripCard(() {
                                SetUpBottomSheet.setUpBottomSheet(
                                    ShowTripDetails());
                              },
                                  'Covenant University',
                                  'Osapa London',
                                  'Sept. 22, 2022',
                                  'First Class',
                                  '1 Passenger');
                            },
                          ),
                          // Upcoming trips tab
                          ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: 15,
                            itemBuilder: (context, index) {
                              return buildTripCard(
                                  () {},
                                  'Covenant University',
                                  'Osapa London',
                                  'Sept. 22, 2022',
                                  'Economy Basic',
                                  'Unmatched');
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget lightButton(String text) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.lightYellow, borderRadius: BorderRadius.circular(3)),
      padding: EdgeInsets.symmetric(horizontal: 1.2.w, vertical: 0.9.h),
      child: Text(
        text,
        style: AppTextStyle.medium(FontWeight.w400, fontSize: FontSize.font10),
      ),
    );
  }

  Widget buildTripCard(
    VoidCallback seeDetails,
    String pickUpDesText,
    dropOffDesText,
    String buttonDetails1,
    buttonDetails2,
    buttonDetails3,
  ) {
    return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AppColors.gray.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  shareRideImg,
                  height: 7.h,
                ),
              ),
            ),
            Flexible(
              flex: 7,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textIcon(),
                          Padding(
                            padding: EdgeInsets.only(left: 0.w),
                            child: CustomPaint(
                              painter: DottedLinePaint(),
                              size: Size(1, 22),
                            ),
                          ),
                          textIcon(),
                        ],
                      ),
                      SizedBox(
                        width: 28.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pickUpDesText,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.medium(FontWeight.w500,
                                  fontSize: FontSize.font12),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              dropOffDesText,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.medium(FontWeight.w500,
                                  fontSize: FontSize.font12),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: seeDetails,
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.yellow,
                              borderRadius: BorderRadius.circular(3)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 0.9.h),
                          child: Text(
                            'See Details',
                            style: AppTextStyle.medium(FontWeight.w500,
                                fontSize: FontSize.font14),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      lightButton(buttonDetails1),
                      lightButton(buttonDetails2),
                      lightButton(buttonDetails3)
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget textIcon() {
    return Text(
      '✓', //or use the code (Unicode U+2713)
      style: TextStyle(
        color: AppColors.green,
        fontSize: 24,
      ),
    );
  }
}

class DottedLinePaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFF00355E)
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    const double dashWidth = 6.0;
    const double dashSpace = 2.0;

    double startY = 0.0;
    while (startY < size.height) {
      canvas.drawLine(
          Offset(0.0, startY), Offset(0.0, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
