import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuantityControl extends StatelessWidget {
  final int currentQuantity;
  final void Function()? onIncrement;
  final void Function()? onDecrement;

  const QuantityControl({
    super.key,
    required this.currentQuantity,
    this.onIncrement,
    this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (currentQuantity > 0) ...[
          // Decrement button.
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.r),
              border: Border.all(
                color: ColorStyle.primary,
                width: 2.w,
              ),
            ),
            child: InkWell(
              onTap: onDecrement,
              borderRadius: BorderRadius.circular(5.r),
              child: Padding(
                padding: EdgeInsets.all(2.r),
                child: Icon(
                  Icons.remove,
                  color: ColorStyle.primary,
                  size: 22.sp,
                ),
              ),
            ),
          ),
          SizedBox(width: 5.w),
          // Quantity text.
          Text(
            currentQuantity.toString(),
            style: TextStyle(fontSize: 18.sp),
          ),
          SizedBox(width: 5.w),
        ],
        // Increment button always visible.
        Container(
          decoration: BoxDecoration(
            color: ColorStyle.primary,
            borderRadius: BorderRadius.circular(5.r),
            border: Border.all(
              color: ColorStyle.primary,
              width: 2.w,
            ),
          ),
          child: InkWell(
            onTap: onIncrement,
            borderRadius: BorderRadius.circular(5.r),
            child: Padding(
              padding: EdgeInsets.all(2.r),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 22.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
