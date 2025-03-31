
import 'package:buga/constant/global_variable.dart';
import 'package:buga/local_storage/pref.dart';
import 'package:dio/dio.dart';
import 'package:buga/service/all_endpoints.dart';
import 'package:buga/viewmodels/drivermodel/saved_place.dart';

class SavedPlaceRepository {
  final Dio dio;

  SavedPlaceRepository({required this.dio});

  Future<List<SavedPlace>> getSavedPlaces() async {
    final token = await Pref.getStringValue(tokenKey);

    try {
      final response = await dio.get(
        Endpoints.getSavedAddress,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print('this is response $response');
      return (response.data['data'] as List)
          .map((e) => SavedPlace.fromJson(e))
          .toList();
    } catch (e) {
      print('thisss is $e');
      throw Exception("Failed to load saved places");
    }
  }

  Future<void> addSavedPlace(SavedPlace place) async {
    final token = await Pref.getStringValue(tokenKey);

    try {
      await dio.post(
        Endpoints.addSavedAddress,
        data: place.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } catch (e) {
      print('thisss is $e');
      throw Exception("Failed to add saved place");
    }
  }

  Future<void> deleteSavedPlace(String id) async {
    final token = await Pref.getStringValue(tokenKey);

    try {
      await dio.delete(
        Endpoints.deleteSavedAddress + id,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } catch (e) {
      throw Exception("Failed to delete saved place");
    }
  }
}
