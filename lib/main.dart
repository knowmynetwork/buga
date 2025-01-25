import 'package:flutter/material.dart';

void main() {
  runApp(const RideSharingApp());
}

class RideSharingApp extends StatelessWidget {
  const RideSharingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ride Sharing App',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.yellow[700],
        title: const Text(
          'Hi there, Ololade',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      drawer: const Drawer(),
      body: Column(
        children: [
          WalletBalanceCard(),
          const SizedBox(height: 10),
          const RideOptions(),
        ],
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}

class WalletBalanceCard extends StatelessWidget {
  const WalletBalanceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.yellow[700],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.account_balance_wallet, size: 40, color: Colors.black),
          const SizedBox(height: 8),
          const Text(
            '₦15,235',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Text(
            'WALLET BALANCE',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Top Up'),
          ),
        ],
      ),
    );
  }
}

class RideOptions extends StatelessWidget {
  const RideOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ready To Move?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
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
            ),
          ],
        ),
      ),
    );
  }
}

class RideOptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const RideOptionCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.yellow[700]),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_car),
          label: 'Trips',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      selectedItemColor: Colors.yellow[700],
      unselectedItemColor: Colors.black54,
    );
  }
}