import 'package:buga/service/get_otp_service.dart';
import 'package:buga/viewmodels/email_otp_model.dart';
import 'package:buga/viewmodels/register_model.dart';
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
                _buildSubHeaderText(),
                SizedBox(height: 5.h),
                _buildFormFields(),
                SizedBox(height: 3.h),
                _buildProceedButton(ref),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildSubHeaderText() {
    return Center(
      child: Text(
        'It’ll only take a minute',
        style: AppTextStyle.bold(
          FontWeight.w700,
          fontSize: FontSize.font18,
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('What would you like us to call you?'),
        _buildTextField(
            'Name', Icons.person, TextInputType.text, userNameController),
        _buildLabel('Your best Email?'),
        _buildTextField('E.g yourname@gmail.com', Icons.email,
            TextInputType.emailAddress, emailController),
        _buildLabel('Your Phone Number (We’ll send a verification code)'),
        _buildTextField('+23400007654', Icons.phone, TextInputType.number,
            userNumberController),
        _buildLabel('An alternative phone number'),
        _buildSubLabel('To ensure we can absolutely reach you'),
        _buildTextField('+23400007654', Icons.phone, TextInputType.number,
            altNumberController),
        _buildLabel('Secure your account'),
        _buildPasswordField('Password', passwordController),
        _buildPasswordField('Confirm-password', confirmPasswordController),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Column(
      children: [
        SizedBox(height: 1.h),
        appLabel(text),
        SizedBox(height: 1.h),
      ],
    );
  }

  Widget _buildSubLabel(String text) {
    return Text(
      text,
      style: AppTextStyle.medium(
        FontWeight.w500,
        fontSize: FontSize.font12,
      ),
    );
  }

  Widget _buildTextField(String hintText, IconData icon,
      TextInputType keyboardType, TextEditingController controller) {
    return Column(
      children: [
        CustomTextField(
          hintText: hintText,
          prefixIcon: icon,
          keyboardType: keyboardType,
          controller: controller,
        ),
        SizedBox(height: 2.h),
      ],
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return Column(
      children: [
        PasswordInputField(
          controller: controller,
          label: label,
          validator: (value) {
            return null;
          },
        ),
        SizedBox(height: 1.h),
      ],
    );
  }

  Widget _buildProceedButton(WidgetRef ref) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 7.h,
      onPressed: () {
        if (_areFieldsEmpty()) {
          SnackBarView.showSnackBar('All input are required');
        } else if (passwordController.text != confirmPasswordController.text) {
          SnackBarView.showSnackBar('Password must match confirm-password');
        } else {
          _handleProceed(ref);
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
    );
  }

  bool _areFieldsEmpty() {
    return emailController.text.isEmpty ||
        userNameController.text.isEmpty ||
        userNumberController.text.isEmpty ||
        altNumberController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty;
  }

  void _handleProceed(WidgetRef ref) {
    InternetChecks.internetCheck();
    Future.delayed(const Duration(seconds: 1), () {
      if (ref.read(InternetChecks.isUserConnected)) {
        setState(() {
          final emailData = GetEmailModel(eMail: emailController.text);
          debugPrint('calling endpoint now');
          ref.read(GetOtpService.isRiderAccountClick.notifier).state = true;

          // add other user details
          ref.read(RegisterProviders.email.notifier).state =
              emailController.text;
          ref.read(RegisterProviders.name.notifier).state =
              userNameController.text;
          ref.read(RegisterProviders.phoneNumber.notifier).state =
              userNumberController.text;
          ref.read(RegisterProviders.altNumber.notifier).state =
              altNumberController.text;
          ref.read(RegisterProviders.password.notifier).state =
              passwordController.text;

          GetOtpService.getOtp(emailData);
        });
      }
    });
  }
}
