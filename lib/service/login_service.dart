import 'dart:convert';

import 'package:buga/service/all_endpoints.dart';
import 'package:buga/viewmodels/drivermodel/auth_model.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static Future<Map<String, dynamic>?> userLogin(LoginModel loginModel) async {
    final response = await http
        .post(
          Uri.parse(Endpoints.loginEndpoint),
          headers: {
            'Content-Type': 'application/json',
            'x-api-key': '',
          },
          body: jsonEncode(loginModel.toJson()),
        )
        .timeout(const Duration(seconds: 50));

    if (response.statusCode == 200) {
    } else {}
    return null;
  }
}
