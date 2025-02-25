import 'package:flutter/material.dart';
import 'package:buga/screens/onboarding_driver_view/widgets/custom_widget.dart';

class RiderSignUpView extends StatefulWidget {
  const RiderSignUpView({super.key});

  @override
  _RiderSignUpViewState createState() => _RiderSignUpViewState();
}

class _RiderSignUpViewState extends State<RiderSignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _alternativePhoneNumberController = TextEditingController();
  final _streetAddressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),
                const Text(
                  'Create a driver account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  "It'll only take a minute",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 32.0),

                // Name Input
                CustomInputField(
                  controller: _nameController,
                  label: 'What would you like us to call you?',
                  hintText: 'Name',
                  prefixIcon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // Email Input
                CustomInputField(
                  controller: _emailController,
                  label: 'Your best Email?',
                  hintText: 'E.g yourname@gmail.com',
                  prefixIcon: Icons.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // Phone Number Input
                CustomInputField(
                  controller: _phoneNumberController,
                  label: "Your Phone Number (We'll send a verification code)",
                  hintText: '+2340000004200',
                  prefixIcon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required';
                    }
                    if (!RegExp(r'^\+?\d{10,15}$').hasMatch(value)) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // Alternative Phone Number Input
                CustomInputField(
                  controller: _alternativePhoneNumberController,
                  label: 'An alternative phone number',
                  hintText: '+2340000004200',
                  prefixIcon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      if (!RegExp(r'^\+?\d{10,15}$').hasMatch(value)) {
                        return 'Please enter a valid phone number';
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // Street Address Input
                CustomInputField(
                  controller: _streetAddressController,
                  label: 'Street Address',
                  hintText: 'E.g. 2, harmony street, diamond estate.',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Street address is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // City and State Input
                Row(
                  children: [
                    Expanded(
                      child: CustomInputField(
                        controller: _cityController,
                        label: 'City',
                        hintText: 'E.g. Gbagada',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'City is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: CustomInputField(
                        controller: _stateController,
                        label: 'State',
                        hintText: 'E.g. Lagos',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'State is required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),

                const Text(
                  'Secure your account',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),

                // Password Input
                CustomPasswordField(
                  controller: _passwordController,
                  label: 'Create a password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // Confirm Password Input
                CustomPasswordField(
                  controller: _confirmPasswordController,
                  label: 'Confirm password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirming your password is required';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32.0),

                // Proceed Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        Navigator.pushNamed(context, '/otp_verification');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Proceed',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
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

// Reusable CustomInputField Widget
class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const Text(
              '*',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          ),
          validator: validator,
        ),
      ],
    );
  }
}

