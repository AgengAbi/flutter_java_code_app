import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    this.color,
    required this.title,
    this.icon,
  });

  final String title;
  final Color? color;
  final dynamic icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null)
          icon is IconData
              ? Icon(icon, size: 28.r, color: color ?? ColorStyle.info)
              : icon is String
                  ? SvgPicture.asset(icon,
                      width: 20.r,
                      height: 20.r,
                      colorFilter: ColorFilter.mode(
                          color ?? ColorStyle.info, BlendMode.srcIn))
                  : icon,
        if (icon != null) 10.horizontalSpace,
        Text(
          title,
          style: Get.textTheme.titleLarge?.copyWith(
            color: color,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
