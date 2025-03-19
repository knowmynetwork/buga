import 'dart:async';
import 'package:buga/screens/global_screens/loader_screen.dart';
import 'package:http/http.dart' as http;
import 'service_export.dart';

class SignUpService {
  static Future<Map<String, dynamic>?> getResponse(
      String getEndpoint, var getModel) async {
    debugPrint('registering User now on this endpoint \n $getEndpoint');

    try {
      final response = await http
          .post(
            Uri.parse(getEndpoint),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(getModel.toJson()),
          )
          .timeout(const Duration(seconds: 50));

      final Map<String, dynamic> responseData = json.decode(response.body);
      final message = responseData['message'];
      debugPrint('status code :::::: ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        EndpointUpdateUI.updateUi('Registration successful');
        debugPrint('response Body its ::::::: $responseData');
        pushReplacementScreen(LoadingScreen());
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
      EndpointUpdateUI.updateUi('Unexpected error occur try again');
    }
    return null;
  }

  static Future<Map<String, dynamic>?> driverSignUp(RegisterDriverModel data) {
    debugPrint(
        'User Driver data ist ::: email :: ${data.email} \n name :: ${data.name} \n phoneNumber :: ${data.number} \n Auth phoneNumber :: ${data.altNumber} \n password :: ${data.password} \n Otp :: ${data.otp} \n category :: ${data.category}');
    return getResponse(Endpoints.driverSignUp, data);
  }

  static Future<Map<String, dynamic>?> riderSignUp(RegisterRiderModel data) {
    debugPrint(
        'User Rider data ist ::: email :: ${data.email} \n name :: ${data.name} \n phoneNumber :: ${data.number} \n Auth phoneNumber :: ${data.altNumber} \n password :: ${data.password} \n Otp :: ${data.otp} \n category :: ${data.category}');

    return getResponse(Endpoints.passengerSignUp, data);
  }
}

