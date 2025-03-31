import 'package:buga/constant/images.dart';
import 'package:flutter_svg/svg.dart';

import '../../global_screens/setup_bottom_sheet.dart';
import 'home_export.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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

    return Container(
      color: AppColors.white,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          AppLayout.buildWalletBalanceCard(),
          _buildTabs(),
          _buildRideOptions(),
        ],
      ),
    );
  }

  bool isBoxTap = true;
  Widget _buildTabs() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          tabSelectedBox(() {
            setState(() {
              isBoxTap = true;
            });
          }, isBoxTap ? AppColors.yellow : AppColors.white, 'Order Now'),
          tabSelectedBox(() {
            setState(() {
              isBoxTap = false;
            });
          }, isBoxTap ? AppColors.white : AppColors.yellow, 'Schedule Trip')
        ],
      ),
    );
  }

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

  Widget _buildRideOptions() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ready To Move?',
              style:
                  AppTextStyle.bold(FontWeight.w700, fontSize: FontSize.font16),
            ),
            Text(
              'Select your ride',
              style: AppTextStyle.light(FontWeight.w500,
                  fontSize: FontSize.font14, color: AppColors.gray),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _RideOptionCard(
                    title: 'Solo Ride',
                    subtitle: 'Single Rider',
                    img: soloRideImg,
                    onTap: () => SetUpBottomSheet.setUpBottomSheet(
                        RideDetailsBottomSheet(
                      rideTitle: 'Solo Ride',
                      showSubmitButton: true,
                    )),
                  ),
                  _RideOptionCard(
                    title: 'Share A Ride',
                    subtitle: 'Shared Ride',
                    img: shareRideImg,
                    onTap: () => navigateTo(
                      SharedRideScreen(
                        rideType: 'Share A Ride',
                      ),
                    ),
                  ),
                  _RideOptionCard(
                    title: 'Airport Shuttle',
                    subtitle: '20 Seater Bus',
                    img: interStateImg,
                    onTap: () => ('Airport Shuttle'),
                  ),
                  _RideOptionCard(
                    title: 'Intra-School',
                    subtitle: 'Electric Tricycle',
                    img: electricImg,
                    onTap: () => ('Intra-School'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RideOptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String img;
  final VoidCallback onTap;

  const _RideOptionCard({
    required this.title,
    required this.subtitle,
    required this.img,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                img,
                height: 9.h,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: AppTextStyle.medium(FontWeight.w500,
                    fontSize: FontSize.font16),
                textAlign: TextAlign.center,
              ),
              Text(
                subtitle,
                style: AppTextStyle.light(FontWeight.w500,
                    fontSize: FontSize.font14, color: AppColors.gray),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
