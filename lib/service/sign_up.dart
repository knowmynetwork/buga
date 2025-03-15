import 'dart:async';
import 'package:buga/screens/global_screens/loader_screen.dart';
import 'package:http/http.dart' as http;
import 'service_export.dart';

class SignUpService {
  static Future<Map<String, dynamic>?> getResponse(
      String getEndpoint, var getModel) async {
    debugPrint('registering User now');
    try {
      final response = await http
          .post(
            Uri.parse(Endpoints.loginEndpoint),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(getModel.toJson()),
          )
          .timeout(const Duration(seconds: 50));

      final Map<String, dynamic> responseData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        provider.read(loadingAnimationSpinkit.notifier).state = false;
        pushReplacementScreen(LoadingScreen());
        debugPrint('response Body its ::::::: $responseData');
      } else {
        debugPrint('Error $responseData');
        EndpointUpdateUI.updateUi('Unexpected error occur try again');
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

  static Future<Map<String, dynamic>?> driverSignUp(RegisterDriverModel data) {
    return getResponse(Endpoints.driverSignUp, data);
  }

  static Future<Map<String, dynamic>?> riderSignUp(RegisterRiderModel data) {
    return getResponse(Endpoints.passengerSignUp, data);
  }
}
