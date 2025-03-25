import 'package:buga/Provider/getuser_details.dart';
import 'auth_export.dart';

class RiderLoginView extends ConsumerStatefulWidget {
  const RiderLoginView({super.key});

  @override
  ConsumerState<RiderLoginView> createState() => _RiderLoginViewState();
}

class _RiderLoginViewState extends ConsumerState<RiderLoginView> {
  // please leave these controller outside the build widget
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberLogin = false;

  @override
  Widget build(BuildContext context) {
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
            SizedBox(height: 1.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      navigateTo(OnboardingView());
                    },
                    icon: Icon(Icons.arrow_back))
              ],
            ),
            SizedBox(height: 3.h),
            AuthWidgets.headerText('Welcome back!'),
            SizedBox(height: 0.1.h),
            Center(
              child: Text(
                'Login to your rider account',
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
                            ref.read(isRememberPasswordClick.notifier).state =
                                true;
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
                if (_emailController.text.isEmpty ||
                    _passwordController.text.isEmpty) {
                  SnackBarView.showSnackBar('All input are required');
                } else {
                  InternetChecks.internetCheck();
                  Future.delayed(const Duration(seconds: 1), () {
                    if (ref.read(InternetChecks.isUserConnected)) {
                      debugPrint(
                          ' internet status ${ref.read(InternetChecks.isUserConnected)}');
                      setState(() {
                        final data = LoginModel(
                            email: _emailController.text,
                            password: _passwordController.text);
                        LoginService.userLogin(data);
                      });
                    }
                  });
                }
              },
              color: AppColors.yellow,
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
                  // the actual screen to be shown
                  navigateTo(RiderRegisterView());
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
          fontSize: FontSize.font24,
        ),
      ),
    );
  }
}
