import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map_model.dart';

class Prediction {
  final String description;
  final String placeId;
  final String placeArea;

  Prediction(
      {required this.description,
      required this.placeId,
      required this.placeArea});

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      description: json['description'],
      placeId: json.containsKey('place_id') ? json['place_id'] : '',
      placeArea: json['structured_formatting']?['secondary_text'] ?? '',
    );
  }
}

class PredictionNotifier extends StateNotifier<List<Prediction>> {
  PredictionNotifier() : super([]);

  void setPredictions(List<Prediction> predictions) {
    state = predictions;
  }
}

final predictionProvider =
    StateNotifierProvider<PredictionNotifier, List<Prediction>>((ref) {
  return PredictionNotifier();
});

class SearchLocation {
  late GoogleMapController mapController;
  late LatLng initialPosition;
  final String mapApiKey;

  SearchLocation({required this.mapApiKey});

  Future<void> getCurrentLocation(WidgetRef ref) async {
    final getUserLatAndLong = ref.watch(UserLatLong.userLatLongProvider);
    final getUserSearch = ref.watch(UserLatLong.userLocationSearch);

    var latAndLog =
        LatLng(getUserLatAndLong.userLat, getUserLatAndLong.userLong);

    initialPosition = latAndLog;
    debugPrint('user Search $getUserSearch');

    var uri = Uri.https(
        'maps.googleapis.com', '/maps/api/place/queryautocomplete/json', {
      'input': getUserSearch,
      'location': '${latAndLog.latitude},${latAndLog.longitude}',
      'offset': '3',
      'radius': '500',
      'key': mapApiKey,
    });

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      final Map<String, dynamic> responseData = json.decode(response.body);
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      String prettyprint = encoder.convert(responseData);

      debugPrint('Json response $prettyprint');
      var status = jsonResponse['status'];
      debugPrint('Status its $status');
      if (status == 'OK' || status == 'ZERO_RESULTS') {
        final List<dynamic> predictionsJson = responseData['predictions'];
        List<Prediction> predictions =
            predictionsJson.map((json) => Prediction.fromJson(json)).toList();
        ref.read(predictionProvider.notifier).setPredictions(predictions);
        debugPrint(
            'Updated predictions state with ${predictions.length} items');
      } else {
        debugPrint('Status: $status');
      }
    } else {
      debugPrint('Request failed with status: ${response.statusCode}');
    }
  }
}
