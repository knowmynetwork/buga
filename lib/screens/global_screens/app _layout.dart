import '../driver_view/screen/notification/notification_screen.dart';
import '../driver_view/screen/saved_places/all_saved_place.dart';
import '../driver_view/screen/scheduled_ride.dart';
import '../driver_view/screen/trips/trips.dart';
import 'screen_export.dart';

class AppLayout {
  static AppBar buildAppBar() {
    final userDetails = provider.watch(userProvider);
    return AppBar(
      backgroundColor: AppColors.yellow,
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu, color: AppColors.black),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
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
        IconButton(
          icon: Icon(Icons.notifications_none, color: AppColors.black),
          onPressed: () {},
        ),
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
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 1.h),
          const Center(
            child: Icon(Icons.account_balance_wallet, size: 60),
          ),
          SizedBox(height: 1.h),
          Text(
            '\u20A615,235',
            style:
                AppTextStyle.bold(FontWeight.w400, fontSize: FontSize.font30),
          ),
          SizedBox(height: 1.h),
          Text(
            'WALLET BALANCE',
            style:
                AppTextStyle.bold(FontWeight.w400, fontSize: FontSize.font16),
          ),
          SizedBox(height: 1.h),
          materialButton(
              buttonBkColor: AppColors.white,
              onPres: () {},
              borderRadiusSize: 5,
              height: 5.h,
              width: 30.w,
              widget: Text('Top Up')),
          SizedBox(height: 3.h),
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
              Icons.route,
              color: AppColors.black,
              size: 30,
            ),
            title: Text(
              'Driver Routes',
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
              navigateTo(AddDriverRoute());
              // Navigate to Payment Screen
            },
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: Icon(
              Icons.time_to_leave_sharp,
              color: AppColors.black,
              size: 30,
            ),
            title: Text(
              'Trips',
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
              navigateTo(RideRequestsScreen());
              // Navigate to Payment Screen
            },
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: Icon(
              Icons.my_location_outlined,
              color: AppColors.black,
              size: 30,
            ),
            title: Text(
              'Saved Places',
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
              navigateTo(SavedPlacesListScreen());
              // Navigate to Payment Screen
            },
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: Stack(
              children: [
                Icon(
                  Icons.notifications_none,
                  color: AppColors.black,
                  size: 30,
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.black,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      '2',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
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
              navigateTo(NotificationScreen());

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
              // this setting its driver setting
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
