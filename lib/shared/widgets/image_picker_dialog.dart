import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerDialog extends StatelessWidget {
  const ImagePickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 300.w,
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select image source'.tr,
              style: Get.textTheme.titleMedium,
            ),
            16.verticalSpacingRadius,
            TextButton(
              onPressed: () => Get.back(result: ImageSource.gallery),
              child: Row(
                children: [
                  const Icon(
                    Icons.image,
                    color: ColorStyle.black,
                  ),
                  16.horizontalSpaceRadius,
                  Text(
                    'Gallery'.tr,
                    style: Get.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () => Get.back(result: ImageSource.camera),
              child: Row(
                children: [
                  const Icon(
                    Icons.camera,
                    color: ColorStyle.black,
                  ),
                  16.horizontalSpaceRadius,
                  Text(
                    'Camera'.tr,
                    style: Get.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Cara memanggil dialog
void showImagePickerDialog(BuildContext context) {
  showDialog<ImageSource>(
    context: context,
    builder: (context) => const ImagePickerDialog(),
  );
}
