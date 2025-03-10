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
              'x-api-key': '',
            },
            body: jsonEncode(loginModel.toJson()),
          )
          .timeout(const Duration(seconds: 50));

      final Map<String, dynamic> responseData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = responseData['data'];
        String token = data['token'];
        String id = data['id'];
        String name = data['name'];
        String email = data['email'];
        String phoneNumber = data['phoneNumber'];
        String passengerType = data['passengerType'];
        String driverCategory = data['driverCategory'];
        String userType = data['userType'];

        Map<String, dynamic> organization = data['organization'];
        String organizationId = organization['id'];
        String organizationName = organization['name'];
        Map<String, dynamic> organizationAddress = organization['address'];
        String organizationStreetAddress = organizationAddress['streetAddress'];
        String organizationCity = organizationAddress['city'];
        String organizationState = organizationAddress['state'];

        // store data on local storage
        Pref.setStringValue(tokenKey, token);
        Pref.setStringValue(userIdKey, id);
        Pref.setStringValue(userNameKey, name);
        Pref.setStringValue(userMailKey, email);
        Pref.setStringValue(userTypeKey, userType);

        // navigate to home page
        provider.read(loadingAnimationSpinkit.notifier).state = false;
        pushReplacementScreen(HomeScreen());
      } else {
        EndpointUpdateUI.updateUi('Unexpected error occur try again');

        debugPrint('Error $responseData');
        EndpointUpdateUI.updateUi('Error');
      }
    } on TimeoutException catch (_) {
      EndpointUpdateUI.updateUi(
          'Time-out please check your internet connection');
    } on HandshakeException catch (_) {
      EndpointUpdateUI.updateUi('Internet connection not stable');
    } on SocketException catch (_) {
      EndpointUpdateUI.updateUi('Internet connection its needed');
    } catch (e) {
      EndpointUpdateUI.updateUi('Unexpected error occur try again');
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
