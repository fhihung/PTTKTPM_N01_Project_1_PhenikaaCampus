import 'package:flutter/material.dart';

class Pallete {
  static const Color backgroundColor = Color.fromRGBO(20, 27, 39, 1);
  static const Color secondaryColor = Color.fromRGBO(29, 40, 58, 1);
  static const Color searchBarColor = Color.fromRGBO(32, 35, 39, 1);
  static const Color blueColor = Color.fromRGBO(29, 155, 240, 1);
  static const Color whiteColor = Color.fromRGBO(255, 255, 255, 1);
  static const Color greyColor = Colors.grey;
  static const Color redColor = Color.fromRGBO(249, 25, 127, 1);
  static const Color textformfieldColor = Color.fromRGBO(39, 54, 78, 1);

  //Linear Gradient
  static const LinearGradient cardColor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xffFFE072), Color(0xffFEBE19)],
  );
}
