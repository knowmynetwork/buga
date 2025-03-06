import 'package:buga/service/get_otp_service.dart';
import 'package:buga/viewmodels/email_otp_model.dart';
import 'package:buga/viewmodels/register_model.dart';

import 'otp_view.dart';
import 'auth_export.dart';

class RiderRegisterView extends StatefulWidget {
  const RiderRegisterView({super.key});

  @override
  State<RiderRegisterView> createState() => _RiderRegisterViewState();
}

class _RiderRegisterViewState extends State<RiderRegisterView> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNumberController = TextEditingController();
  TextEditingController altNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
              SizedBox(height: 6.h),
              AuthWidgets.headerText('Create a rider account'),
              Center(
                child: Text(
                  'It’ll only take a minute',
                  style: AppTextStyle.bold(
                    FontWeight.w700,
                    fontSize: FontSize.font18,
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              appLabel('What would you like us to call you?'),
              SizedBox(height: 1.h),
              CustomTextField(
                hintText: 'Name',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.text,
                controller: userNameController,
              ),
              SizedBox(height: 2.h),
              appLabel('Your best Email?'),
              SizedBox(height: 1.h),
              CustomTextField(
                hintText: 'E.g yourname@gmail.com',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
              ),
              SizedBox(height: 2.h),
              appLabel('Your Phone Number (We’ll send a verification code)'),
              SizedBox(height: 1.h),
              CustomTextField(
                hintText: '+23400007654',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.number,
                controller: userNumberController,
              ),
              SizedBox(height: 2.h),
              appLabel('An alternative phone number '),
              Text(
                'To ensure we can absolutely reach you',
                style: AppTextStyle.medium(
                  FontWeight.w500,
                  fontSize: FontSize.font12,
                ),
              ),
              SizedBox(height: 1.h),
              CustomTextField(
                hintText: '+23400007654',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.number,
                controller: altNumberController,
              ),
              SizedBox(height: 2.h),
              appLabel('Secure your account'),
              SizedBox(height: 1.h),
              PasswordInputField(
                controller: passwordController,
                label: 'Password',
                validator: (value) {
                  return null;
                },
              ),
              SizedBox(height: 1.h),
              PasswordInputField(
                controller: confirmPasswordController,
                label: 'Confirm-password',
                validator: (value) {
                  return null;
                },
              ),
              SizedBox(height: 3.h),
              MaterialButton(
                minWidth: double.infinity,
                height: 7.h,
                onPressed: () {
                  // navigateTo(RiderOtpView());

                  if (emailController.text.isEmpty ||
                      userNameController.text.isEmpty ||
                      userNumberController.text.isEmpty ||
                      altNumberController.text.isEmpty ||
                      passwordController.text.isEmpty ||
                      confirmPasswordController.text.isEmpty) {
                    SnackBarView.showSnackBar('All input are required');
                  } else {
                    if (passwordController.text ==
                        confirmPasswordController.text) {
                      InternetChecks.internetCheck();
                      Future.delayed(const Duration(seconds: 1), () {
                        if (ref.read(InternetChecks.isUserConnected)) {
                          setState(() {
                            final emailData =
                                GetEmailModel(eMail: emailController.text);
                            debugPrint('calling endpoint now');
                            ref
                                .read(
                                    GetOtpService.isRiderAccountClick.notifier)
                                .state = true;

                            // add other user details
                            ref.read(RegisterProviders.email.notifier).state =
                                emailController.text;
                            ref.read(RegisterProviders.name.notifier).state =
                                userNameController.text;
                            ref
                                .read(RegisterProviders.phoneNumber.notifier)
                                .state = userNumberController.text;
                            ref
                                .read(RegisterProviders.altNumber.notifier)
                                .state = altNumberController.text;
                            ref
                                .read(RegisterProviders.password.notifier)
                                .state = passwordController.text;

                            GetOtpService.getOtp(emailData);
                          });
                        }
                      });
                    } else {
                      SnackBarView.showSnackBar(
                          'Password must match confirm-password');
                    }
                  }
                },
                color: AppColors.lightYellow,
                child: Center(
                  child: ref.watch(loadingAnimationSpinkit)
                      ? Center(child: loadingAnimation())
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
              SizedBox(height: 4.h),
            ],
          ),
        )),
      );
    });
  }
}
