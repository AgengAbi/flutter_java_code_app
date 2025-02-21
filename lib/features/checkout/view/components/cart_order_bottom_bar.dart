import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartOrderBottomBar extends StatelessWidget {
  const CartOrderBottomBar({
    super.key,
    this.onOrderButtonPressed,
    required this.totalPrice,
  });

  final VoidCallback? onOrderButtonPressed;
  final String totalPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.h,
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 22.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.r),
        ),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 20,
            spreadRadius: -1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 35.r,
          ),
          9.horizontalSpace,
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total payment',
                  style: Get.textTheme.labelLarge!
                      .copyWith(fontSize: 18.sp, color: Colors.black87),
                ),
                Text(
                  totalPrice,
                  style: Get.textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).primaryColor, fontSize: 20.sp),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: ElevatedButton(
              onPressed: onOrderButtonPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                maximumSize: Size(
                  1.sw,
                  56.h,
                ),
                side: BorderSide(
                  color: Theme.of(context).primaryColorDark,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.r),
                ),
                elevation: 2,
                minimumSize: Size(
                  1.sw,
                  56.h,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Order Now',
                    textAlign: TextAlign.center,
                    style: Get.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 18.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
