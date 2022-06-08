import 'package:flutter/material.dart';

class ShadowConstant {
  static BoxShadow boxShadow1 = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    spreadRadius: 0,
    blurRadius: 30,
    offset: const Offset(0, 3),
    blurStyle: BlurStyle.outer, // changes position of shadow
  );

  //   static BoxShadow tableShadow = BoxShadow(
  //   color: Colors.black.withOpacity(0.1),
  //   spreadRadius: 0,
  //   blurRadius: 30,
  //   offset: const Offset(0, 3),
  //   blurStyle: BlurStyle.outer, // changes position of shadow
  // );
}
