import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

bool get isCupertinoTheme => Platform.isIOS || Platform.isMacOS;

ThemeData generateAppTheme(BuildContext context) {
  const colorScheme = ColorScheme.light(
    brightness: Brightness.light,
    primary: Color(0xffD13827),
  );

  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
    colorScheme: colorScheme,
    brightness: Brightness.light,
   //primaryColorBrightness: Brightness.dark,
    primaryColor: const Color(0xffd13827),
    primaryColorLight: const Color(0xffff6c51),
    primaryColorDark: const Color(0xff980000),
    hintColor: const Color(0xffd13827),
    bottomSheetTheme: const BottomSheetThemeData(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
    ),
    dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(errorMaxLines: 4),
    cardTheme: const CardTheme(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32.0,vertical: 16.0),
        elevation: 0,
        backgroundColor: Color(0xffD13827),shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.all(
          Radius.circular(24.0),
        ),
      ),),
    ),
    buttonTheme: const ButtonThemeData(
      height: 50.0,
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24.0),
        ),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      side: BorderSide(color: Colors.grey,width: 2.0),
      checkColor:MaterialStateProperty.all<Color>(Colors.white),
      fillColor: MaterialStateProperty.all<Color>(Color(0xffD13827)),
    ),
    buttonBarTheme: const ButtonBarThemeData(
      alignment: MainAxisAlignment.center,
      buttonHeight: 45.0,
      buttonTextTheme: ButtonTextTheme.primary,
    ),
    snackBarTheme: const SnackBarThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      behavior: SnackBarBehavior.floating,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xffD13827),
      foregroundColor: Colors.white,
    ),
    indicatorColor: Colors.white,
  );
}
