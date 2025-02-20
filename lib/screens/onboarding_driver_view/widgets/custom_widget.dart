
import 'package:flutter/material.dart';


// you can move this widget file to the global widget folder so when needed we call on one widget folder/file at a time 
Widget _buildInputField({
    required String label,
    required void Function(String) onChanged,
    required String value,
    required String hintText,
    IconData? icon,
    bool isRequired = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ... (Label Text Widgets)
        TextFormField(
          initialValue: value,
          onChanged: onChanged,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: icon != null ? Icon(icon) : null,
            border: const OutlineInputBorder(),
            hintText: hintText,
          ),
          validator: validator ??
              (value) {
            if (isRequired && (value == null || value.isEmpty)) {
              return 'This field is required';
            }
            return null;
          },
        ),
        // ... (SizedBox)
      ],
    );
  }

  Widget _buildPasswordInput({
    required String label,
    required void Function(String) onChanged,
    required String value,
    required String hintText,
    bool isRequired = false,
    String? confirmPassword,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ... (Label Text Widgets)
        TextFormField(
          initialValue: value,
          onChanged: onChanged,
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock),
            border: const OutlineInputBorder(),
            hintText: hintText,
          ),
          validator: (value) {
            if (isRequired && (value == null || value.isEmpty)) {
              return 'This field is required';
            }
            if (confirmPassword != null && value != confirmPassword) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),
        // ... (SizedBox)
      ],
    );
  }
 
 // i dont uderstand this thats why i commented it out

  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         label,
  //         style: const TextStyle(
  //           fontSize: 16,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       const SizedBox(height: 8),
  //       TextFormField(
  //         obscureText: obscureText,
  //         decoration: InputDecoration(
  //           prefixIcon: Icon(icon),
  //           hintText: hintText,
  //           border: const OutlineInputBorder(),
  //         ),
  //         onChanged: onChanged,
  //         initialValue: value,
  //       ),
  //       const SizedBox(height: 16),
  //     ],
  //   );
  // }


