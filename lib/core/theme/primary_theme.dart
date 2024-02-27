import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum FontFamily {
  googleSans('GoogleSans'),
  inter('Inter'),
  roobert('Roobert');

  final String value;
  const FontFamily(this.value);
}

ThemeData primaryTheme = ThemeData(
  listTileTheme: ListTileThemeData(
    leadingAndTrailingTextStyle: TextStyle(
      fontFamily: FontFamily.googleSans.value,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      fontSize: 14.sp,
    ),
    titleTextStyle: TextStyle(
      fontFamily: FontFamily.googleSans.value,
      fontWeight: FontWeight.w700,
      color: const Color.fromRGBO(176, 182, 191, 1),
      fontSize: 12.sp,
    ),
  ),
  expansionTileTheme: const ExpansionTileThemeData(
    backgroundColor: Color(0xff2B426A),
    collapsedBackgroundColor: Color(0xff172744),
    collapsedTextColor: Colors.white,
    textColor: Colors.white,
  ),
  dividerColor: const Color(0xff263238),
  tabBarTheme: const TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xff111E35),
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
    ),
  ),
  fontFamily: FontFamily.googleSans.value,
  scaffoldBackgroundColor: const Color(0xff111E35),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.white,
  ),
  textTheme: TextTheme(
      titleMedium: TextStyle(
    fontFamily: FontFamily.googleSans.value,
    fontWeight: FontWeight.w500,
    color: const Color(0xffBCC1D1),
    fontSize: 14.sp,
  )),
  useMaterial3: false,
  inputDecorationTheme: InputDecorationTheme(
    suffixIconColor: const Color(0xffBCC1D1),
    hintStyle: TextStyle(
      fontFamily: FontFamily.googleSans.value,
      fontWeight: FontWeight.w400,
      color: const Color(0xffBCC1D1),
      fontSize: 14.sp,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(
        color: Color(0xff434D6B),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(
        color: Color(0xff434D6B),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: Color(0xff434D6B), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(
        color: Color(0xffF8B02B),
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: Color(0xffF8B02B), width: 2),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(const Color(0xff3478F6)),
      minimumSize: MaterialStateProperty.all(Size(double.infinity, 52.sp)),
      textStyle: MaterialStateProperty.all(
        TextStyle(
          fontFamily: 'Inter',
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    ),
  ),
);
