import 'package:buga/constant/navigation.dart';
import 'package:buga/screens/home_screen.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Perform login logic here
                debugPrint('Email: ${emailController.text}');
                debugPrint('Password: ${passwordController.text}');
                pushReplacementScreen(HomeScreen());
                // Navigator.pushNamed(context, '/home'); // Navigate to home page
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                pushScreen('/signup');
                // Navigator.pushNamed(context, '/signup'); // Navigate to signup page
              },
              child: const Text('Don\'t have an account? Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
