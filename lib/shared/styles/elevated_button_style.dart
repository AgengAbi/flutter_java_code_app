import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ElevatedButtonStyle {
  /// Main Elevated Button Style
  static ButtonStyle get mainRounded => ElevatedButton.styleFrom(
        backgroundColor: ColorStyle.info,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 24.w,
        ),
        alignment: Alignment.center,
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      );

  static ButtonStyle get secondary => ElevatedButton.styleFrom(
        backgroundColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 20.w,
        ),
        textStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      );
}
