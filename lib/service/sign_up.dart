import 'dart:async';
import 'package:buga/viewmodels/register_model.dart';
import 'package:http/http.dart' as http;
import 'service_export.dart';

class SignUpService {
  static Future<Map<String, dynamic>?> userSignUp(
      RegisterModel signUpModel) async {
    try {
      final response = await http
          .post(
            Uri.parse(Endpoints.loginEndpoint),
            headers: {
              'Content-Type': 'application/json',
              'x-api-key': '',
            },
            body: jsonEncode(signUpModel.toJson()),
          )
          .timeout(const Duration(seconds: 50));

      final Map<String, dynamic> responseData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {}
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
