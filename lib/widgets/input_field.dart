import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// Reusable login textfield widget
class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(prefixIcon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ));
  }
}

// Reusable CustomPasswordField Widget
class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;

  const CustomPasswordField({
    Key? key,
    required this.controller,
    required this.label,
    this.validator,
  }) : super(key: key);

  @override
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.label,
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
          controller: widget.controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: widget.label,
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}

// Signup input widgets for passwords  without top label
class PasswordInputField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const PasswordInputField({
    Key? key,
    required this.label,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool obscureText = true; // Initialize obscureText

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: widget.label,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      ),
      validator: widget.validator, // Use widget.validator
    );
  }
}
