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
  fontFamily: 'GoogleSans',
  scaffoldBackgroundColor: const Color(0xff111E35),
  useMaterial3: false,
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
