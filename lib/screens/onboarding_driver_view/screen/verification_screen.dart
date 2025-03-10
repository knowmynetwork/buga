import 'package:buga/service/get_otp_service.dart';
import 'package:buga/theme/app_colors.dart';
import 'package:buga/viewmodels/email_otp_model.dart';
import 'package:buga/viewmodels/register_model.dart';
import 'export.dart';

class VerificationCodeScreen extends StatefulWidget {
  final GetEmailModel userEmail;

  const VerificationCodeScreen({super.key, required this.userEmail});

  @override
  _VerificationCodeScreenState createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
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
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'We sent you a verification code!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Enter the otp code sent to ${widget.userEmail.eMail}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // OTP Input Fields
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
              const SizedBox(height: 16),

              // Resend Code Button
              Row(
                children: [
                  const Icon(Icons.refresh, color: Colors.grey),
                  TextButton(
                    onPressed: () {
                      final emailData =
                          GetEmailModel(eMail: widget.userEmail.eMail);
                      GetOtpService.getOtp(emailData);
                      SnackBarView.showSnackBar('Resend code clicked!');
                    },
                    child: const Text(
                      'Resend Code',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              const Spacer(),

              // Proceed Button
              SizedBox(
                width: double.infinity,
                height: 7.h,
                child: ElevatedButton(
                  onPressed: isButtonEnabled
                      ? () {
                          // Access OTP with _otpController.text
                          ref.read(RegisterProviders.otp.notifier).state =
                              _otpController.text;
                          debugPrint("Entered OTP: ${_otpController.text}");
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
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    });
  }
}
