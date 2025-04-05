import 'package:buga/constant/global_variable.dart';
import 'package:buga/local_storage/pref.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../viewmodels/drivermodel/add_route_address.dart';
import '../../viewmodels/drivermodel/add_route_model.dart';
import '../../viewmodels/drivermodel/get_routes.dart';
import '../all_endpoints.dart';

class RouteRepository {
  final Dio dio;

  RouteRepository({required this.dio});

  Future<List<RouteData>> getRoutes() async {
    final token = await Pref.getStringValue(tokenKey);

    try {
      final response = await dio.get(Endpoints.getDriverRoutes,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
      return (response.data['data'] as List)
          .map((e) => RouteData.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch routes');
    }
  }

  Future<void> createRoute(RouteModel routeResponse) async {
    final token = await Pref.getStringValue(tokenKey);
    print('check after ${routeResponse.toJson()}');
    try {
      await dio.post(
        Endpoints.addDriverRoutes,
        data: routeResponse.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
    } catch (e) {
      if (e is DioException) {
        print('Error: ${e.response?.data}');
      } else {
        print('Unexpected error: $e');
      }
      print('error is $e...');
      throw Exception("Failed to add saved place");
    }
  }

  Future<void> createRouteWithAddress(RouteAddress routeAddress) async {
    final token = await Pref.getStringValue(tokenKey);
    try {
      await dio.post(
        Endpoints.addDriverRoutesithAddress,
        data: routeAddress.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
    } catch (e) {
      if (e is DioException) {
        print('Error: ${e.response?.data}');
      } else {
        print('Unexpected error: $e');
      }
      throw Exception("Failed to add saved place");
    }
  }
}
