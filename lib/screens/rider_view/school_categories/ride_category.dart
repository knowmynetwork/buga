import 'package:buga/screens/onboarding_driver_view/screen/export.dart';
import 'all_search_views/employee_search.dart';
import 'all_search_views/resident_search.dart';
import 'categories_export.dart';

class RiderCategory extends StatefulWidget {
  const RiderCategory({super.key});

  @override
  State<RiderCategory> createState() => _RiderCategoryState();
}

class _RiderCategoryState extends State<RiderCategory> {
  bool box1 = false;
  bool box2 = false;
  bool box3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightYellow,
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
                'So we know how to serve you better',
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
                    box3 = false;
                  });
                },
                    box1 ? AppColors.white : AppColors.lightGray1,
                    box1 ? AppColors.lightYellow : AppColors.lightGray1,
                    'Student',
                    Icons.abc),
                optionBox(() {
                  setState(() {
                    box2 = true;
                    box1 = false;
                    box3 = false;
                  });
                },
                    box2 ? AppColors.white : AppColors.lightGray1,
                    box2 ? AppColors.lightYellow : AppColors.lightGray1,
                    'Resident',
                    Icons.abc),
                optionBox(() {
                  setState(() {
                    box3 = true;
                    box2 = false;
                    box1 = false;
                  });
                },
                    box3 ? AppColors.white : AppColors.lightGray1,
                    box3 ? AppColors.lightYellow : AppColors.lightGray1,
                    'Employee',
                    Icons.abc),
              ],
            ),
            SizedBox(height: 10.h),
            MaterialButton(
              minWidth: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 2.h),
              onPressed: () {
                if (box1) {
                  navigateTo(StudentSearchView());
                } else if (box2) {
                  navigateTo(ResidentSearchView());
                } else if (box3) {
                  navigateTo(EmployeeSearch());
                }
              },
              color: AppColors.lightYellow,
              child: Center(
                child: Row(
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
