import 'package:buga/onboarding/loader_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key});

  @override
  _VerificationCodeScreenState createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());

  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    for (var controller in _controllers) {
      controller.addListener(_onInputChanged);
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.removeListener(_onInputChanged);
      controller.dispose();
    }
    super.dispose();
  }

  void _onInputChanged() {
    final isAllFilled = _controllers.every((controller) => controller.text.isNotEmpty);
    setState(() {
      isButtonEnabled = isAllFilled;
    });
  }

  void _resendCode() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Verification code resent!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 16.0 : 32.0,
            vertical: 16.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      'We sent you a verification code!',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 18 : 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Enter the six digit code sent to +2349020065170',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 14 : 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 32.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 40,
                      child: TextFormField(
                        controller: _controllers[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(1),
                        ],
                        style: const TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    IconButton(
                      onPressed: _resendCode,
                      icon: const Icon(Icons.refresh, size: 20.0),
                    ),
                    GestureDetector(
                      onTap: _resendCode,
                      child: const Text(
                        'Resend Code',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isButtonEnabled
                        ? () {
                            if (_formKey.currentState?.validate() ?? false) {
                              final code = _controllers.map((c) => c.text).join();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoadingScreen(), // Replace with your next screen widget
                                ),
                              );
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isButtonEnabled ? Colors.yellow[700] : Colors.grey[400],
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Proceed',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 14 : 16,
                            fontWeight: FontWeight.bold,
                            color: isButtonEnabled ? Colors.black : Colors.grey[700],
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Icon(
                          Icons.arrow_forward,
                          color: isButtonEnabled ? Colors.black : Colors.grey[700],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


