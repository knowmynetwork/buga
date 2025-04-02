import 'package:buga/constant/images.dart';
import 'package:buga/route/navigation.dart';
import 'package:buga/screens/user_view/user_trip/trip.dart';
import 'package:buga/theme/app_colors.dart';
import 'package:buga/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ShowTripDetails extends StatelessWidget {
  const ShowTripDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.white,
      child: Column(
        children: [
          SizedBox(
            height: 5.h,
          ),
          Flexible(
            flex: 2,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      popScreen();
                    },
                    icon: Icon(Icons.arrow_back)),
                SizedBox(width: 20.w),
                Text('Trip Details',
                    style: AppTextStyle.bold(
                      FontWeight.w700,
                      fontSize: FontSize.font24,
                    )),
              ],
            ),
          ),
          Flexible(
              flex: 8,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                children: [
                  SizedBox(width: 10.h),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColors.lightYellow,
                        borderRadius: BorderRadius.circular(3)),
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Shared-Split',
                            style: AppTextStyle.bold(
                              FontWeight.w700,
                              fontSize: FontSize.font18,
                            )),
                        SizedBox(height: 2.h),
                        addressDetails(),
                        Divider(),
                        SizedBox(height: 2.h),
                        billAmountText()
                      ],
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Center(
                    child: Text('Date, Time',
                        style: AppTextStyle.medium(
                          FontWeight.w500,
                          fontSize: FontSize.font14,
                        )),
                  ),
                  SizedBox(height: 1.h),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.yellow,
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.symmetric(
                          horizontal: 3.w, vertical: 0.9.h),
                      child: Text(
                        'Mon 22 Feb, 3:00 PM',
                        style: AppTextStyle.medium(FontWeight.w700,
                            fontSize: FontSize.font13),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  RideDetailsScreen()
                ],
              )),
        ],
      ),
    );
  }

  Widget billAmountText() {
    return Column(
      children: [
        costPriceRow(
            'Total Cost',
            '₦12000',
            AppTextStyle.medium(
              FontWeight.w500,
              fontSize: FontSize.font14,
            )),
        SizedBox(height: 1.h),
        costPriceRow(
            'Split Bill',
            '- ₦8000',
            AppTextStyle.medium(
              FontWeight.w500,
              fontSize: FontSize.font14,
            )),
        SizedBox(height: 1.h),
        costPriceRow(
            'Grand Total  ',
            '₦4000',
            AppTextStyle.bold(
              FontWeight.w500,
              fontSize: FontSize.font14,
            ))
      ],
    );
  }

  Widget addressDetails() {
    TextStyle style =
        AppTextStyle.medium(FontWeight.w500, fontSize: FontSize.font12);
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.my_location_sharp,
            ),
            Padding(
              padding: EdgeInsets.only(left: 0.w),
              child: CustomPaint(
                painter: DottedLinePaint(),
                size: Size(1, 22),
              ),
            ),
            Icon(
              Icons.my_location_sharp,
            ),
            Padding(
              padding: EdgeInsets.only(left: 0.w),
              child: CustomPaint(
                painter: DottedLinePaint(),
                size: Size(1, 22),
              ),
            ),
            Icon(
              Icons.my_location_sharp,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Covenant University",
              overflow: TextOverflow.ellipsis,
              style: style,
            ),
            SizedBox(height: 4.h),
            Text(
              "46, Ogundiran street, Agege, Lagos",
              overflow: TextOverflow.ellipsis,
              style: style,
            ),
            SizedBox(height: 4.h),
            Text(
              "Plot 2, Osapa London, Lekki, Lagos",
              overflow: TextOverflow.ellipsis,
              style: style,
            ),
          ],
        )
      ],
    );
  }

  Widget costPriceRow(String text1, amountText, TextStyle textStyle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text1,
            style: AppTextStyle.medium(
              FontWeight.w500,
              fontSize: FontSize.font14,
            )),
        Text(
          amountText,
          style: textStyle,
        ),
      ],
    );
  }
}

class RideDetailsScreen extends StatefulWidget {
  const RideDetailsScreen({Key? key}) : super(key: key);

  @override
  State<RideDetailsScreen> createState() => _RideDetailsScreenState();
}

class _RideDetailsScreenState extends State<RideDetailsScreen> {
  // Variables to track expanded state
  bool isDriverDetailsExpanded = false;
  bool isRiderDetailsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              // Driver Details Dropdown
              DetailsDropdown(
                title: 'Driver Details',
                isExpanded: isDriverDetailsExpanded,
                onTap: () {
                  setState(() {
                    isDriverDetailsExpanded = !isDriverDetailsExpanded;
                  });
                },
                content: isDriverDetailsExpanded
                    ? const DriverDetailsContent()
                    : null,
              ),

              const SizedBox(height: 16),

              // Rider Details Dropdown
              DetailsDropdown(
                title: 'Rider Details',
                isExpanded: isRiderDetailsExpanded,
                onTap: () {
                  setState(() {
                    isRiderDetailsExpanded = !isRiderDetailsExpanded;
                  });
                },
                content:
                    isRiderDetailsExpanded ? const RiderDetailsContent() : null,
                badgeText: 'Matched',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DetailsDropdown extends StatelessWidget {
  final String title;
  final bool isExpanded;
  final VoidCallback onTap;
  final Widget? content;
  final String? badgeText;

  const DetailsDropdown({
    Key? key,
    required this.title,
    required this.isExpanded,
    required this.onTap,
    this.content,
    this.badgeText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      if (badgeText != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0,
                          ),
                          margin: const EdgeInsets.only(right: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            badgeText!,
                            style: TextStyle(
                              color: Colors.green[800],
                              fontSize: 12,
                            ),
                          ),
                        ),
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Expandable content
          if (isExpanded && content != null) content!,
        ],
      ),
    );
  }
}

class DriverDetailsContent extends StatelessWidget {
  const DriverDetailsContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.gray, width: 0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Driver profile image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SvgPicture.asset(
                  shareRideImg,
                  height: 5.h,
                ),
              ),
              const SizedBox(width: 16),
              // Driver details
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow('Name', 'Oreoluwa Okunade'),
                    SizedBox(height: 1.5.h),
                    _buildDetailRow('Phone Number', '09020065170'),
                    SizedBox(height: 1.5.h),
                    _buildDetailRow(
                        'Car Brand (Colour)', 'Toyota Camry (Blue)'),
                    SizedBox(height: 1.5.h),
                    _buildDetailRow('Plate Number', '97 GGG 28'),
                    SizedBox(width: 3.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildActionButton(Icons.message),
                        SizedBox(width: 5.w),
                        _buildActionButton(Icons.call),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: AppTextStyle.medium(FontWeight.w500,
                fontSize: FontSize.font12, color: AppColors.gray),
          ),
        ),
        Flexible(
          child: Text(
            value,
            style:
                AppTextStyle.medium(FontWeight.w500, fontSize: FontSize.font14),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightYellow,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
      ),
    );
  }
}

class RiderDetailsContent extends StatelessWidget {
  const RiderDetailsContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.gray, width: 0.3),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rider information will appear here',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
