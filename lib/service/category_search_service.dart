import 'dart:convert';

import 'package:buga/Provider/provider.dart';
import 'package:buga/constant/global_variable.dart';
import 'package:buga/route/navigation.dart';
import 'package:buga/screens/emergency_cont.dart';
import 'package:flutter/widgets.dart';

import 'all_endpoints.dart';
import 'package:http/http.dart' as http;

class CategoriesSearch {
  static Future<Map<String, dynamic>?> _fetchData(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      final decodedData = json.decode(response.body);
      final message = decodedData['message'];

      if (response.statusCode == 200 || response.statusCode == 201) {
        // here and print then here
        List<Map<String, dynamic>> categoryList = [];

        if (decodedData['data'] is List) {
          List<Map<String, dynamic>> dataList =
              List<Map<String, dynamic>>.from(decodedData['data']);

          for (var item in dataList) {
            categoryList.add({
              'city': item['address']?['city'] ?? "City not available",
              'id': item['id'],
              'state': item['address']?['state'] ?? "State not available",
            });

            String id = item['id'];
            String city = item['address']?['city'] ?? "City not available";
            String state = item['address']?['state'] ?? "State not available";
            debugPrint('ID: $id, City: $city, State: $state');
          }

          // Pass the data to the provider
          // You'll need a ref to update the provider
          provider
              .read(CategorySearch.getCategoryListProvider.notifier)
              .updateCategoryList(categoryList);
          debugPrint('Response from $endpoint: $dataList');
          navigateTo(EmergencyContactForm());
        }
        debugPrint('Response from $endpoint: $decodedData');
        provider.read(CategorySearch.searchUpdate.notifier).state = 'No match';
        return decodedData;
      } else {
        debugPrint(
            'Error fetching data from $endpoint. Status code: ${response.statusCode}');
        provider.read(CategorySearch.searchUpdate.notifier).state = message;
        return null;
      }
    } catch (e) {
      debugPrint('Exception fetching data from $endpoint: $e');
      provider.read(CategorySearch.searchUpdate.notifier).state = 'No match';
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getStudentUniversities() {
    return _fetchData(Endpoints.universitiesEndpoint);
  }

  static Future<Map<String, dynamic>?> getResidentSearch() {
    return _fetchData(Endpoints.estateEndpoint);
  }

  static Future<Map<String, dynamic>?> getOrganizationSearch() {
    return _fetchData(Endpoints.organizationEndpoint);
  }
}
