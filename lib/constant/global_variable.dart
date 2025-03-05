import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
String usrPhoneNumberKey = 'number';
String passengerTypeKey = 'passengerType';
String driverCategoryKey = 'driverCategory';
String userTypeKey = 'userType';

