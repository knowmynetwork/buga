import 'package:buga/Provider/driver_provider/saved_places.dart';
import 'package:uuid/uuid.dart';
import '../../../../../../service/service_export.dart';
import '../../../../viewmodels/drivermodel/saved_place.dart';
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

  String? name;
  String? formatted_address;
  double? latitude;
  double? longitude;
  String? vicinity;
  String? type;
  String? secondary_text;
  String? main_text;
  String? postal_code;

  var uuid = Uuid();
  String? _sessionToken;
  List<dynamic> _placeList = [];
  bool _showSuggestions = true;

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
    setState(() {
      _showSuggestions = true;
    });
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

      _showSuggestions = false;
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

      // Extract relevant information from the response
      name = result['name'];
      formatted_address = result['formatted_address'];
      latitude = result['geometry']['location']['lat'];
      longitude = result['geometry']['location']['lng'];
      vicinity = result['vicinity'];
      type = result['types'][0];
      secondary_text = result['address_components'][1]['long_name'];
      main_text = result['address_components'][0]['long_name'];
      postal_code = result['address_components'][2]['long_name'];

      print('Detailed Place Information:');
      print('Latitude: ${result['geometry']}');
      print('Address: ${result['formatted_address']}');
      print('Name: ${result['name']}');
      print('Address components...: ${result['address_components']}');
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
            if (_showSuggestions)
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
                  if (_nameController.text.isNotEmpty &&
                      _addressController.text.isNotEmpty &&
                      _infoController.text.isNotEmpty) {
                    final newPlace = SavedPlace(
                      addressFullName: formatted_address ?? 'Unknown',
                      adminArea: vicinity ?? 'Unkown',
                      cityName: 'UNKNOWN',
                      countryName: 'Nigeria',
                      countryCode: '+234',
                      featureName: 'UNKNOWN',
                      locality: main_text ?? 'UNKNOWN',
                      postalCode: postal_code ?? 'UNKNOWN',
                      subAdminArea: secondary_text ?? 'UNKNOWN',
                      subLocality: main_text ?? 'UNKNOWN',
                      name: name ?? 'Unknown',
                      neighbourhood: '',
                      raw: 'UNKNOWN',
                      streetName: 'UNKNOWN',
                      dateCreated: DateTime.now(),
                      dateModified: DateTime.now(),
                      title: _nameController.text,
                      address: _addressController.text,
                      latitude: latitude ?? 0.0,
                      longitude: longitude ?? 0.0,
                      type: 'Home',
                    );
                    // print('New Place: ${newPlace.toJson()}');

                    showDialog(
                        context: context,
                        builder: (context) {
                          return Center(
                            child: loadingAnimation(),
                          );
                        });

                    await ref
                        .read(addSavedPlaceProvider)
                        .call(newPlace)
                        .then((value) {
                      SnackBarView.showSnackBar('Place saved successfully!');

                      Navigator.pop(context);
                      Navigator.pop(context);
                    });
                  } else {
                    SnackBarView.showSnackBar('Please fill all fields');
                  }
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
