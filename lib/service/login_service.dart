import 'dart:async';
import 'package:http/http.dart' as http;
import 'service_export.dart';

class LoginService {
  static Future<Map<String, dynamic>?> userLogin(LoginModel loginModel) async {
    debugPrint('trying to login now');
    try {
      final response = await http
          .post(
            Uri.parse(Endpoints.loginEndpoint),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(loginModel.toJson()),
          )
          .timeout(const Duration(seconds: 50));

      final Map<String, dynamic> responseData = json.decode(response.body);
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      String prettyprint = encoder.convert(responseData);
      final message = responseData['message'];

      debugPrint(
          'Response code ${response.statusCode} \n  Response Data:\n$prettyprint');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = responseData['data'];
        String token = data['token'] ?? '';
        String id = data['id'] ?? '';
        String name = data['name'] ?? '';
        String email = data['email'] ?? '';
        String phoneNumber = data['phoneNumber'] ?? '';
        String passengerType = data['passengerType'] ?? '';
        String driverCategory = data['driverCategory'] ?? '';
        String userType = data['userType'] ?? '';

        // Handle organization data safely
        Map<String, dynamic>? organization = data['organization'];
        String organizationId = '';
        String organizationName = '';
        String organizationStreetAddress = '';
        String organizationCity = '';
        String organizationState = '';

        if (organization != null) {
          organizationId = organization['id'] ?? '';
          organizationName = organization['name'] ?? '';

          // Handle address separately since it's null in the response
          Map<String, dynamic>? organizationAddress = organization['address'];
          if (organizationAddress != null) {
            organizationStreetAddress =
                organizationAddress['streetAddress'] ?? '';
            organizationCity = organizationAddress['city'] ?? '';
            organizationState = organizationAddress['state'] ?? '';
          }
        }

        // store data on local storage
        Pref.setStringValue(tokenKey, token);
        Pref.setStringValue(userIdKey, id);
        Pref.setStringValue(userNameKey, name);
        Pref.setStringValue(userMailKey, email);
        Pref.setStringValue(userTypeKey, userType);
        Pref.setStringValue(userPhoneNumberKey, phoneNumber);

        // navigate to home page
        provider.read(loadingAnimationSpinkit.notifier).state = false;
        debugPrint('Login successful');
        pushReplacementScreen(HomeScreen());
      } else {
        debugPrint('Error $responseData');
        EndpointUpdateUI.updateUi(message);
      }
    } on TimeoutException catch (_) {
      EndpointUpdateUI.updateUi(
          'Time-out please check your internet connection');
    } on HandshakeException catch (_) {
      EndpointUpdateUI.updateUi('Internet connection not stable');
    } on SocketException catch (_) {
      EndpointUpdateUI.updateUi('Internet connection its needed');
    } catch (e) {
      EndpointUpdateUI.updateUi('Unexpected error $e');
      debugPrint('terminal error $e');
    }
    return null;
  }
}

class EndpointUpdateUI {
  static updateUi(String message) {
    provider.read(loadingAnimationSpinkit.notifier).state = false;
    SnackBarView.showSnackBar(message);
  }
}





