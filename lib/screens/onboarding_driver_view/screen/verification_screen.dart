import 'package:buga/service/get_otp_service.dart';
import 'package:buga/viewmodels/email_otp_model.dart';
import 'export.dart';

class VerificationCodeScreen extends StatefulWidget {
  final GetEmailModel userEmail;
  // ignore: use_super_parameters
  const VerificationCodeScreen({Key? key, required this.userEmail})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _VerificationCodeScreenState createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
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
            const SizedBox(height: 16),

            // Resend Code Button
            Row(
              children: [
                const Icon(Icons.refresh, color: Colors.grey),
                TextButton(
                  onPressed: () {
                    // Add your resend logic here
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
            Center(
              child: ElevatedButton(
                onPressed: isButtonEnabled
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Verification successful!')),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoadingScreen(),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isButtonEnabled ? Colors.yellow : Colors.grey,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Proceed',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  final GetEmailModel userEmail;

  const MyApp({super.key, required this.userEmail});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: Center(
          child: Text('Your Email: ${widget.userEmail.eMail}'),
        ),
      ),
    );
  }
}
