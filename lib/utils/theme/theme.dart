import 'package:flutter/material.dart';
import 'package:shop/constants.dart';
import 'package:shop/utils/theme/custom_themes/app_barTheme.dart';
import 'package:shop/utils/theme/custom_themes/bottom_sheet.dart';
import 'package:shop/utils/theme/custom_themes/text_field.dart';
import 'package:shop/utils/theme/custom_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();
  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: kprimaryColor,
      scaffoldBackgroundColor: kcontentColor,
      fontFamily: 'Poppins',
      textTheme: TTextTheme.lightTextTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: kcontentColor,
          backgroundColor: kprimaryColor,
          disabledForegroundColor: Colors.grey,
          disabledBackgroundColor: Colors.grey,
          side: BorderSide(color: kprimaryColor),
          padding: EdgeInsets.symmetric(vertical: 18),
          textStyle: TextStyle(
              fontSize: 16, color: kcontentColor, fontWeight: FontWeight.bold),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      appBarTheme: TAppBarTheme.lighteAppBarTheme,
      bottomSheetTheme: TBottomSheet.lightBottomSheetTheme,
      inputDecorationTheme: TTextField.lightInputDecorationTheme);
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: kprimaryColor,
    scaffoldBackgroundColor: Colors.black,
    fontFamily: 'Poppins',
    textTheme: TTextTheme.darkTextTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: kcontentColor,
        backgroundColor: kprimaryColor,
        disabledForegroundColor: Colors.grey,
        disabledBackgroundColor: Colors.grey,
        side: BorderSide(color: kprimaryColor),
        padding: EdgeInsets.symmetric(vertical: 18),
        textStyle: TextStyle(
            fontSize: 16, color: kcontentColor, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    bottomSheetTheme: TBottomSheet.darkBottomSheetTheme,
    inputDecorationTheme: TTextField.darkInputDecorationTheme,
  );
}
