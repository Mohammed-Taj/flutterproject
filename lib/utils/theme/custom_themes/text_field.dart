import 'package:flutter/material.dart';

class TTextField {
  TTextField._();
  static final InputDecorationTheme lightInputDecorationTheme =
      InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    labelStyle: TextStyle().copyWith(color: Colors.black, fontSize: 14),
    hintStyle: TextStyle().copyWith(
      color: Colors.grey,
    ),
    errorStyle: TextStyle().copyWith(fontStyle: FontStyle.normal),
    enabledBorder: OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.grey[700]!,
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(
        color: Colors.black12,
        width: 1,
      ),
    ),
  );
  static final InputDecorationTheme darkInputDecorationTheme =
      InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    labelStyle: TextStyle().copyWith(color: Colors.white, fontSize: 14),
    hintStyle: TextStyle().copyWith(
      color: Colors.white,
    ),
    errorStyle: TextStyle().copyWith(fontStyle: FontStyle.normal),
    enabledBorder: OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.grey[700]!,
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(
        color: Colors.white12,
        width: 1,
      ),
    ),
  );
}
