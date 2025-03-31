import 'widgets/documents_status.dart';
import 'widgets/operation_period.dart';
import 'widgets/scheduledPickupTile.dart';
import '../../../global_screens/setup_bottom_sheet.dart';
import '../../../user_view/home_view/home_export.dart';

class DriverHomeScreen extends ConsumerStatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  ConsumerState<DriverHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<DriverHomeScreen> {
  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  getUserDetails() async {
    debugPrint('get user details');
    final getUserTypeKey = await Pref.getStringValue(userTypeKey);
    final getUserPhoneNumberKey = await Pref.getStringValue(userPhoneNumberKey);
    final getUserNameKey = await Pref.getStringValue(userNameKey);
    final getUserMailKey = await Pref.getStringValue(userMailKey);

    // update the UserNotifier inside here
    ref.read(userProvider.notifier).setUserDetails(
          name: getUserNameKey,
          email: getUserMailKey,
          phoneNumber: getUserPhoneNumberKey,
          userType: getUserTypeKey,
        );
  }

  @override
  Widget build(BuildContext context) {
    provider = ref;
    final List<Map<String, String>> pickups = [
      {
        "title": "Covenant University",
        "subtitle": "Canaan Land, Ota",
        "time": "12:00 noon - 12:30pm",
        "price": "₦15,000"
      },
      {
        "title": "46, Ogundiran Street",
        "subtitle": "Ikeja, Lagos",
        "time": "2pm - 2:30pm",
        "price": "₦10,500"
      },
    ];

    final List<Map<String, String>> operationPeriods = [
      {
        "title": "Covenant University Vacation",
        "date": "February 22, 2023",
        "imageUrl": "assets/images/driver/convenant_uni.png",
      },
      {
        "title": "Babcock University Break",
        "date": "February 28, 2023",
        "imageUrl": "assets/images/driver/convenant_uni.png",
      },
    ];

    return Container(
      color: AppColors.white,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          AppLayout.buildWalletBalanceCard(),
          // _buildTabs(),
          // _buildRideOptions(),
          SizedBox(height: 2.h),
          DocumentStatusCard(
            title: "Document Submission pending",
            subtitle:
                "Kindly submit all required documents to get verified and start earning.",
          ),
          SizedBox(height: 1.5.h),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Scheduled Pickups",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Satoshi-Bold',
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "See all",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Satoshi-Bold',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(width: 0.5.w),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 1.h),

          Expanded(
            flex: 3,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: pickups.length,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (context, index) {
                return ScheduledPickupTile(
                  title: pickups[index]["title"]!,
                  subtitle: pickups[index]["subtitle"]!,
                  time: pickups[index]["time"]!,
                  price: pickups[index]["price"]!,
                );
              },
            ),
          ),
          SizedBox(height: 3.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Upcoming Operation Periods",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Satoshi-Bold',
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "See all",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Satoshi-Bold',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(width: 0.5.w),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 1.h),

          Expanded(
            flex: 4,
            // height: 196,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: operationPeriods.length,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (context, index) {
                return OperationPeriodTile(
                  title: operationPeriods[index]["title"]!,
                  date: operationPeriods[index]["date"]!,
                  imageUrl: operationPeriods[index]["imageUrl"]!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  bool isBoxTap = true;
  // Widget _buildTabs() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: [
  //         tabSelectedBox(() {
  //           setState(() {
  //             isBoxTap = true;
  //           });
  //         }, isBoxTap ? AppColors.yellow : AppColors.white, 'Order Now'),
  //         tabSelectedBox(() {
  //           setState(() {
  //             isBoxTap = false;
  //           });
  //         }, isBoxTap ? AppColors.white : AppColors.yellow, 'Schedule Trip')
  //       ],
  //     ),
  //   );
  // }

  Widget tabSelectedBox(VoidCallback userTap, Color borderColor, String text) {
    return GestureDetector(
      onTap: userTap,
      child: Container(
        width: 40.w,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: borderColor,
              width: 2.0,
            ),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style:
                AppTextStyle.medium(FontWeight.w400, fontSize: FontSize.font20),
          ),
        ),
      ),
    );
  }

  // Widget _buildRideOptions() {
  //   return Expanded(
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'Ready To Move?',
  //             style:
  //                 AppTextStyle.bold(FontWeight.w700, fontSize: FontSize.font16),
  //           ),
  //           Text(
  //             'Select your ride',
  //             style: AppTextStyle.light(FontWeight.w500,
  //                 fontSize: FontSize.font14, color: AppColors.gray),
  //           ),
  //           const SizedBox(height: 12),
  //           Expanded(
  //             child: GridView.count(
  //               crossAxisCount: 2,
  //               crossAxisSpacing: 12,
  //               mainAxisSpacing: 12,
  //               children: [
  //                 _RideOptionCard(
  //                   title: 'Solo Ride',
  //                   subtitle: 'Single Rider',
  //                   icon: Icons.directions_car,
  //                   onTap: () => _showRideDetailsBottomSheet('Solo Ride'),
  //                 ),
  //                 _RideOptionCard(
  //                   title: 'Share A Ride',
  //                   subtitle: 'Shared Ride',
  //                   icon: Icons.car_rental,
  //                   onTap: () => Navigator.push(
  //                       context,
  //                       navigateTo(
  //                         SharedRideScreen(
  //                           rideType: 'Share A Ride',
  //                         ),
  //                       )),
  //                 ),
  //                 _RideOptionCard(
  //                   title: 'Airport Shuttle',
  //                   subtitle: '20 Seater Bus',
  //                   icon: Icons.airport_shuttle,
  //                   onTap: () => ('Airport Shuttle'),
  //                 ),
  //                 _RideOptionCard(
  //                   title: 'Intra-School',
  //                   subtitle: 'Electric Tricycle',
  //                   icon: Icons.electric_bike,
  //                   onTap: () => ('Intra-School'),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

// class _RideOptionCard extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final IconData icon;
//   final VoidCallback onTap;

//   const _RideOptionCard({
//     required this.title,
//     required this.subtitle,
//     required this.icon,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         elevation: 2,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(icon, size: 50, color: AppColors.black),
//               const SizedBox(height: 12),
//               Text(
//                 title,
//                 style: AppTextStyle.medium(FontWeight.w500,
//                     fontSize: FontSize.font16),
//                 textAlign: TextAlign.center,
//               ),
//               Text(
//                 subtitle,
//                 style: AppTextStyle.light(FontWeight.w500,
//                     fontSize: FontSize.font14, color: AppColors.gray),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
