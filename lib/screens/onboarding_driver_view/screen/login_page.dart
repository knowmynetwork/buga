import 'package:buga/route/navigation.dart';
import 'package:buga/route/route.dart';
import 'package:buga/screens/forget_password.dart'; // Import the forgot password screen
import 'package:buga/screens/home_screen.dart';
import 'package:buga/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  // Make LoginScreen stateful
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberLogin = false; // State variable for checkbox

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Implement navigation back logic here
          },
        ),
        title: const Text('Welcome Back!'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Login to your driver account',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                hintText: 'Email Address',
                prefixIcon: const Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                prefixIcon: const Icon(Icons.lock),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Checkbox(
                  value: _rememberLogin, // Use the state variable
                  onChanged: (value) {
                    setState(() {
                      _rememberLogin = value!; // Update the state
                    });
                  },
                ),
                const Text('Remember Login'),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context,
                        forgotPageRoute); // Navigate to ForgotPasswordScreen
                  },
                  child: const Text('Forgot your password?'),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                navigateTo(HomeScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.yellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('Log in'),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('New to Buga?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, signUpRoute);
                  },
                  child: const Text('Sign up!'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
