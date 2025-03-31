import 'package:flutter_svg/svg.dart';

import '../../driver_view/screen/saved_places/all_saved_place.dart';
import '../../driver_view/screen/scheduled_ride.dart';
import '../../../theme/app_text_styles.dart';
import '../../../widgets/app_button.dart';
import '../../global_screens/screen_export.dart';
import 'shared_ride.dart';

class AppLayout {
  static AppBar buildAppBar() {
    final userDetails = provider.watch(userProvider);
    return AppBar(
      backgroundColor: AppColors.yellow,
      elevation: 0,
      leading: Builder(
        builder: (context) => InkWell(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: SvgPicture.asset(
            'assets/icons/driver/menu.svg',
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      title: Text(
        'Hi there, ${userDetails?.name}',
        overflow: TextOverflow.ellipsis,
        style: AppTextStyle.bold(
          FontWeight.w500,
          fontSize: FontSize.font24,
        ),
      ),
      actions: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 7.33, vertical: 5.67),
          margin: EdgeInsets.only(right: 20),
          child: Badge.count(count: 2, child: const Icon(Icons.notifications)),
        ),

        // IconButton(
        //   icon: const Icon(Icons.notifications_none, color: Colors.black),
        //   onPressed: () {},
        // ),
      ],
      centerTitle: true,
    );
  }

  static Widget buildWalletBalanceCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.yellow,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SvgPicture.asset('assets/icons/driver/left_pattern.svg'),
          Column(
            children: [
              SizedBox(height: 1.h),
              Center(
                child: Icon(Icons.account_balance_wallet, size: 62),
              ),
              SizedBox(height: 1.h),
              Text(
                '₦15,235',
                style: AppTextStyle.bold(
                  FontWeight.w700,
                  fontSize: 32,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'WALLET BALANCE',
                style: AppTextStyle.bold(
                  FontWeight.w700,
                  fontSize: 12,
                  color: Color(0xFF565656),
                ),
              ),
              SizedBox(height: 15),
              materialButton(
                  buttonBkColor: AppColors.white,
                  onPres: () {},
                  borderRadiusSize: 5,
                  height: 5.h,
                  width: 30.w,
                  widget: Text(
                    'Withdraw',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
              SizedBox(height: 3.h),
            ],
          ),
          SvgPicture.asset('assets/icons/driver/right_pattern.svg'),
        ],
      ),
    );
  }

  static Drawer buildSidebar() {
    return Drawer(child: Consumer(builder: (context, ref, _) {
      provider = ref;
      final userDetails = ref.watch(userProvider);
      return Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.white,
            ),
            accountName: Text(
              '${userDetails?.name}',
              style: TextStyle(
                  color: AppColors.black, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              '+234 ${userDetails?.phoneNumber}',
              style: TextStyle(color: AppColors.black),
            ),
            currentAccountPicture: CircleAvatar(
              child: Image.asset(
                appLogo,
              ),
            ),
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: Icon(
              Icons.payment,
              color: AppColors.black,
              size: 30,
            ),
            title: Text(
              'Trip',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 16,
            ),
            onTap: () {
              popScreen();
              // Navigate to Payment Screen
            },
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: Badge.count(
              count: 2,
              offset: Offset(2, -2),
              child: Icon(
                Icons.notifications_none,
                color: AppColors.black,
                size: 30,
              ),
            ),
            title: Text(
              'Notifications',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 16,
            ),
            onTap: () {
              Navigator.pop(context);
              // Navigate to Notifications Screen
            },
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: Icon(
              Icons.payment,
              color: AppColors.black,
              size: 30,
            ),
            title: Text(
              'Payment',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 16,
            ),
            onTap: () {
              popScreen();
              // Navigate to Payment Screen
            },
          ),
          // For adding of new saved place for the driver
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: Icon(
              Icons.add_location_sharp,
              color: AppColors.black,
              size: 30,
            ),
            title: Text(
              'Add Place', // Find a more intuitive text for this
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 16,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SavedPlacesListScreen(),
                ),
              );
              // Navigator.pop(context);
            },
          ),

          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: Icon(
              Icons.route_outlined,
              color: AppColors.black,
              size: 30,
            ),
            title: Text(
              'Scheduled Ride', // Find a more intuitive text for this
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 16,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScheduleRideScreen(),
                ),
              );
              // Navigator.pop(context);
            },
          ),

          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: Icon(
              Icons.payment,
              color: AppColors.black,
              size: 30,
            ),
            title: Text(
              'Help',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 16,
            ),
            onTap: () {
              popScreen();
              // Navigate to Payment Screen
            },
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: Icon(
              Icons.payment,
              color: AppColors.black,
              size: 30,
            ),
            title: Text(
              'Settings',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 16,
            ),
            onTap: () {
              navigateTo(SettingsScreen());
              // Navigate to Payment Screen
            },
          ),
          const Spacer(),
          ListTile(
            leading: Icon(Icons.logout, color: AppColors.black),
            title: const Text(
              'Log Out',
              style: TextStyle(
                  color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              debugPrint(' Log user Out');
              logUserOut();
            },
          ),
        ],
      );
    }));
  }

  static logUserOut() {
    Pref.setStringValue(tokenKey, '');
    UserModel(
      name: "",
      email: "",
      phoneNumber: "",
      userType: "",
    );

    pushReplacementScreen(OnboardingView());
  }
}
