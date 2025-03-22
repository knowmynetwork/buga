import 'package:flutter/material.dart';

class RideFormField extends StatelessWidget {
  final String label;
  final IconData icon;
  final String placeholder;
  final bool isEditable;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final List<String> suggestions;
  final Function(String)? onSuggestionSelected;
  final TextEditingController? controller; // NEW

  const RideFormField({
    super.key,
    required this.label,
    required this.icon,
    required this.placeholder,
    required this.isEditable,
    this.onChanged,
    this.onTap,
    this.suggestions = const [],
    this.onSuggestionSelected,
    this.controller, // NEW
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Colors.black),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: controller, // use the controller if provided
                readOnly: !isEditable,
                onChanged: onChanged,
                onTap: onTap,
                decoration: InputDecoration(
                  hintText: placeholder,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
          ],
        ),
        if (suggestions.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(suggestions[index]),
                  onTap: () {
                    if (onSuggestionSelected != null) {
                      onSuggestionSelected!(suggestions[index]);
                    }
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
