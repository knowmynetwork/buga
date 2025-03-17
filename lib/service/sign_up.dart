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
        'User Driver data ist ::: email :: ${data.email} \n name :: ${data.name} \n phoneNumber :: ${data.number} \n Auth phoneNumber :: ${data.altNumber} \n password :: ${data.password} \n Otp :: ${data.otp} \n category :: ${data.category}');

    return getResponse(Endpoints.passengerSignUp, data);
  }
}



// I/flutter (11903): User Driver data ist ::: email :: isaiahshell2010@gmail.com 
// I/flutter (11903):  name :: Prince12 
// I/flutter (11903):  phoneNumber :: 0802876372 
// I/flutter (11903):  Auth phoneNumber :: 0902876372 
// I/flutter (11903):  password :: @Password11 
// I/flutter (11903):  Otp :: 0995 
// I/flutter (11903):  category :: Car
// I/flutter (11903): registering User now
// I/flutter (11903): status code :::::: 200
// I/flutter (11903): response Body its ::::::: {data: {token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiaXNhaWFoc2hlbGwyMDEwQGdtYWlsLmNvbSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcHJpbWFyeXNpZCI6IjAxOTVhNTNkLTEyZGMtNzIyOC05YmE1LWExNDcwOTFjMzdiZCIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2dpdmVubmFtZSI6IkRyaXZlciIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWVpZGVudGlmaWVyIjoiQ2FyIiwiZXhwIjoxNzQyMjQxMzA4LCJpc3MiOiIqIiwiYXVkIjoiKiJ9.nNDvyaWpjmpDOovbdHlbLQnOohFVlGB0Yeej--IcK_k, name: Prince12, email: isaiahshell2010@gmail.com, phoneNumber: 0802876372, alternativePhoneNumber: 0902876372, organization: null, passengerType: null, driverCategory: Car, address: {streetAddress: Harmoney road, city: Agbara, state: Ogun}, estate: null, university: null, userType: Driver, lastLogin: 2025-03-17T18:55:08.3283012Z, lastPasswordReset: null, lastPasswordChange: null, 