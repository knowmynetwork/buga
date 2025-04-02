import 'package:buga/screens/user_view/user_trip/trip.dart';
import 'package:flutter/services.dart';

import 'home_export.dart';
import 'home_screen.dart';

List<Widget> navViews = [
  HomeScreen(),
  TripView(),
  Container(color: AppColors.white, child: Center(child: Text('Profile View'))),
];

final showAppBar = StateProvider((ref) => true);

class UserHomeView extends ConsumerStatefulWidget {
  const UserHomeView({super.key});

  @override
  ConsumerState<UserHomeView> createState() => _MainHomeViewState();
}

class _MainHomeViewState extends ConsumerState<UserHomeView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    provider = ref;
    final displayAppBar = ref.watch(showAppBar);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: AppColors.yellow,
        appBar: displayAppBar ? AppLayout.buildAppBar() : null,
        drawer: AppLayout.buildSidebar(),
        body: SafeArea(
          child: navViews.elementAt(_currentIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              index == 1
                  ? ref.read(showAppBar.notifier).state = false
                  : ref.read(showAppBar.notifier).state = true;
            });
          },
          selectedItemColor: AppColors.yellow,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_taxi), label: 'Trips'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
