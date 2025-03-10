import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'service_export.dart';

class LoginService {
  static Future<Map<String, dynamic>?> userLogin(LoginModel loginModel) async {
    debugPrint('trying to login now');
    try {
      final response = await _sendLoginRequest(loginModel);
      return _handleResponse(response);
    } on TimeoutException {
      EndpointUpdateUI.updateUi(
          'Time-out please check your internet connection');
    } on HandshakeException {
      EndpointUpdateUI.updateUi('Internet connection not stable');
    } on SocketException {
      EndpointUpdateUI.updateUi('Internet connection is needed');
    } catch (e) {
      EndpointUpdateUI.updateUi('Unexpected error occurred, try again');
    }
    return null;
  }

  static Future<http.Response> _sendLoginRequest(LoginModel loginModel) {
    return http
        .post(
          Uri.parse(Endpoints.loginEndpoint),
          headers: {
            'Content-Type': 'application/json',
            'x-api-key': '',
          },
          body: jsonEncode(loginModel.toJson()),
        )
        .timeout(const Duration(seconds: 50));
  }

  static Map<String, dynamic>? _handleResponse(http.Response response) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> data = responseData['data'];
      _storeUserData(data);
      provider.read(loadingAnimationSpinkit.notifier).state = false;
      pushReplacementScreen(HomeScreen());
      return data;
    } else {
      EndpointUpdateUI.updateUi('Unexpected error occurred, try again');
      debugPrint('Error $responseData');
      return null;
    }
  }

  static void _storeUserData(Map<String, dynamic> data) {
    Pref.setStringValue(tokenKey, data['token']);
    Pref.setStringValue(userIdKey, data['id']);
    Pref.setStringValue(userNameKey, data['name']);
    Pref.setStringValue(userMailKey, data['email']);
    Pref.setStringValue(userTypeKey, data['userType']);
  }
}

class EndpointUpdateUI {
  static void updateUi(String message) {
    provider.read(loadingAnimationSpinkit.notifier).state = false;
    SnackBarView.showSnackBar(message);
  }
}
