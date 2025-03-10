import 'all_endpoints.dart';
import 'package:http/http.dart' as http;

class CategoriesSearch {
  static Future<Map<String, dynamic>?> getStudentUniversities() async {
    final response = await http.get(
      Uri.parse(Endpoints.universitiesEndpoint),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    statusCode(response);
  }

  static Future<Map<String, dynamic>?> getResidentSearch() async {
    final response = await http.get(
      Uri.parse(Endpoints.estateEndpoint),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    statusCode(response);
  }

  static Future<Map<String, dynamic>?> getOrganizationSearch() async {
    final response = await http.get(
      Uri.parse(Endpoints.organizationEndpoint),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    statusCode(response);
  }

  static statusCode(var responseCode) {
    if (responseCode == 200 || responseCode == 201) {

    }else{

    }
  }
}
