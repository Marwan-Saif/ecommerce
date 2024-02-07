// import 'package:flutter/material.dart';
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

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

Widget defaultButton({
  double width = double.infinity,
  double? height,
  Color background = Colors.blue,
  bool isUpperCase = false,
  double radius = 0.0,
  required Function() function,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        onPressed: function,
        child: AutoSizeText(
          isUpperCase ? text.toUpperCase() : text,
          maxLines: 1,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextField({
  required TextEditingController Controller,
  ValueChanged? onSubmit,
  ValueChanged? onChang,
  required String LableText,
  IconData? prefix,
  required TextInputType Type,
  required FormFieldValidator validator,
  String obScureChar = '*',
  bool isPassword = false,
  IconData? suffix,
  GestureTapCallback? ontap,
  VoidCallback? suffixPressed,
}) =>
    TextFormField(
      controller: Controller,
      onFieldSubmitted: onSubmit,
      onChanged: onChang,
      keyboardType: Type,
      obscuringCharacter: obScureChar,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: LableText,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            suffix,
          ),
          onPressed: suffixPressed,
        ),
      ),
      onTap: ontap,
      validator: validator,
    );
Widget defaultTextButton({
  required VoidCallback function,
  required String text,
  double? size,
}) =>
    TextButton(
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(fontSize: size),
        ));

//print all of the content
void printAll(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

