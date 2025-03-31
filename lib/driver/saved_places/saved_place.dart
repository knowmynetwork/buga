import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../Provider/riders/saved_places.dart';
import '../../../../service/service_export.dart';
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

  late FlutterGooglePlacesSdk places;
  List<AutocompletePrediction> predictions = [];

  /// Fetch address suggestions from Google Places API
  Future<void> fetchPredictions(String input) async {
    if (input.isEmpty) return;

    final result = await places.findAutocompletePredictions(
      input,
      countries: ["NG"], // Restrict search to a specific country (optional)
    );

    setState(() {
      predictions = result.predictions;
    });
  }

  Future<void> getPlaceDetails(String placeId) async {
    final result = await places.fetchPlace(
      placeId,
      fields: [
        PlaceField.Location,
        PlaceField.Name,
        PlaceField.Address,
        PlaceField.Id,
        PlaceField.PhoneNumber,
        PlaceField.Rating,
        PlaceField.Types,
        PlaceField.PriceLevel,
        PlaceField.AddressComponents,
      ], // Fetch required fields
    );

    if (result.place?.latLng != null) {
      final lat = result.place!.latLng!.lat;
      final lng = result.place!.latLng!.lng;

      print("🏠 Selected Place: ${result.place!.name}");
      print("📍 Latitude: $lat, Longitude: $lng");

      print('This is  the complete result$result ');
    } else {
      print("⚠️ Failed to fetch location details.");
    }
  }

  @override
  void initState() {
    super.initState();
    places = FlutterGooglePlacesSdk(mapKey);
  }

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
              onChanged: (String val) {
                fetchPredictions(_addressController.text);
              },
              decoration: const InputDecoration(
                labelText: "Address",
                border: OutlineInputBorder(),
              ),
            ),
            ...predictions.map((prediction) {
              return ListTile(
                title: Text(prediction.fullText ?? ""),
                onTap: () {
                  _addressController.text = prediction.fullText;
                  getPlaceDetails(prediction.placeId);

                  // getPlaceDetails(prediction.placeId!);
                  setState(() =>
                      predictions.clear()); // Clear suggestions after selection
                },
              );
            }),
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
