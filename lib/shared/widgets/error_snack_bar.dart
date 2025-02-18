import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ErrorSnackBar extends GetSnackBar {
  ErrorSnackBar({
    super.key,
    required String title,
    required String message,
  }) : super(
          titleText: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: Colors.white,
            ),
          ),
          messageText: Text(
            message,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white,
            ),
          ),
          icon: Icon(
            Icons.error,
            color: Colors.white,
            size: 24.r,
          ),
          backgroundColor: Colors.red,
          margin: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
          borderRadius: 10.r,
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM,
        );
}

extension Spacing on num {
  Widget get horizontalSpaceRadius => SizedBox(width: r);
  Widget get verticalSpacingRadius => SizedBox(height: r);
}
