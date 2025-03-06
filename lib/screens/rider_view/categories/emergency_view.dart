import 'categories_export.dart';

class RiderEmergencyView extends StatelessWidget {
  const RiderEmergencyView({super.key});

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
              AuthWidgets.headerText(
                  'Who would you like us to reach in case of an emergency?'),
              SizedBox(height: 1.h),
              Center(
                child: Text(
                  'Your emergency contact',
                  style: AppTextStyle.medium(
                    FontWeight.w500,
                    color: AppColors.gray,
                    fontSize: FontSize.font14,
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              appLabel('Contact’s Name'),
              SizedBox(height: 1.h),
              CustomTextField(
                hintText: 'Name',
                prefixIcon: Icons.person,
                keyboardType: TextInputType.text,
                controller: TextEditingController(),
              ),
              SizedBox(height: 2.h),
              appLabel('Relationship with contact'),
              SizedBox(height: 1.h),
              CustomTextField(
                hintText: 'E.g Father, Mother',
                prefixIcon: Icons.person,
                keyboardType: TextInputType.text,
                controller: TextEditingController(),
              ),
              SizedBox(height: 2.h),
              appLabel('Contact’s Phone Number'),
              SizedBox(height: 1.h),
              CustomTextField(
                hintText: '+2340000004200',
                prefixIcon: Icons.person,
                keyboardType: TextInputType.number,
                controller: TextEditingController(),
              ),
              SizedBox(height: 2.h),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Icon(Icons.perm_contact_cal),
                    appLabel('Select from contacts'),
                  ],
                ),
              ),
              appLabel('An alternative phone number '),
              Text(
                'To ensure we can absolutely reach your contact',
                style: AppTextStyle.medium(
                  FontWeight.w500,
                  color: AppColors.lightGray,
                  fontSize: FontSize.font12,
                ),
              ),
              SizedBox(height: 1.h),
              CustomTextField(
                hintText: '+2340000004200',
                prefixIcon: Icons.person,
                keyboardType: TextInputType.number,
                controller: TextEditingController(),
              ),
              SizedBox(height: 2.h),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Icon(Icons.perm_contact_cal),
                    appLabel('Select from contacts'),
                  ],
                ),
              ),
              SizedBox(height: 4.h),
              MaterialButton(
                minWidth: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 2.h),
                onPressed: () {},
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
              SizedBox(height: 2.h),
            ],
          ),
        )));
  }
}
