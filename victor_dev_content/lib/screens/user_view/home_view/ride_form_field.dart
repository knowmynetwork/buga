

import 'home_export.dart';

class RideFormField extends StatelessWidget {
  final String label;
  final IconData icon;
  final String placeholder;
  final bool isEditable;
  final Function(String)? onChanged;
  final VoidCallback? onTap;

  const RideFormField({
    super.key,
    required this.label,
    required this.icon,
    required this.placeholder,
    required this.isEditable,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: () {
              debugPrint('RideFormField tapped'); // Debugging log
              if (onTap != null) {
                onTap!();
              }
            },
            child: TextField(
              readOnly: !isEditable,
              onChanged: isEditable ? onChanged : null,
              decoration: InputDecoration(
                hintText: placeholder,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.gray),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PriceFormField extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const PriceFormField({
    super.key,
    required this.icon,
    required this.placeholder,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: placeholder,
        prefixIcon: Icon(icon, color: AppColors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.gray),
        ),
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
