


import 'package:flutter/material.dart';

Widget materialButton({
  required Widget widget,
  required Color buttonBkColor,
  required VoidCallback onPres,
  double borderRadiusSize = 18.0,
  double? width,
  double? height,
}) {
  return SizedBox(
    width: width,
    height: height,
    child: MaterialButton(
      onPressed: onPres,
      color: buttonBkColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusSize),
      ),
      child: Center(child: widget),
    ),
  );
}

Widget outlineButton({
  required Widget child,
  required VoidCallback onPressed,
  double borderRadiusSize = 18.0,
  Color borderColor = const Color.fromARGB(255, 61, 48, 102),
  double? width,
  double? height,
}) {
  return SizedBox(
    width: width,
    height: height,
    child: OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: borderColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusSize),
        ),
      ),
      child: Center(child: child),
    ),
  );
}

// button for cancel across the app
Widget cancelButton(VoidCallback userTap) {
  return GestureDetector(
    onTap: userTap,
    child: Icon(Icons.cancel_outlined),
  );
}
