import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:buga/Provider/user_provider.dart';
import 'package:buga/theme/app_colors.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(user),
      drawer: _buildSidebar(user, context),
      body: Column(
        children: [
          _buildWalletBalanceCard(),
          _buildTabs(),
          _buildRideOptions(context),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  AppBar _buildAppBar(UserModel? user) {
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
        user != null ? 'Hi there, ${user.name}' : 'Hi there!',
        style: const TextStyle(color: Colors.black),
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

  Drawer _buildSidebar(UserModel? user, BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.white,
            ),
            accountName: Text(
              user?.name ?? 'Guest',
              style: TextStyle(
                  color: AppColors.black, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              user?.email ?? 'guest@example.com',
              style: TextStyle(color: AppColors.black),
            ),
            currentAccountPicture: CircleAvatar(
              child: Image.asset(
                'assets/images/app_logo.png', // Ensure this exists
              ),
            ),
          ),
          _buildSidebarItem(context, Icons.payment, 'Trip'),
          _buildSidebarItem(context, Icons.settings, 'Settings'),
          _buildSidebarItem(context, Icons.help, 'Help'),
          const Spacer(),
          ListTile(
            leading: Icon(Icons.logout, color: AppColors.black),
            title: const Text(
              'Log Out',
              style: TextStyle(
                  color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // Perform logout action
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(BuildContext context, IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: AppColors.black, size: 30),
      title: Text(title,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.black)),
      trailing:
          const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 16),
      onTap: () => Navigator.pop(context),
    );
  }

  Widget _buildWalletBalanceCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightYellow,
        borderRadius: const BorderRadius.only(
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
            child: Text('Order Now',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black)),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Schedule Trip',
                style: TextStyle(fontSize: 20, color: AppColors.black)),
          ),
        ],
      ),
    );
  }

  Widget _buildRideOptions(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _RideOptionCard('Solo Ride', 'Single Rider', Icons.directions_car,
                () => _showRideDetailsBottomSheet(context, 'Solo Ride')),
            _RideOptionCard(
                'Share A Ride', 'Shared Ride', Icons.car_rental, () {}),
            _RideOptionCard('Airport Shuttle', '20 Seater Bus',
                Icons.airport_shuttle, () {}),
            _RideOptionCard('Intra-School', 'Electric Tricycle',
                Icons.electric_bike, () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (index) {},
      selectedItemColor: AppColors.black,
      unselectedItemColor: AppColors.blue,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.local_taxi), label: 'Trips'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }

  void _showRideDetailsBottomSheet(BuildContext context, String rideTitle) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
      builder: (BuildContext context) {
        return _RideDetailsBottomSheet(rideTitle);
      },
    );
  }
}

class _RideOptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _RideOptionCard(this.title, this.subtitle, this.icon, this.onTap,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: AppColors.black),
              const SizedBox(height: 12),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                  textAlign: TextAlign.center),
              Text(subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

class _RideDetailsBottomSheet extends StatelessWidget {
  final String rideTitle;
  const _RideDetailsBottomSheet(this.rideTitle, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Text('Details for $rideTitle'));
  }
}
