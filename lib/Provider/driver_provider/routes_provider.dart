import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../service/driver_service/route_repository.dart';
import '../../use_cases/driver_routes.dart';
import '../../viewmodels/drivermodel/get_routes.dart';

final dioProvider = Provider((ref) => Dio());

final routesRepositoryProvider = Provider((ref) {
  return RouteRepository(dio: ref.read(dioProvider));
});

final addRoutesProvider = Provider((ref) {
  final repository = ref.read(routesRepositoryProvider);
  return AddDriverRoutes(repository);
});
final getRoutesProvider = FutureProvider<List<RouteData>>((ref) async {
  final repository = ref.read(routesRepositoryProvider);
  return GetDriverRoutes(repository).call();
});
