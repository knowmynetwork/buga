import 'package:buga/screens/user_view/auth_views/login_view.dart';

import 'screen_export.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();

  static Widget displayImage(String imageName) {
    return SizedBox(
      width: double.infinity,
      child: Image.asset(
        imageName,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  static Widget contentDisplay(var bottomHt, String text1, text2) {
    return Positioned(
      top: 58.h,
      bottom: bottomHt,
      left: 5.w,
      right: 5.w,
      child: SizedBox(
        // color: Colors.green,
        width: 100.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              text1,
              maxLines: 4,
              style: AppTextStyle.bold(FontWeight.w700,
                  fontSize: FontSize.font30, color: AppColors.white),
            ),
            SizedBox(height: 2.h),
            Text(
              text2,
              maxLines: 9,
              style: AppTextStyle.medium(FontWeight.w700,
                  fontSize: FontSize.font16, color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }

  static Widget view1() {
    return Stack(
      children: [
        displayImage(onboardingImage2),
        contentDisplay(20.h, 'Hassle-free rides to and from school.',
            'Say goodbye to the stress of finding reliable transportation and hello to the convenience of our ride-hailing app.')
      ],
    );
  }

  static Widget view2() {
    return Stack(
      children: [
        displayImage(onboardingImage2),
        contentDisplay(20.h, 'Split the Bill',
            'Travel with friends and split the cost of your rides, making it more economical for everyone.')
      ],
    );
  }

  static Widget view3() {
    return Stack(
      children: [
        displayImage(onboardingImage3),
        contentDisplay(20.h, 'Schedule Your Rides',
            'Plan ahead and schedule your rides to and from school, ensuring you never miss a class.')
      ],
    );
  }

  static Widget view4() {
    return Stack(
      children: [
        displayImage(onboardingImage4),
        contentDisplay(20.h, 'In-App Safety',
            'Your safety is our top priority. With our in-app emergency feature, you can feel secure on every ride.')
      ],
    );
  }

  static Widget view5() {
    return Stack(
      children: [
        displayImage(onboardingImage5),
        contentDisplay(20.h, 'Become a Buga Driver',
            'Earn money by providing safe and reliable rides to students on their way to and from school.')
      ],
    );
  }
}

class _OnboardingViewState extends State<OnboardingView> {
  final List<Widget> screenView = [
    OnboardingView.view1(),
    OnboardingView.view2(),
    OnboardingView.view3(),
    OnboardingView.view4(),
    OnboardingView.view5(),
  ];

  int currentIndex = 0;
  bool isAnimating = false;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  onBoardingSilds() {
    if (isAnimating) return;
    setState(() {
      if (currentIndex == 4) {
        debugPrint('Last onboarding');
        navigateTo(RiderLoginView());
      } else {
        isAnimating = true;
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            setState(() {
              currentIndex = (currentIndex + 1) % screenView.length;
              _pageController.animateToPage(currentIndex,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
              isAnimating = false;
              debugPrint('Current index its $currentIndex');
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          SystemNavigator.pop();
        },
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemCount: screenView.length,
              itemBuilder: (context, index) {
                return screenView[index];
              },
            ),
            Container(
              width: 100.w,
              padding: EdgeInsetsDirectional.symmetric(horizontal: 5.w),
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 9.h),
                  Container(
                    width: 100.w,
                    height: 7.h,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        tabView("User", AppColors.black, AppColors.white),
                        SizedBox(width: 3.w),
                        GestureDetector(
                            onTap: () {
                              navigateTo(LoginScreen());
                            },
                            child: tabView(
                                "Driver", AppColors.white, AppColors.black))
                      ],
                    ),
                  ),
                  SizedBox(height: 63.h),
                  currentIndex == 3 || currentIndex == 4
                      ? Column(
                          children: [
                            MaterialButton(
                              minWidth: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 2.h),
                              onPressed: () {
                                onBoardingSilds();
                              },
                              color: AppColors.yellow,
                              child: Center(
                                child: Text(
                                  'Register',
                                  style: AppTextStyle.medium(
                                    FontWeight.w700,
                                    fontSize: FontSize.font18,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 2.5.h),
                            GestureDetector(
                              onTap: () {
                                navigateTo(RiderLoginView());
                              },
                              child: Text(
                                'Already a User? Login',
                                style: TextStyle(
                                    color: AppColors.white,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.white,
                                    decorationStyle: TextDecorationStyle.solid,
                                    decorationThickness: 2.0,
                                    fontSize: FontSize.font18,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(
                          width: 100.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  navigateTo(RiderLoginView());
                                },
                                child: Text(
                                  'Skip',
                                  style: TextStyle(
                                    color: AppColors.yellow,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.yellow,
                                    decorationStyle: TextDecorationStyle.solid,
                                    decorationThickness: 2.0,
                                  ),
                                ),
                              ),
                              SizedBox(height: 2.h),
                              SizedBox(
                                width: 19.w,
                                height: 8.h,
                                child: MaterialButton(
                                  onPressed: () {
                                    onBoardingSilds();
                                  },
                                  color: AppColors.yellow,
                                  child: Icon(Icons.arrow_forward),
                                ),
                              )
                            ],
                          ),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget tabView(String text, Color bkColor, textColor) {
    return Container(
      width: 41.w,
      height: 6.h,
      decoration:
          BoxDecoration(color: bkColor, borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: Text(
          text,
          style: AppTextStyle.medium(FontWeight.w400,
              fontSize: FontSize.font13, color: textColor),
        ),
      ),
    );
  }
}
