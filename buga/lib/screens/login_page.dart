
import 'package:buga/onboarding/screen/sign_up_driver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Providers for form data (Email and Password)
final emailProvider = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String>((ref) => '');

// Provider for Remember Me state
final rememberMeProvider = StateProvider<bool>((ref) => false);

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: LoginScreen(),
      ),
    ),
  );
}

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final rememberMe = ref.watch(rememberMeProvider);
    final email = ref.watch(emailProvider);
    final password = ref.watch(passwordProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.05),
            const Text(
              'Welcome back!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Login to your driver account',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            InputField(
              label: 'Email Address',
              hintText: 'Email Address',
              icon: Icons.email,
              obscureText: false,
              onChanged: (value) => ref.read(emailProvider.notifier).state = value,
              value: email,
            ),
            InputField(
              label: 'Password',
              hintText: 'Password',
              icon: Icons.lock,
              obscureText: true,
              onChanged: (value) => ref.read(passwordProvider.notifier).state = value,
              value: password,
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (value) {
                        ref.read(rememberMeProvider.notifier).state = value ?? false;
                      },
                      activeColor: Colors.yellow,
                    ),
                    const Text('Remember Login'),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    // Handle forgot password (you'll need to implement this)
                  },
                  child: const Text(
                    'Forgot your password?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.04),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  print("Login Button Pressed. Email: $email, Password: $password"); // Debug
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02,
                    horizontal: screenWidth * 0.3,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Log in',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DriverAccountScreen()),
                  );
                },
                child: const Text.rich(
                  TextSpan(
                    text: 'New to Buga? ',
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        text: 'Sign up!',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final void Function(String) onChanged;
  final String value;

  const InputField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            hintText: hintText,
            border: const OutlineInputBorder(),
          ),
          onChanged: onChanged,
          initialValue: value,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class HomeScreen extends ConsumerWidget {  // Make HomeScreen a ConsumerWidget
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("HomeScreen building..."); // Debug print
    final email = ref.watch(emailProvider); // Access the provider

    return Scaffold(
      appBar: AppBar(title: const Text("Home Screen")),
      body: Center(child: Text("Email: $email")), // Display the email
    );
  }
}

