import 'package:buga/screens/driver_view/screen/trips/trips.dart';
import 'package:flutter_svg/svg.dart';
import '../../global_screens/app _layout.dart';
import 'export.dart';
import 'home/home_screen.dart';

List<Widget> navViews = [
  DriverHomeScreen(),
  RideRequestsScreen(),
  Container(color: AppColors.white, child: Center(child: Text('Chat View'))),
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
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: AppColors.yellow,
        unselectedItemColor: AppColors.black,
        // unselectedLabelStyle: TextStyle(
        //   color: AppColors.black,
        //   fontSize: 20,
        // ),
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
              icon: Icon(Icons.message_outlined,
                  color:
                      _currentIndex == 2 ? AppColors.yellow : AppColors.black),
              label: 'Chat'),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/driver/drive.svg',
              color: _currentIndex == 3 ? AppColors.yellow : AppColors.black,
            ),
            label: 'Drive,',
          ),
        ],
      ),
    );
  }
}
