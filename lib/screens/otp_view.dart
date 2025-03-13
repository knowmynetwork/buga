import 'package:buga/service/get_otp_service.dart';
import 'package:buga/viewmodels/email_otp_model.dart';
import 'package:buga/viewmodels/register_model.dart';
import 'rider_view/auth_views/auth_export.dart';

class RiderOtpView extends StatefulWidget {
  final GetEmailModel userEmail;
  // ignore: use_super_parameters
  const RiderOtpView({Key? key, required this.userEmail}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RiderOtpViewState createState() => _RiderOtpViewState();
}

class _RiderOtpViewState extends State<RiderOtpView> {
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  final TextEditingController _otpController = TextEditingController();
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _otpController.addListener(_validateOtp);
  }

  @override
  void dispose() {
    _otpController.dispose();
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _validateOtp() {
    setState(() {
      isButtonEnabled = _otpController.text.length == 4;
    });
  }

  void _onOtpFieldChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < _focusNodes.length - 1) {
        _focusNodes[index + 1].requestFocus();
      }
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

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
                          popScreen();
                        },
                        icon: Icon(Icons.arrow_back))
                  ],
                ),
                SizedBox(height: 3.h),
                AuthWidgets.headerText('We sent you a verification code!'),
                SizedBox(height: 1.h),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Enter the otp code sent to ${widget.userEmail.eMail}',
                    style: AppTextStyle.medium(
                      FontWeight.w500,
                      color: AppColors.gray,
                      fontSize: FontSize.font14,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (index) {
                    return SizedBox(
                      width: 40,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        focusNode: _focusNodes[index],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            _otpController.text += value; // Append value to OTP
                          } else if (_otpController.text.isNotEmpty) {
                            // Remove last character if empty
                            _otpController.text = _otpController.text
                                .substring(0, _otpController.text.length - 1);
                          }
                          _onOtpFieldChanged(value, index);
                        },
                      ),
                    );
                  }),
                ),
                SizedBox(height: 2.h),
                GestureDetector(
                  onTap: () {
                    final emailData =
                        GetEmailModel(eMail: widget.userEmail.eMail);
                    GetOtpService.getOtp(emailData);
                    SnackBarView.showSnackBar('Resend code clicked!');
                  },
                  child: Row(
                    children: [
                      Icon(Icons.replay_outlined),
                      Text(
                        'Resend Code',
                        style: AppTextStyle.medium(
                          FontWeight.w500,
                          fontSize: FontSize.font16,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 5.h),
                SizedBox(
                  width: double.infinity,
                  height: 7.h,
                  child: ElevatedButton(
                    onPressed: isButtonEnabled
                        ? () {
                            ref.read(RegisterProviders.otp.notifier).state =
                                _otpController.text;
                            debugPrint("Entered OTP: ${_otpController.text}");
                            setState(() {
                              // Update this model
                              VerifiedEmailOtpModel(
                                  eMail: widget.userEmail.eMail,
                                  tokenOtp: _otpController.text);

                              // call on endpoint to very otp
                              GetOtpService.getOtp(
                                  GetEmailModel(eMail: _otpController.text));
                            });

                            // navigateTo(RiderCategory());
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isButtonEnabled
                          ? AppColors.lightYellow
                          : AppColors.lightGray,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Proceed',
                      style: AppTextStyle.medium(
                        FontWeight.w700,
                        fontSize: FontSize.font18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
