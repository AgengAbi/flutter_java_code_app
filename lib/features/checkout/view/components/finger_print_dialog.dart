import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FingerprintDialog extends StatelessWidget {
  const FingerprintDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // title
          Text(
            'Verify Pesanan'.tr,
            style: Get.textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          // subtitle
          Text(
            'Finger Print'.tr,
            style: Get.textTheme.bodySmall!.copyWith(color: Colors.black),
          ),

          30.verticalSpace,

          // fingerprint icon
          GestureDetector(
            child: Icon(Icons.fingerprint,
                size: 120.r, color: Theme.of(context).primaryColor),
            onTap: () => Get.back<String>(result: 'fingerprint'),
          ),

          30.verticalSpace,

          Row(children: <Widget>[
            32.horizontalSpace,
            const Expanded(child: Divider()),
            8.horizontalSpace,
            Text(
              "atau",
              style: TextStyle(fontSize: 14.sp),
            ),
            8.horizontalSpace,
            const Expanded(child: Divider()),
            32.horizontalSpace,
          ]),

          // verify using pin code
          TextButton(
            onPressed: () => Get.back<String>(result: 'pin'),
            child: Text(
              'Verifikasi Menggunakan PIN',
              style: Get.textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
