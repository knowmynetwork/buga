import 'package:buga/riders/onboarding/screen/login_page.dart';
import 'package:buga/riders/categories/ride_category.dart';
import 'screen/export.dart';

class DriverCategory extends StatefulWidget {
  const DriverCategory({super.key});

  @override
  State<DriverCategory> createState() => _DriverCategoryState();
}

class _DriverCategoryState extends State<DriverCategory> {
  bool box1 = false;
  bool box2 = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      provider = ref;
      return Scaffold(
        backgroundColor: AppColors.yellow,
        body: SafeArea(
            child: Container(
          color: AppColors.white,
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: ListView(
            children: [
              SizedBox(height: 4.h),
              AuthWidgets.headerText('Select Your Category'),
              SizedBox(height: 1.h),
              Center(
                child: Text(
                  'So we can personalize your experience',
                  style: AppTextStyle.medium(
                    FontWeight.w500,
                    color: AppColors.gray,
                    fontSize: FontSize.font14,
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                runSpacing: 2.h,
                children: [
                  optionBox(() {
                    setState(() {
                      box1 = true;
                      box2 = false;
                    });
                  },
                      box1 ? AppColors.white : AppColors.lightGray1,
                      box1 ? AppColors.yellow : AppColors.lightGray1,
                      'Car',
                      Icons.person_add_alt_1),
                  optionBox(() {
                    setState(() {
                      box2 = true;
                      box1 = false;
                    });
                  },
                      box2 ? AppColors.white : AppColors.lightGray1,
                      box2 ? AppColors.yellow : AppColors.lightGray1,
                      'E-trike',
                      Icons.people_outline_sharp),
                ],
              ),
              SizedBox(height: 10.h),
              MaterialButton(
                minWidth: double.infinity,
                height: 7.h,
                onPressed: () {
                  if (box1) {
                    ref.read(RegisterProviders.category.notifier).state = 'Car';
                  } else if (box2) {
                    ref.read(RegisterProviders.category.notifier).state =
                        'Etrike';
                  }
                  ref.read(loadingAnimationSpinkit.notifier).state = true;
                  UpdateCategoryProviders.updateModel();
                  // pushReplacementScreen(LoadingScreen());
                },
                color: AppColors.yellow,
                child: Center(
                  child: ref.watch(loadingAnimationSpinkit)
                      ? loadingAnimation()
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Proceed',
                              style: AppTextStyle.medium(
                                FontWeight.w700,
                                fontSize: FontSize.font18,
                              ),
                            ),
                            SizedBox(width: 1.w),
                            Icon(Icons.arrow_circle_right_sharp)
                          ],
                        ),
                ),
              ),
            ],
          ),
        )),
      );
    });
  }

  Widget optionBox(VoidCallback onTap, Color bkColor, borderColor, String text,
      IconData icon) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.w,
        decoration: BoxDecoration(
            color: bkColor, border: Border.all(color: borderColor)),
        padding: EdgeInsets.symmetric(
          vertical: 2.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            Text(
              text,
              style: AppTextStyle.medium(
                FontWeight.w500,
                color: AppColors.black,
                fontSize: FontSize.font14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
