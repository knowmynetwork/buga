import 'dart:async';
import 'package:buga/riders/onboarding/driver_category.dart';
import 'package:http/http.dart' as http;
import 'service_export.dart';

class GetOtpService {
  static final isRiderAccountClick = StateProvider((ref) => false);

  static Future<Map<String, dynamic>?> getOtp(GetEmailModel otpEmail) async {
    debugPrint('getting otp on ${otpEmail.eMail}');
    // call all category endpoints at this stage to generate all category search from user

    try {
      final response = await http.post(
        Uri.parse(Endpoints.getEmailOtp),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(otpEmail.toJson()),
      );

      debugPrint(' Response body ${response.body}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        debugPrint(
            ' Response its $responseData , status code ${response.statusCode}');
        provider.read(loadingAnimationSpinkit.notifier).state = false;

        navigateTo(RiderOtpView(
          userEmail: otpEmail,
        ));
      } else {
        debugPrint('Error ${response.body}');
        EndpointUpdateUI.updateUi('An error occurred please try again');
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

// verify the otp
class VerifyOtpService {
  static Future<Map<String, dynamic>?> verifyOtp(
      VerifiedEmailOtpModel verifyOtpEmail) async {
    debugPrint(
        'email its : ${verifyOtpEmail.eMail}   : Token OTP its :${verifyOtpEmail.tokenOtp}');
    try {
      final response = await http.post(
        Uri.parse(Endpoints.confirmEmailOtp),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(verifyOtpEmail.toJson()),
      );

      debugPrint(' Response body :: ${response.body}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        debugPrint(
            ' Response its $responseData , status code ${response.statusCode}');
        provider.read(loadingAnimationSpinkit.notifier).state = false;

        provider.read(GetOtpService.isRiderAccountClick)
            ? pushReplacementScreen(RiderCategory())
            : pushReplacementScreen(DriverCategory());

      } else {
        debugPrint('Error ${response.body}');
        EndpointUpdateUI.updateUi('An error occurred please try again');
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
