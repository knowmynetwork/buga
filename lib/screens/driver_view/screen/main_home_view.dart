
import 'package:flutter_svg/svg.dart';
import '../../global_screens/app _layout.dart';
import 'export.dart';
import 'home/home_screen.dart';
import 'trip/trips.dart';

List<Widget> navViews = [
  DriverHomeScreen(),
  RideRequestsScreen(),
  Container(color: AppColors.white, child: Center(child: Text('Profile View'))),
];

class MainHomeView extends ConsumerStatefulWidget {
  const MainHomeView({super.key});

  @override
  ConsumerState<MainHomeView> createState() => _MainHomeViewState();
}

class _MainHomeViewState extends ConsumerState<MainHomeView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    provider = ref;

    return Scaffold(
      backgroundColor: AppColors.yellow,
      appBar: _currentIndex == 0 ? AppLayout.buildAppBar() : null,
      drawer: _currentIndex == 0 ? AppLayout.buildSidebar() : null,
      body: SafeArea(
        child: navViews.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: AppColors.yellow,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/driver/activity.svg',
                color: _currentIndex == 0 ? AppColors.yellow : AppColors.black,
              ),
              label: 'Activity'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/driver/trips.svg',
                color: _currentIndex == 1 ? AppColors.yellow : AppColors.black,
              ),
              label: 'Trips'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/driver/drive.svg',
                color: _currentIndex == 2 ? AppColors.yellow : AppColors.black,
              ),
              label: 'Drive,'),
        ],
      ),
    );
  }
}