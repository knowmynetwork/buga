import 'package:flutter/material.dart';

class OtpValidationPage extends StatelessWidget {
  final TextEditingController otpController = TextEditingController();

  OtpValidationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Validate OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: otpController,
              decoration: const InputDecoration(
                labelText: 'Enter OTP',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Perform OTP validation here
                debugPrint('OTP entered: ${otpController.text}');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('OTP Verified!')),
                );
                Navigator.pushReplacementNamed(context, '/login'); // Go to login
              },
              child: const Text('Validate OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
