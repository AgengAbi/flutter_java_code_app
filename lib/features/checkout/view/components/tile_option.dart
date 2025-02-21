import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TileOption extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String? subtitle;
  final String message;
  final String? messageSubtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final TextStyle? messageStyle;
  final TextStyle? messageSubtitleStyle;
  final void Function()? onTap;
  final double? iconSize;
  final int? messageMaxLines;

  const TileOption({
    super.key,
    this.icon,
    required this.title,
    this.subtitle,
    required this.message,
    this.messageSubtitle,
    this.titleStyle,
    this.subtitleStyle,
    this.messageStyle,
    this.messageSubtitleStyle,
    this.onTap,
    this.iconSize,
    this.messageMaxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            children: [
              // Icon
              Container(
                constraints: BoxConstraints(minWidth: (iconSize ?? 20.r) * 2),
                child: Icon(
                  icon,
                  size: iconSize ?? 20.r,
                ),
              ),

              // title text
              Text(
                title,
                style: titleStyle ?? Get.textTheme.titleSmall,
              ),

              // subtitle text
              if (subtitle != null)
                Text(
                  ' $subtitle',
                  style: subtitleStyle ?? Get.textTheme.bodyLarge,
                ),

              10.horizontalSpaceRadius,

              // message text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      message,
                      style: messageStyle ?? Get.textTheme.bodyMedium,
                      textAlign: TextAlign.end,
                      maxLines: messageMaxLines,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (messageSubtitle != null)
                      Text(
                        messageSubtitle!,
                        textAlign: TextAlign.end,
                        style: messageSubtitleStyle ??
                            GoogleFonts.montserrat(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              height: 1.219,
                            ),
                      ),
                  ],
                ),
              ),

              // Icon right chevron
              if (onTap != null)
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey[300],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
