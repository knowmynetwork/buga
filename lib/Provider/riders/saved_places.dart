import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../riders/use_cases/saved_places.dart';
import '../../service/riders/saved_place_repository.dart';
import '../../viewmodels/ridermodel/saved_place.dart';

// Dio Provider
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