import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/constants/cores/assets/image_constant.dart';
import 'package:flutter_java_code_app/features/get_location/controllers/get_location_controller.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GetLocationScreen extends StatelessWidget {
  const GetLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstant.bgPattern),
            fit: BoxFit.fitHeight,
            alignment: Alignment.center,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() {
              String status = GetLocationController.to.statusLocation.value;
              return Text(
                status == 'success'
                    ? 'Lokasi terverifikasi'.tr
                    : 'Mencari lokasi saat ini'.tr,
                style: Get.textTheme.titleLarge!
                    .copyWith(color: ColorStyle.dark.withValues(alpha: 0.5)),
                textAlign: TextAlign.center,
              );
            }),
            50.verticalSpacingRadius,
            Stack(
              children: [
                Image.asset(
                  ImageConstant.iconLocation,
                  width: 190.r,
                ),
                Padding(
                  padding: EdgeInsets.all(70.r),
                  child: Icon(
                    Icons.location_pin,
                    size: 50.r,
                  ),
                ),
              ],
            ),
            50.verticalSpacingRadius,
            Obx(
              () {
                String status = GetLocationController.to.statusLocation.value;
                if (status == 'error') {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Lokasi anda di luar jangkauan'.tr,
                        style: Get.textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      24.verticalSpacingRadius,
                      ElevatedButton(
                        onPressed: () {
                          GetLocationController.to.getLocation();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 2,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.refresh,
                              color: ColorStyle.dark,
                            ),
                            16.horizontalSpaceRadius,
                            Text(
                              'Refresh'.tr,
                              style: Get.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (status == 'success') {
                  return Column(
                    children: [
                      Text(
                        GetLocationController.to.address.value ?? 'No Address',
                        style: Get.textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      12.verticalSpace,
                      Text(
                        'Sedang memuat halaman utama',
                        style: Get.textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      20.verticalSpace,
                      // const CircularProgressIndicator(
                      //   color: ColorStyle.primary,
                      // )
                    ],
                  );
                } else {
                  return const CircularProgressIndicator(
                    color: ColorStyle.primary,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
