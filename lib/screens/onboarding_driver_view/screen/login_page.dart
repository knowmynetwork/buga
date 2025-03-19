import 'package:buga/screens/global_screens/onboarding.dart';
import 'export.dart';
import 'package:buga/theme/app_colors.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    bool rememberLogin = false;

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberLogin = false; // State variable for checkbox

  // Controllers for the email and password fields
  // please leave these controller outside the build widget
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
              _buildBackButton(context),
              SizedBox(height: 3.h),
              AuthWidgets.headerText('Welcome back!'),
              SizedBox(height: 0.1.h),
              _buildSubtitle(),
              SizedBox(height: 8.h),
              _buildEmailField(emailController),
              SizedBox(height: 2.h),
              _buildPasswordField(passwordController),
              SizedBox(height: 2.h),
              _buildRememberLoginRow(ref, rememberLogin),
              SizedBox(height: 5.h),
              _buildLoginButton(
                  context, ref, emailController, passwordController),
              SizedBox(height: 3.h),
              _buildSignUpLink(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
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

  Widget _buildSubtitle() {
    return Center(
      child: Text(
        'Login to your Driver account',
        style: AppTextStyle.bold(
          FontWeight.w700,
          fontSize: FontSize.font18,
        ),
      ),
    );
  }

  Widget _buildEmailField(TextEditingController emailController) {
    return CustomTextField(
      hintText: 'Email Address',
      prefixIcon: Icons.email,
      controller: emailController,
    );
  }

  Widget _buildPasswordField(TextEditingController passwordController) {
    return CustomTextField(
      hintText: 'Password',
      prefixIcon: Icons.lock,
      obscureText: true,
      controller: passwordController,
    );
  }

  Widget _buildRememberLoginRow(WidgetRef ref, bool rememberLogin) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                value: rememberLogin,
                onChanged: (value) {
                  rememberLogin = value!;
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

  Widget _buildLoginButton(
    BuildContext context,
    WidgetRef ref,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 7.h,
      onPressed: () {
        if (emailController.text.isEmpty || passwordController.text.isEmpty) {
          SnackBarView.showSnackBar('All input are required');
        } else {
          InternetChecks.internetCheck();
          Future.delayed(const Duration(seconds: 1), () {
            if (ref.read(InternetChecks.isUserConnected)) {
              debugPrint(
                  'Internet status: ${ref.read(InternetChecks.isUserConnected)}');
              final data = LoginModel(
                email: emailController.text,
                password: passwordController.text,
              );
              LoginService.userLogin(data, ref);
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

  Widget _buildSignUpLink(BuildContext context) {
    return Center(
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
          fontSize: FontSize.font30,
        ),
      ),
    );
  }
}
