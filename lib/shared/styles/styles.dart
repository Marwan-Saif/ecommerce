import 'package:e_commerce_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:fproject/shared/styles/colors.dart';
// import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme=ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: const Color(0xff333739),
  appBarTheme: const AppBarTheme(
    color:Color(0xff333739),
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor:Color(0xff333739),
      statusBarIconBrightness: Brightness.light,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor:defaultColor,
    unselectedItemColor: Colors.grey,
    backgroundColor: Color(0xff333739),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    subtitle1: TextStyle(
      fontSize: 14.0,
      color: Colors.white,
      height: 1.3,
      fontWeight: FontWeight.bold,
    )
  ) ,
  fontFamily: 'Jannah',
);
ThemeData lightTheme=ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor:defaultColor,
    unselectedItemColor: Colors.grey,
    backgroundColor: Colors.white,

  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
      subtitle1: TextStyle(
        fontSize: 14.0,
        height: 1.3,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
  ) ,
  fontFamily: 'Jannah',

);