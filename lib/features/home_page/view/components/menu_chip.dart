import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MenuChip extends StatelessWidget {
  final bool isSelected;
  final String text;
  final dynamic icon;
  final Function()? onTap;

  const MenuChip({
    super.key,
    this.icon,
    this.isSelected = false,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(30.r),
      color: isSelected ? ColorStyle.dark : ColorStyle.info,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.r, vertical: 10.0.r),
          child: Row(
            children: [
              if (icon != null) ...[
                icon is IconData
                    ? Icon(icon, size: 28.r, color: Colors.white)
                    : icon is String
                        ? SvgPicture.asset(
                            icon,
                            width: 20.r,
                            height: 20.r,
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn),
                          )
                        : icon,
                if (icon != null) 12.horizontalSpace,
              ],
              Center(
                child: Text(
                  text,
                  style: Get.textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
