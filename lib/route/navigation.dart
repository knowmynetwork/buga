import 'package:buga/constant/global_variable.dart';
import 'package:flutter/material.dart';

navigateTo(Widget className) {
  Navigator.push<void>(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) => className,
    ),
  );
}

popScreen() {
  Navigator.pop(context);
}

pushScreen(String screenName) {
  Navigator.popAndPushNamed(context, screenName);
}

pushReplacementScreen(Widget screenName) {
  Navigator.pushReplacement(context,
      MaterialPageRoute<void>(builder: (BuildContext context) => screenName));
}
