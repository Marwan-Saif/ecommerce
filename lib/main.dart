// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors

import 'package:e_commerce_app/homeScreen.dart';
import 'package:e_commerce_app/layouts/on_boarding/on_boarding_screen.dart';
import 'package:e_commerce_app/modules/Login/login_screen.dart';
import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:e_commerce_app/shared/cubit/cubit.dart';
import 'package:e_commerce_app/shared/network/local/cach_helper.dart';
import 'package:e_commerce_app/shared/network/remote/dio_helper.dart';
import 'package:e_commerce_app/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  DioHelper.init();
  WidgetsFlutterBinding.ensureInitialized();
  await CachHelper.init();
  bool onBoarding = CachHelper.getData(key: 'onBoarding');
  token = CachHelper.getData(key: 'token');
  // ignore: avoid_print
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
  const MyApp({super.key, required this.onBoarding, required this.widget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context) => ShopCubit()
                ..getHomeData()
                ..getCategoriesData()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
          title: 'Shop',
          home: widget,
        ));
  }
}
