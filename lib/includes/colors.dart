// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

const int backgroundPrimary = 0xfff5f5f5;

const int colorPrimary = 0xffCE6F46;

final ThemeData myTheme = ThemeData(
  primarySwatch: const MaterialColor(4291718981, {
    50: Color(0xfffaefeb),
    100: Color(0xfff4e0d7),
    200: Color(0xffeac0ae),
    300: Color(0xffdfa186),
    400: Color(0xffd4825e),
    500: Color(0xffca6335),
    600: Color(0xffa14f2b),
    700: Color(0xff793b20),
    800: Color(0xff512715),
    900: Color(0xff28140b)
  }),
  brightness: Brightness.light,
  primaryColor: const Color(0xffce6f45),
  primaryColorBrightness: Brightness.dark,
  primaryColorLight: const Color(0xfff4e0d7),
  primaryColorDark: const Color(0xff793b20),
  accentColor: const Color(0xffca6335),
  accentColorBrightness: Brightness.dark,
  canvasColor: const Color(0xfffafafa),
  scaffoldBackgroundColor: const Color(0xfffafafa),
  bottomAppBarColor: Color(0xffffffff),
  cardColor: Color(0xffffffff),
  dividerColor: Color(0x1f000000),
  highlightColor: Color(0x66bcbcbc),
  splashColor: Color(0x66c8c8c8),
  selectedRowColor: Color(0xfff5f5f5),
  unselectedWidgetColor: Color(0x8a000000),
  disabledColor: Color(0x61000000),
  buttonColor: Color(0xffe0e0e0),
  toggleableActiveColor: Color(0xffa14f2b),
  secondaryHeaderColor: Color(0xfffaefeb),
  textSelectionColor: Color(0xffeac0ae),
  cursorColor: Color(0xff4285f4),
  textSelectionHandleColor: Color(0xffdfa186),
  backgroundColor: Color(0xffeac0ae),
  dialogBackgroundColor: Color(0xffffffff),
  indicatorColor: Color(0xffca6335),
  hintColor: Color(0x8a000000),
  errorColor: Color(0xffd32f2f),
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    minWidth: 88,
    height: 36,
    padding: EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 16),
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Color(0xff000000),
        width: 0,
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    alignedDropdown: false,
    buttonColor: Color(0xffce7346),
    disabledColor: Color(0x61000000),
    highlightColor: Color(0x00000000),
    splashColor: Color(0x1fffffff),
    focusColor: Color(0x1f000000),
    hoverColor: Color(0x0a000000),
    colorScheme: ColorScheme(
      primary: Color(0xffce6f45),
      primaryVariant: Color(0xff793b20),
      secondary: Color(0xffca6335),
      secondaryVariant: Color(0xff793b20),
      surface: Color(0xffffffff),
      background: Color(0xffeac0ae),
      error: Color(0xffd32f2f),
      onPrimary: Color(0xffffffff),
      onSecondary: Color(0xffffffff),
      onSurface: Color(0xff000000),
      onBackground: Color(0xffffffff),
      onError: Color(0xffffffff),
      brightness: Brightness.light,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    helperStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    hintStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorMaxLines: null,
    isDense: true,
    isCollapsed: true,
    prefixStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    suffixStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    counterStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    filled: false,
    fillColor: Color(0x00000000),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff000000),
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        gapPadding: 4),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffce6f45),
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        gapPadding: 4),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff000000),
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        gapPadding: 4),
    disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff000000),
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        gapPadding: 4),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff000000),
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        gapPadding: 4),
    border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffce6f45),
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        gapPadding: 4),
  ),
  iconTheme: IconThemeData(
    color: Color(0xdd000000),
    opacity: 1,
    size: 24,
  ),
  primaryIconTheme: IconThemeData(
    color: Color(0xffffffff),
    opacity: 1,
    size: 24,
  ),
  accentIconTheme: IconThemeData(
    color: Color(0xffffffff),
    opacity: 1,
    size: 24,
  ),
  sliderTheme: SliderThemeData(
    activeTrackColor: null,
    inactiveTrackColor: null,
    disabledActiveTrackColor: null,
    disabledInactiveTrackColor: null,
    activeTickMarkColor: null,
    inactiveTickMarkColor: null,
    disabledActiveTickMarkColor: null,
    disabledInactiveTickMarkColor: null,
    thumbColor: null,
    disabledThumbColor: null,
    thumbShape: null,
    overlayColor: null,
    valueIndicatorColor: null,
    valueIndicatorShape: null,
    showValueIndicator: null,
    valueIndicatorTextStyle: TextStyle(
      color: Color(0xffffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
  ),
  tabBarTheme: TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: Color(0xffffffff),
    unselectedLabelColor: Color(0xb2ffffff),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: Color(0x1f000000),
    brightness: Brightness.light,
    deleteIconColor: Color(0xde000000),
    disabledColor: Color(0x0c000000),
    labelPadding: EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 8),
    labelStyle: TextStyle(
      color: Color(0xde000000),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    padding: EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
    secondaryLabelStyle: TextStyle(
      color: Color(0x3d000000),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    secondarySelectedColor: Color(0x3dce6f45),
    selectedColor: Color(0x3d000000),
    shape: StadiumBorder(
        side: BorderSide(
      color: Color(0xff000000),
      width: 0,
      style: BorderStyle.none,
    )),
  ),
  dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
    side: BorderSide(
      color: Color(0xff000000),
      width: 0,
      style: BorderStyle.none,
    ),
    borderRadius: BorderRadius.all(Radius.circular(0.0)),
  )),
);
