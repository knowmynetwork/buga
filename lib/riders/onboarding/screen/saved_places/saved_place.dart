import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../../Provider/riders/saved_places.dart';
import '../../../../viewmodels/ridermodel/saved_place.dart';

class SavedPlaces extends ConsumerStatefulWidget {
  const SavedPlaces({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SavedPlacesState();
}

class _SavedPlacesState extends ConsumerState<SavedPlaces> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _addressController.dispose();
    _infoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Saved Place"),
        backgroundColor: Colors.yellow[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Place Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: "Address",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _infoController,
              decoration: const InputDecoration(
                labelText: "Additional Info",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final newPlace = SavedPlace(
                    id: "new-id",
                    dateCreated: DateTime.now(),
                    dateModified: DateTime.now(),
                    title: "New Place",
                    address: "New Address",
                    latitude: 10.0,
                    longitude: 20.0,
                    type: "Home",
                  );
                  await ref
                      .read(addSavedPlaceProvider)
                      .call(newPlace)
                      .then((value) {
                    print('success');
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Place saved successfully!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.yellow[700],
                ),
                child: const Text("Save Place", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class SavedPlaces extends StatefulWidget {
//   const SavedPlaces({super.key});

//   @override
//   _SavedPlacesState createState() => _SavedPlacesState();
// }

// class _SavedPlacesState extends State<SavedPlaces> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _infoController = TextEditingController();

//   Future<void> _savePlace() async {
//     String name = _nameController.text.trim();
//     String address = _addressController.text.trim();
//     String info = _infoController.text.trim();

//     if (name.isEmpty || address.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Name and Address are required!")),
//       );
//       return;
//     }

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> savedPlaces = prefs.getStringList('saved_places') ?? [];

//     Map<String, String> newPlace = {
//       "name": name,
//       "address": address,
//       "info": info,
//     };

//     savedPlaces.add(jsonEncode(newPlace));
//     await prefs.setStringList('saved_places', savedPlaces);

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Place saved successfully!")),
//     );

//     _nameController.clear();
//     _addressController.clear();
//     _infoController.clear();
//     Navigator.pop(context, true); // Return to list screen and refresh it
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Add Saved Place"),
//         backgroundColor: Colors.yellow[700],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: const InputDecoration(
//                 labelText: "Place Name",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: _addressController,
//               decoration: const InputDecoration(
//                 labelText: "Address",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: _infoController,
//               decoration: const InputDecoration(
//                 labelText: "Additional Info",
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 3,
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _savePlace,
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   backgroundColor: Colors.yellow[700],
//                 ),
//                 child: const Text("Save Place", style: TextStyle(fontSize: 16)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
 
 
 
 
//   }
// }
