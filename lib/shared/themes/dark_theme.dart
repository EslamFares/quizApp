import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const dPrimaryColor = Color(0xff192734);
const dSecColor = Color(0xff22303c);

//===================

ThemeData darkTheme() {
  return ThemeData.dark().copyWith(
    primaryColor: Color(0xff192734),
    scaffoldBackgroundColor: Color(0xff192734),
    appBarTheme: AppBarTheme(
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      color: Color(0xff192734),
      centerTitle: true,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Color(0xff192734),
          statusBarIconBrightness: Brightness.light),
    ),
  );
}