import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../../../Provider/riders/saved_places.dart';
import '../../../../../../service/service_export.dart';
import '../../../../../../viewmodels/ridermodel/saved_place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SavedPlaces extends ConsumerStatefulWidget {
  const SavedPlaces({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SavedPlacesState();
}

class _SavedPlacesState extends ConsumerState<SavedPlaces> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();

  var uuid = Uuid();
  String? _sessionToken;
  List<dynamic> _placeList = [];

  @override
  void initState() {
    super.initState();
    _addressController.addListener(() {
      _onChanged();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _addressController.dispose();
    _infoController.dispose();
  }

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_addressController.text);
  }

  void getSuggestion(String input) async {
    String kplacesApiKey = mapKey;
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kplacesApiKey&sessiontoken=$_sessionToken';
    var response = await http.get(
      Uri.parse(request),
    );
    if (response.statusCode == 200) {
      setState(() {
        _placeList = json.decode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  void _onSuggestionTap(Map<String, dynamic> place) async {
    setState(() {
      _addressController.text = place['description'];
      _placeList = [];
    });
    print('Selected Place Details:');
    print(json.encode(place));

    // Fetch detailed place information
    String placeId = place['place_id'];
    String kplacesApiKey = mapKey;
    String detailsUrl =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$kplacesApiKey';

    var response = await http.get(Uri.parse(detailsUrl));
    if (response.statusCode == 200) {
      var result = json.decode(response.body)['result'];
      print('Detailed Place Information:');
      print('Latitude: ${result['geometry']['location']['lat']}');
      print('Longitude: ${result['geometry']['location']['lng']}');
      print('others....: $result...');
    } else {
      print('Failed to fetch detailed place information');
    }
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
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _placeList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_placeList[index]["description"]),
                  onTap: () => _onSuggestionTap(_placeList[index]),
                );
              },
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
