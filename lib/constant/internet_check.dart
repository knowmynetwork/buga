import 'package:internet_connection_checker/internet_connection_checker.dart';


// Check user internet connection across app
class InternetChecks {
  static Future<void> loginInternetCheck() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result) {
   
    } else {
    }
  }
}
