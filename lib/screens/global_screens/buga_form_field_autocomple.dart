import 'package:flutter/material.dart';

class BugaFormFieldAutocomple extends StatelessWidget {
  final String label;
  final IconData icon;
  final String placeholder;
  final String initialValue;
  final List<String> options;
  final ValueChanged<String> onSelected;
  final ValueChanged<String>? onChanged;
  final InputDecoration? decoration;
  final bool isEditable;
  final TextEditingController? controller;

  const BugaFormFieldAutocomple({
    Key? key,
    required this.label,
    required this.icon,
    required this.placeholder,
    required this.initialValue,
    required this.options,
    required this.onSelected,
    this.onChanged,
    this.decoration,
    this.isEditable = true,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        }
        return options.where((String option) =>
            option.toLowerCase().contains(textEditingValue.text.toLowerCase()));
      },
      onSelected: onSelected,
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final String option = options.elementAt(index);
                  return ListTile(
                    title: Text(
                      option,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onTap: () {
                      onSelected(option);
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        textEditingController.text = initialValue;
        textEditingController.selection = TextSelection.fromPosition(
          TextPosition(offset: textEditingController.text.length),
        );

        return Row(
          children: [
            Icon(icon, size: 20, color: Colors.black),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: controller ?? textEditingController,
                focusNode: focusNode,
                readOnly: !isEditable,
                onChanged: onChanged,
                decoration: decoration ??
                    InputDecoration(
                      hintText: placeholder,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                    ),
              ),
            ),
          ],
        );
      },
    );
  }
}
