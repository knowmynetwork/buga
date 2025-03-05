
import 'package:buga/screens/rider_view/school_categories/ride_category.dart';

import 'auth_export.dart';


class RiderOtpView extends StatefulWidget {
  // ignore: use_super_parameters
  const RiderOtpView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RiderOtpViewState createState() => _RiderOtpViewState();
}

class _RiderOtpViewState extends State<RiderOtpView> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  bool isButtonEnabled = false;

  void _validateOtp() {
    // Enable the button only if all fields are filled with exactly 1 character
    setState(() {
      isButtonEnabled =
          _controllers.every((controller) => controller.text.isNotEmpty);
    });
  }

  @override
  void initState() {
    super.initState();
    for (var controller in _controllers) {
      controller.addListener(_validateOtp);
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Enter the six digit code sent to',
                      style: AppTextStyle.medium(
                        FontWeight.w500,
                        color: AppColors.gray,
                        fontSize: FontSize.font14,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      ' +2349020065170 ',
                      style: AppTextStyle.bold(
                        FontWeight.w500,
                        fontSize: FontSize.font14,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 40,
                    child: TextFormField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [LengthLimitingTextInputFormatter(1)],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (value) => _onOtpFieldChanged(value, index),
                    ),
                  );
                }),
              ),
              SizedBox(height: 2.h),
              Row(
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
              SizedBox(height: 5.h),
              Center(
                child: ElevatedButton(
                  onPressed: isButtonEnabled
                      ? () {
                          navigateTo(RiderCategory());
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
  }
}
