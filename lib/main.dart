import 'package:e_commerce_app/layouts/on_boarding/on_boarding_screen.dart';
import 'package:e_commerce_app/shared/styles/styles.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      title: 'Shop',
      home: OnBoardingScreen(),
    );
  }
}
