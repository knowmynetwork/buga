import 'package:buga/Provider/getuser_details.dart';
import 'package:buga/local_storage/pref.dart';
import 'package:buga/screens/global_screens/onboarding.dart';
import 'package:buga/screens/onboarding_driver_view/screen/export.dart';
import 'screen_export.dart';

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

  int _currentIndex = 0;

  void _showRideDetailsBottomSheet(String rideTitle) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return _RideDetailsBottomSheet(rideTitle: rideTitle);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    provider = ref;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      drawer: _buildSidebar(),
      body: Column(
        children: [
          _buildWalletBalanceCard(),
          _buildTabs(),
          _buildRideOptions(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  AppBar _buildAppBar() {
    final userDetails = ref.watch(userProvider);
    return AppBar(
      backgroundColor: const Color(0xFFFFD700),
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
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
          icon: const Icon(Icons.notifications_none, color: Colors.black),
          onPressed: () {},
        ),
      ],
      centerTitle: true,
    );
  }

  Drawer _buildSidebar() {
    final userDetails = ref.watch(userProvider);

    return Drawer(
      child: Column(
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
              Navigator.pop(context);
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
              Navigator.pop(context);
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
              Navigator.pop(context);
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
      ),
    );
  }

  logUserOut() {
    Pref.setStringValue(tokenKey, '');
    UserModel(
      name: "",
      email: "",
      phoneNumber: "",
      userType: "",
    );

    pushReplacementScreen(OnboardingView());
  }

  Widget _buildWalletBalanceCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightYellow,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.account_balance_wallet, size: 40),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '₦15,235',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Text('WALLET BALANCE'),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Top Up'),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Order Now',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'Schedule Trip',
              style: TextStyle(fontSize: 20, color: AppColors.black),
            ),
          ),
        ],
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
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black),
            ),
            Text(
              'Select your ride',
              style: TextStyle(fontSize: 16, color: AppColors.black),
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
                    icon: Icons.directions_car,
                    onTap: () => _showRideDetailsBottomSheet('Solo Ride'),
                  ),
                  _RideOptionCard(
                    title: 'Share A Ride',
                    subtitle: 'Shared Ride',
                    icon: Icons.car_rental,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SharedRideScreen(
                          rideType: 'Share A Ride',
                        ),
                      ),
                    ),
                  ),
                  _RideOptionCard(
                    title: 'Airport Shuttle',
                    subtitle: '20 Seater Bus',
                    icon: Icons.airport_shuttle,
                    onTap: () => ('Airport Shuttle'),
                  ),
                  _RideOptionCard(
                    title: 'Intra-School',
                    subtitle: 'Electric Tricycle',
                    icon: Icons.electric_bike,
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

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      selectedItemColor: AppColors.black,
      unselectedItemColor: AppColors.blue,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.local_taxi), label: 'Trips'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}

class _RideOptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _RideOptionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
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
              Icon(icon, size: 50, color: AppColors.black),
              const SizedBox(height: 12),
              Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RideDetailsBottomSheet extends StatefulWidget {
  final String rideTitle;

  const _RideDetailsBottomSheet({required this.rideTitle});

  @override
  State<_RideDetailsBottomSheet> createState() =>
      _RideDetailsBottomSheetState();
}

class _RideDetailsBottomSheetState extends State<_RideDetailsBottomSheet> {
  int riders = 2;
  int luggage = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.rideTitle,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildOptionCard('Saloon Car', '2 riders', isSelected: true),
              _buildOptionCard('SUV/Minibus', '2+ riders'),
            ],
          ),
          const SizedBox(height: 16),
          _buildCounterRow('Total No of Riders', riders, max: 2,
              onChanged: (value) {
            setState(() {
              riders = value;
            });
          }),
          const SizedBox(height: 12),
          _buildCounterRow('Total Luggage Number', luggage, max: 4,
              onChanged: (value) {
            setState(() {
              luggage = value;
            });
          }),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              navigateTo((RideDetailsScreen()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.lightYellow,
              foregroundColor: AppColors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Center(child: Text('Proceed')),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard(String title, String subtitle,
      {bool isSelected = false}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? const Color(0xFFFFD700) : AppColors.white,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? const Color(0xFFFFD700) : Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? AppColors.lightYellow : AppColors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounterRow(String label, int value,
      {required int max, required ValueChanged<int> onChanged}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            IconButton(
              onPressed: value > 0 ? () => onChanged(value - 1) : null,
              icon: const Icon(Icons.remove_circle_outline),
              color: Colors.black,
            ),
            Text(value.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold)),
            IconButton(
              onPressed: value < max ? () => onChanged(value + 1) : null,
              icon: const Icon(Icons.add_circle_outline),
              color: Colors.black,
            ),
          ],
        ),
      ],
    );
  }
}
