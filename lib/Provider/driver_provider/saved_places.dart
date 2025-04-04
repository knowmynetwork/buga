
// Dio Provider
import 'package:dio/dio.dart';
import 'package:buga/service/driver_service/saved_place_repository.dart';
import 'package:buga/viewmodels/drivermodel/saved_place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../driver/use_cases/saved_places.dart';

final dioProvider = Provider((ref) => Dio());

// Repository Provider
final savedPlaceRepositoryProvider = Provider((ref) {
  return SavedPlaceRepository(dio: ref.read(dioProvider));
});

// Get Saved Places Provider
final getSavedPlacesProvider = FutureProvider<List<SavedPlace>>((ref) async {
  final repository = ref.read(savedPlaceRepositoryProvider);
  return GetSavedPlaces(repository).call();
});

// Add Saved Place Provider
final addSavedPlaceProvider = Provider((ref) {
  final repository = ref.read(savedPlaceRepositoryProvider);
  return AddSavedPlace(repository);
});

// Delete Saved Place Provider
final deleteSavedPlaceProvider = Provider((ref) {
  final repository = ref.read(savedPlaceRepositoryProvider);
  return DeleteSavedPlace(repository);
});