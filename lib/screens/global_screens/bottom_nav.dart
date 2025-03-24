import 'screen_export.dart';

List<Widget> navViews = [
  HomeScreen(),
  Container(color: AppColors.white, child: Center(child: Text('Trips View'))),
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
      appBar: AppLayout.buildAppBar(),
      drawer: AppLayout.buildSidebar(),
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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.local_taxi), label: 'Trips'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
