import 'export.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberLogin = false; // State variable for checkbox

  // Controllers for the email and password fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
            // Reusable CustomTextField for Email
            CustomTextField(
              hintText: 'Email Address',
              prefixIcon: Icons.email,
              controller: _emailController,
            ),
            const SizedBox(height: 20.0),
            // Reusable CustomTextField for Password
            CustomTextField(
              hintText: 'Password',
              prefixIcon: Icons.lock,
              obscureText: true,
              controller: _passwordController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                  ],
                ),
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
