import 'search_export.dart';

class StudentSearchView extends StatelessWidget {
  const StudentSearchView({super.key});

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
              SizedBox(height: 2.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        popScreen();
                      },
                      icon: Icon(Icons.arrow_back))
                ],
              ),
              SizedBox(height: 2.h),
              AuthWidgets.headerText('What University do you attend?'),
              SizedBox(height: 1.h),
              Center(
                child: Text(
                  'We would like to personalize your experience',
                  style: AppTextStyle.medium(
                    FontWeight.w500,
                    color: AppColors.gray,
                    fontSize: FontSize.font14,
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              appLabel('Select from the options below'),
              SizedBox(height: 2.h),
              CategoryLayout.userSearch(),
              SizedBox(height: 1.h),
              SizedBox(
                  // color: Colors.red,
                  width: double.infinity,
                  height: 45.h,
                  child: CategoryLayout.categorySearchDisplay()),
              SizedBox(height: 4.h),
              CategoryLayout.proceedButton(),
            ],
          ),
        )),
      );
    });
  }
}
