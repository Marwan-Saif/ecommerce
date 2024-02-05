import 'package:e_commerce_app/modules/login_screen.dart';
import 'package:flutter/material.dart';

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));
void navigateWithReplacment(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false);
