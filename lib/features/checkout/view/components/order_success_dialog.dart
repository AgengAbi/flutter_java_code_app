import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/constants/cores/assets/svg_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class OrderSuccessDialog extends StatelessWidget {
  const OrderSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          28.verticalSpace,
          SvgPicture.asset(
            SvgConstant.icfrying,
            width: 150.r,
            height: 150.r,
          ),
          28.verticalSpace,
          Text(
            'Pesanan Sedang Disiapkan'.tr,
            style: Get.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          14.verticalSpace,
          Text.rich(
            TextSpan(children: [
              TextSpan(
                text: 'Kamu dapat melacak \npesanamnu di fitur',
                style: Get.textTheme.bodySmall!.copyWith(
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: ' ${'Pesanan'.tr}',
                style: Get.textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ]),
            textAlign: TextAlign.center,
          ),
          14.verticalSpace,
          SizedBox(
            width: 168.w,
            child: ElevatedButton(
              onPressed: () => Get.back(),
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
                tapTargetSize: null,
                minimumSize: Size(
                  1.sw,
                  56.h,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Okay',
                    textAlign: TextAlign.center,
                    style: Get.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 14.sp,
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
