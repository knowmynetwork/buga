import 'search_export.dart';

class ResidentSearchView extends StatelessWidget {
  const ResidentSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      provider = ref;
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
              AuthWidgets.headerText('Please select your estate'),
              SizedBox(height: 1.h),
              Center(
                child: Text(
                  'If your estate is not in the list below, we currently do not offer our services within your estate.',
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
                  child: CategoryLayout.categorySearchDisplay()
                  // ListView(
                  //   children: [],
                  // ),
                  ),
              SizedBox(height: 4.h),
              MaterialButton(
                minWidth: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 2.h),
                onPressed: () {
                  navigateTo(RiderEmergencyView());
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
    });
  }
}
