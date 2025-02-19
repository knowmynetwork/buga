import 'package:flutter/material.dart';
import '../theme/app_text_styles.dart';
import '../widgets/base_app_bar.dart';
import '../widgets/base_bottom_nav_bar.dart';
import '../widgets/ride_option_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(title: 'Hi there, Ololade'),
      body: Column(
        children: [
          WalletBalanceCard(),
          const Expanded(child: RideOptions()),
        ],
      ),
      bottomNavigationBar: BaseBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class WalletBalanceCard extends StatelessWidget {
  const WalletBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).primaryColor,
      child: Column(
        children: [
          const Icon(Icons.account_balance_wallet, size: 40),
          const SizedBox(height: 8),
          Text('₦15,235'),
          Text('WALLET BALANCE'),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(foregroundColor: Colors.black),
            child: const Text('Top Up'),
          ),
        ],
      ),
    );
  }
}

class RideOptions extends StatelessWidget {
  const RideOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: const [
          RideOptionCard(
            title: 'Solo Ride',
            subtitle: 'Single Rider',
            icon: Icons.directions_car,
          ),
          RideOptionCard(
            title: 'Share A Ride',
            subtitle: 'Shared Ride',
            icon: Icons.people,
          ),
          RideOptionCard(
            title: 'Airport Shuttle',
            subtitle: '20 Seater Bus',
            icon: Icons.airport_shuttle,
          ),
          RideOptionCard(
            title: 'Intra-School',
            subtitle: 'Electric Tricycle',
            icon: Icons.electric_bike,
          ),
        ],
      ),
    );
  }
}
