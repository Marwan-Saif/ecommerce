import 'package:e_commerce_app/homeScreen.dart';
import 'package:e_commerce_app/layouts/on_boarding/on_boarding_screen.dart';
import 'package:e_commerce_app/modules/Login/login_screen.dart';
import 'package:e_commerce_app/shared/network/local/cach_helper.dart';
import 'package:e_commerce_app/shared/network/remote/dio_helper.dart';
import 'package:e_commerce_app/shared/styles/styles.dart';
import 'package:flutter/material.dart';

void main() async {
  DioHelper.init();
  WidgetsFlutterBinding.ensureInitialized();
  await CachHelper.init();
  bool onBoarding = CachHelper.getData(key: 'onBoarding');
  String? token = CachHelper.getData(key: 'token');
  print(onBoarding);
  Widget widget;

  if (onBoarding != null) {
    if (token != null) {
      widget = HomeScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    onBoarding: onBoarding,
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool onBoarding;
  final Widget widget;
  const MyApp({required this.onBoarding, required this.widget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      title: 'Shop',
      home: widget,
    );
  }
}
