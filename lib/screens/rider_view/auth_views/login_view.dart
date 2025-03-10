import 'package:buga/screens/emergency_cont.dart';
import 'auth_export.dart';

class RiderLoginView extends StatefulWidget {
  const RiderLoginView({super.key});

  @override
  State<RiderLoginView> createState() => _RiderLoginViewState();
}

class _RiderLoginViewState extends State<RiderLoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberLogin = false;

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
                _buildBackButton(),
                SizedBox(height: 3.h),
                AuthWidgets.headerText('Welcome back!'),
                SizedBox(height: 0.1.h),
                _buildSubHeaderText(),
                SizedBox(height: 8.h),
                _buildEmailTextField(),
                SizedBox(height: 2.h),
                _buildPasswordTextField(),
                SizedBox(height: 2.h),
                _buildRememberLoginAndForgotPassword(),
                SizedBox(height: 5.h),
                _buildLoginButton(ref),
                SizedBox(height: 3.h),
                _buildSignUpText(),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildBackButton() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            navigateTo(OnboardingView());
          },
          icon: Icon(Icons.arrow_back),
        ),
      ],
    );
  }

  Widget _buildSubHeaderText() {
    return Center(
      child: Text(
        'Login to your rider account',
        style: AppTextStyle.bold(
          FontWeight.w700,
          fontSize: FontSize.font18,
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return CustomTextField(
      hintText: 'Email Address',
      prefixIcon: Icons.email,
      controller: _emailController,
    );
  }

  Widget _buildPasswordTextField() {
    return CustomTextField(
      hintText: 'Password',
      prefixIcon: Icons.lock,
      obscureText: true,
      controller: _passwordController,
    );
  }

  Widget _buildRememberLoginAndForgotPassword() {
    return SizedBox(
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
    );
  }

  Widget _buildLoginButton(WidgetRef ref) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 7.h,
      onPressed: () {
        if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
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
    );
  }

  Widget _buildSignUpText() {
    return Center(
      child: GestureDetector(
        onTap: () {
          navigateTo(EmergencyContactForm());
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
