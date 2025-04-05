import '../service/driver_service/route_repository.dart';
import '../viewmodels/drivermodel/add_route_address.dart';
import '../viewmodels/drivermodel/add_route_model.dart';
import '../viewmodels/drivermodel/get_routes.dart';

class GetDriverRoutes {
  final RouteRepository repository;
  GetDriverRoutes(this.repository);

  Future<List<RouteData>> call() async {
    return await repository.getRoutes();
  }
}

class AddDriverRoutes {
  final RouteRepository repository;
  AddDriverRoutes(this.repository);

  Future<void> call(RouteModel route) async {
    await repository.createRoute(route);
  }
}

class AddDriverRoutesAddress {
  final RouteRepository repository;
  AddDriverRoutesAddress(this.repository);

  Future<void> call(RouteAddress route) async {
    await repository.createRouteWithAddress(route);
  }
}


