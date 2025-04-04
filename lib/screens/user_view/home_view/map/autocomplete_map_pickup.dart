import 'package:buga/screens/user_view/home_view/home_export.dart';

import 'location_prediction.dart';

// class MapSearchInputAutocomplete extends StatelessWidget {
//   final String label;
//   final IconData icon;
//   final String placeholder;
//   final String initialValue;
//   final List<String> options;
//   final ValueChanged<String> onSelected;
//   final ValueChanged<String>? onChanged;
//   final InputDecoration? decoration;
//   final bool isEditable;
//   final TextEditingController? controller;

//   const MapSearchInputAutocomplete({
//     super.key,
//     required this.label,
//     required this.icon,
//     required this.placeholder,
//     required this.initialValue,
//     required this.options,
//     required this.onSelected,
//     this.onChanged,
//     this.decoration,
//     this.isEditable = true,
//     this.controller,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Autocomplete<String>(
//       optionsBuilder: (TextEditingValue textEditingValue) {
//         if (textEditingValue.text.isEmpty) {
//           return const Iterable<String>.empty();
//         }
//         return options.where((String option) =>
//             option.toLowerCase().contains(textEditingValue.text.toLowerCase()));
//       },
//       onSelected: onSelected,
//       optionsViewBuilder: (BuildContext context,
//           AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
//         return Align(
//           alignment: Alignment.topLeft,
//           child: Material(
//             elevation: 4.0,
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(maxHeight: 200),
//               child: ListView.builder(
//                 padding: EdgeInsets.zero,
//                 shrinkWrap: true,
//                 itemCount: options.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   final String option = options.elementAt(index);
//                   return ListTile(
//                     title: Text(
//                       option,
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                     onTap: () {
//                       onSelected(option);
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//         );
//       },
//       fieldViewBuilder: (BuildContext context,
//           TextEditingController textEditingController,
//           FocusNode focusNode,
//           VoidCallback onFieldSubmitted) {
//         textEditingController.text = initialValue;
//         textEditingController.selection = TextSelection.fromPosition(
//           TextPosition(offset: textEditingController.text.length),
//         );

//         return Row(
//           children: [
//             Icon(icon, size: 20),
//             const SizedBox(width: 8),
//             Expanded(
//               child: TextField(
//                 controller: controller ?? textEditingController,
//                 focusNode: focusNode,
//                 readOnly: !isEditable,
//                 onChanged: onChanged,
//                 decoration: decoration ??
//                     InputDecoration(
//                       hintText: placeholder,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(color: AppColors.gray),
//                       ),
//                       filled: true,
//                       fillColor: Colors.grey[200],
//                       contentPadding:
//                           const EdgeInsets.symmetric(horizontal: 16),
//                     ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }


///////////////////

class PredictionTextField extends ConsumerStatefulWidget {
  final String placeholder;
  final Function(Prediction)? onSuggestionSelected;
  final Function(String)? onTextChanged;

  const PredictionTextField({super.key, 
    required this.placeholder,
    this.onSuggestionSelected,
    this.onTextChanged,
  });

  @override
  _PredictionTextFieldState createState() => _PredictionTextFieldState();
}

class _PredictionTextFieldState extends ConsumerState<PredictionTextField> {
  final TextEditingController _controller = TextEditingController();
  List<Prediction> _filteredPredictions = [];
  bool _showDropdown = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _filterPredictions(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredPredictions = [];
        _showDropdown = false;
      });
      if(widget.onTextChanged != null){
        widget.onTextChanged!(query);
      }
      return;
    }

    final predictions = ref.read(predictionProvider);
    _filteredPredictions = predictions
        .where((prediction) =>
            prediction.description.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      _showDropdown = _filteredPredictions.isNotEmpty;
    });

    if(widget.onTextChanged != null){
      widget.onTextChanged!(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          onChanged: _filterPredictions,
          decoration: InputDecoration(
            hintText: widget.placeholder,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
        if (_showDropdown)
          Container(
            constraints: BoxConstraints(maxHeight: 200),
            margin: EdgeInsets.only(top: 4.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _filteredPredictions.length,
              itemBuilder: (context, index) {
                final prediction = _filteredPredictions[index];
                return ListTile(
                  title: Text(prediction.description),
                  subtitle: Text(prediction.placeArea),
                  onTap: () {
                    // Update textfield
                    _controller.text = prediction.description; 
                    setState(() {
                      _showDropdown = false;
                    });
                    if (widget.onSuggestionSelected != null) {
                      widget.onSuggestionSelected!(prediction);
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