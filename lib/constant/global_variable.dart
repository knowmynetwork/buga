import 'package:flutter/widgets.dart';

//////////////////////////////////////////
GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
BuildContext context = navigationKey.currentContext!;
var provider;

/////////////////////////////
// Storage variables
String tokenKey = 'token';
String userIdKey = 'id';
String userNameKey = 'name';
String userMailKey = 'mail';
String userPassKey = 'password';
String userPhoneNumberKey = 'number';
String passengerTypeKey = 'passengerType';
String driverCategoryKey = 'driverCategory';
String userTypeKey = 'userType';
String mapKey = 'AIzaSyBA9E4DMUWlvnU';
