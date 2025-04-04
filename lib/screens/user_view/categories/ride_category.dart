import 'package:buga/constant/global_variable.dart';
import 'package:buga/constant/snackbar_view.dart';
import 'package:buga/service/category_search_service.dart';
import 'package:buga/service/get_otp_service.dart';
import 'package:buga/service/sign_up.dart';
import 'package:buga/viewmodels/register_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                      box1 ? AppColors.yellow : AppColors.lightGray1,
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
                      box2 ? AppColors.yellow : AppColors.lightGray1,
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
                      box3 ? AppColors.yellow : AppColors.lightGray1,
                      'Employee',
                      Icons.abc),
                ],
              ),
              SizedBox(height: 10.h),
              MaterialButton(
                minWidth: double.infinity,
                height: 7.h,
                onPressed: () {
                  if (box1) {
                    ref.read(RegisterProviders.category.notifier).state =
                        'Student';
                    debugPrint('User clicks on Student');
                    CategoriesSearch.getStudentUniversities();
                    // navigateTo(StudentSearchView());
                  } else if (box2) {
                    ref.read(RegisterProviders.category.notifier).state =
                        'Resident';
                    debugPrint('User clicks on Resident');
                    CategoriesSearch.getResidentSearch();
                    // navigateTo(ResidentSearchView());
                  } else if (box3) {
                    ref.read(RegisterProviders.category.notifier).state =
                        'Employee';
                    debugPrint('User clicks on Employee');
                    CategoriesSearch.getOrganizationSearch();
                    // navigateTo(EmployeeSearch());
                  }
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

class UpdateCategoryProviders {
  static updateModel() async {
    if (provider.read(GetOtpService.isRiderAccountClick)) {
      debugPrint('Updating Rider model');
      var userData = RegisterRiderModel(
          email: provider.read(RegisterProviders.email),
          name: provider.read(RegisterProviders.name),
          number: provider.read(RegisterProviders.phoneNumber),
          altNumber: provider.read(RegisterProviders.altNumber),
          password: provider.read(RegisterProviders.password),
          otp: provider.read(RegisterProviders.otp),
          category: provider.read(RegisterProviders.category),
          id: provider.read(RegisterProviders.id));
      await SignUpService.riderSignUp(userData);
    } else {
      debugPrint('Updating Driver model');
      var userDate = RegisterDriverModel(
        email: provider.read(RegisterProviders.email),
        name: provider.read(RegisterProviders.name),
        number: provider.read(RegisterProviders.phoneNumber),
        altNumber: provider.read(RegisterProviders.altNumber),
        password: provider.read(RegisterProviders.password),
        otp: provider.read(RegisterProviders.otp),
        address: provider.read(RegisterProviders.address),
        city: provider.read(RegisterProviders.city),
        state: provider.read(RegisterProviders.state),
        category: provider.read(RegisterProviders.category),
      );
      await SignUpService.driverSignUp(userDate);
    }
  }
}
