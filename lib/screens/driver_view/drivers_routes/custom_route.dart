import 'package:buga/constant/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'dart:convert';

import 'package:uuid/uuid.dart';

class CustomRoute extends ConsumerStatefulWidget {
  const CustomRoute({super.key});

  @override
  _CustomRouteState createState() => _CustomRouteState();
}

class _CustomRouteState extends ConsumerState<CustomRoute> {
  final TextEditingController _startLocationController =
      TextEditingController();
  final TextEditingController _endLocationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  bool _showStartSuggestions = false;
  bool _showEndSuggestions = false;

  String? name;
  String? formatted_address;
  double? latitude;
  double? longitude;
  String? vicinity;
  String? type;
  String? secondary_text;
  String? main_text;
  String? postal_code;

  String? _selectedStartLocation;
  String? _selectedEndLocation;
  double _price = 0;

  var uuid = Uuid();
  List<dynamic> _startPlaceList = [];
  List<dynamic> _endPlaceList = [];
  List<String> selectedDaysTab2 = [];

  final List<String> daysOfWeek = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];

  String? _sessionToken;

  @override
  void initState() {
    super.initState();
    _startLocationController.addListener(() {
      _onStartChanged();
    });
    _endLocationController.addListener(() {
      _onEndChanged();
    });
  }

  @override
  dispose() {
    _startLocationController.dispose();
    _endLocationController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  _onStartChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_startLocationController.text, true);
  }

  _onEndChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_endLocationController.text, false);
  }

  void getSuggestion(String input, bool isStart) async {
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
        if (isStart) {
          _startPlaceList = json.decode(response.body)['predictions'];
          _showStartSuggestions = true;
          _showEndSuggestions = false;
        } else {
          _endPlaceList = json.decode(response.body)['predictions'];
          _showEndSuggestions = true;
          _showStartSuggestions = false;
        }
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  void _onSuggestionTap(Map<String, dynamic> place, bool isStart) async {
    setState(() {
      if (isStart) {
        _startLocationController.text = place['description'];
        _showStartSuggestions = false;
        _selectedStartLocation = place['description'];
      } else {
        _endLocationController.text = place['description'];
        _showEndSuggestions = false;
        _selectedEndLocation = place['description'];
      }
    });

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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _startLocationController,
            decoration: const InputDecoration(
              labelText: "Start Address",
              border: OutlineInputBorder(),
            ),
          ),
          if (_showStartSuggestions)
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _startPlaceList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_startPlaceList[index]["description"]),
                  onTap: () => _onSuggestionTap(_startPlaceList[index], true),
                );
              },
            ),
          const SizedBox(height: 10),
          TextField(
            controller: _endLocationController,
            decoration: const InputDecoration(
              labelText: "End Address",
              border: OutlineInputBorder(),
            ),
          ),
          if (_showEndSuggestions)
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _endPlaceList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_endPlaceList[index]["description"]),
                  onTap: () => _onSuggestionTap(_endPlaceList[index], false),
                );
              },
            ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: "Price",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            controller: _priceController,
            keyboardType: TextInputType.number,
            onChanged: (val) => _price = double.tryParse(val) ?? 0,
          ),
          SizedBox(height: 16),
          MultiSelectDialogField(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            items: daysOfWeek.map((e) => MultiSelectItem(e, e)).toList(),
            title: Text("Days of Travel"),
            onConfirm: (values) => setState(() => selectedDaysTab2 = values),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              if (_selectedStartLocation != null &&
                  _selectedEndLocation != null &&
                  _selectedStartLocation != _selectedEndLocation) {
                // Perform submission logic here
                print('Start: $_selectedStartLocation');
                print('End: $_selectedEndLocation');
                print('Price: $_price');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          'Please select different start and end locations')),
                );
              }
            },
            child: Text("Submit"),
          )
        ],
      ),
    );
  }
}
