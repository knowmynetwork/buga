import 'package:buga/screens/home_screen.dart';

import 'export.dart';
import 'package:buga/theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberLogin = false; // State variable for checkbox

  // Controllers for the email and password fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              SizedBox(height: 1.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        navigateTo(LoginScreen());
                      },
                      icon: Icon(Icons.arrow_back))
                ],
              ),
              SizedBox(height: 3.h),
              AuthWidgets.headerText('Welcome back!'),
              SizedBox(height: 0.1.h),
              Center(
                child: Text(
                  'Login to your Driver account',
                  style: AppTextStyle.bold(
                    FontWeight.w700,
                    fontSize: FontSize.font18,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              CustomTextField(
                hintText: 'Email Address',
                prefixIcon: Icons.email,
                controller: _emailController,
              ),
              SizedBox(height: 2.h),
              CustomTextField(
                hintText: 'Password',
                prefixIcon: Icons.lock,
                obscureText: true,
                controller: _passwordController,
              ),
              SizedBox(height: 2.h),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberLogin,
                          onChanged: (value) {
                            setState(() {
                              _rememberLogin = value!;
                            });
                          },
                        ),
                        Text(
                          'Remember Login',
                          style: AppTextStyle.medium(
                            FontWeight.w500,
                            fontSize: FontSize.font12,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot your password?',
                        style: AppTextStyle.medium(
                          FontWeight.w500,
                          fontSize: FontSize.font12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              MaterialButton(
                minWidth: double.infinity,
                height: 7.h,
                onPressed: () {
                  // InternetChecks.dLoginInternetCheck();

                  // if (ref.read(InternetChecks.isloginDataOn)) {
                  //   setState(() {
                  //     final kk = LoginModel(
                  //         email: _emailController.text,
                  //         password: _passwordController.text);
                  //     LoginService.userLogin(kk);
                  //   });
                  // }

                  navigateTo(HomeScreen());
                },
                color: AppColors.lightYellow,
                child: Center(
                  child: ref.watch(loadingAnimationSpinkit)
                      ? loadingAnimation()
                      : Text(
                          'Login',
                          style: AppTextStyle.medium(
                            FontWeight.w700,
                            fontSize: FontSize.font18,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 3.h),
              Center(
                child: GestureDetector(
                  onTap: () {
                    navigateTo(RiderSignUpView());
                  },
                  child: Text(
                    'New to Buga? Sign up!',
                    style: TextStyle(
                      fontSize: FontSize.font13,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                      decorationThickness: 2.0,
                    ),
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

class AuthWidgets {
  static Widget headerText(String text) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: AppTextStyle.bold(
          FontWeight.w700,
          fontSize: FontSize.font30,
        ),
      ),
    );
  }
}
