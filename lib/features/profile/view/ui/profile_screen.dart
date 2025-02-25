import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/configs/routes/route.dart';
import 'package:flutter_java_code_app/constants/cores/assets/image_constant.dart';
import 'package:flutter_java_code_app/constants/cores/assets/svg_constant.dart';
import 'package:flutter_java_code_app/features/profile/controllers/profile_controller.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:flutter_java_code_app/shared/styles/elevated_button_style.dart';
import 'package:flutter_java_code_app/shared/widgets/list_tile_app.dart';
import 'package:flutter_java_code_app/utils/services/hive_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Profile'.tr,
          style: Get.textTheme.titleMedium,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30.r),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImageConstant.bgPattern),
              fit: BoxFit.fitHeight,
              alignment: Alignment.center),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 25.r),
          children: [
            /// Profile Icon
            Center(
              child: Container(
                width: 170.r,
                height: 170.r,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    offset: const Offset(0, 2),
                    blurRadius: 8,
                  ),
                ]),
                child: Stack(
                  children: [
                    Obx(() {
                      // Jika sudah ada file gambar dari pickImage, gunakan Image.file
                      final imageFile = ProfileController.to.imageFile;
                      if (imageFile != null) {
                        return Image.file(
                          imageFile,
                          width: 170.r,
                          height: 170.r,
                          fit: BoxFit.cover,
                        );
                      }
                      // Jika belum ada file, gunakan foto dari URL (dari API)
                      final photoUrl =
                          ProfileController.to.user.value?.foto ?? '';
                      if (photoUrl.isNotEmpty) {
                        return Image.network(
                          photoUrl,
                          width: 170.r,
                          height: 170.r,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              ImageConstant.bgProfile,
                              width: 170.r,
                              height: 170.r,
                              fit: BoxFit.cover,
                            );
                          },
                        );
                      }
                      // Jika tidak ada keduanya, tampilkan asset default
                      return Image.asset(
                        ImageConstant.bgProfile,
                        width: 170.r,
                        height: 170.r,
                        fit: BoxFit.cover,
                      );
                    }),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Material(
                        color: ColorStyle.secondary,
                        child: InkWell(
                          onTap: ProfileController.to.pickImage,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(top: 10.r, bottom: 15.r),
                            child: Text(
                              "Change".tr,
                              style: Get.textTheme.labelMedium!
                                  .copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            21.verticalSpacingRadius,

            // Info KTP
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(SvgConstant.icKTP),
                7.horizontalSpaceRadius,
                Text(
                  'Verify your ID card now!'.tr,
                  style: Get.textTheme.labelMedium!
                      .copyWith(color: ColorStyle.secondary),
                )
              ],
            ),
            18.verticalSpacingRadius,

            /// Info akun
            Padding(
              padding: EdgeInsets.only(left: 20.r),
              child: Text(
                'Account info'.tr,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorStyle.secondary,
                ),
              ),
            ),
            14.verticalSpacingRadius,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 21.r, vertical: 30.r),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: ColorStyle.light),
              child: Obx(() => Column(
                    children: [
                      ListTileApp(
                        title: 'Nama'.tr,
                        subtitle: ProfileController.to.user.value?.nama ?? '',
                        textFormArgument: ProfileController.to.user.value?.nama,
                        bottomSheetFormType: BottomSheetFormType.textForm,
                        fieldType: FieldType.name,
                        onSubmitText: (newText) {
                          ProfileController.to.updateUserName(newText);
                        },
                      ),
                      const Divider(),
                      ListTileApp(
                        title: 'Tanggal Lahir'.tr,
                        subtitle:
                            ProfileController.to.user.value?.tglLahir ?? '',
                        bottomSheetFormType: BottomSheetFormType.datePicker,
                        fieldType: FieldType.date,
                        onSubmitText: (newDate) {
                          ProfileController.to.updateBirthDate(newDate);
                        },
                      ),
                      const Divider(),
                      ListTileApp(
                        title: 'No. Telepon'.tr,
                        subtitle:
                            ProfileController.to.user.value?.telepon ?? '',
                        textFormArgument:
                            ProfileController.to.user.value?.telepon,
                        bottomSheetFormType: BottomSheetFormType.textForm,
                        fieldType: FieldType.phone,
                        onSubmitText: (newText) {
                          ProfileController.to.updatePhoneNumber(newText);
                        },
                      ),
                      const Divider(),
                      ListTileApp(
                        title: 'Email'.tr,
                        subtitle: ProfileController.to.user.value?.email ?? '',
                        textFormArgument:
                            ProfileController.to.user.value?.email,
                        bottomSheetFormType: BottomSheetFormType.textForm,
                        fieldType: FieldType.email,
                        onSubmitText: (newText) {
                          ProfileController.to.updateEmail(newText);
                        },
                      ),
                      const Divider(),
                      ListTileApp(
                        title: 'Ubah PIN'.tr,
                        subtitle: ProfileController.to.user.value?.pin ?? '',
                        textFormArgument: ProfileController.to.user.value?.pin,
                        bottomSheetFormType: BottomSheetFormType.textForm,
                        fieldType: FieldType.pin,
                        onSubmitText: (newText) {
                          ProfileController.to.updatePIN(newText);
                        },
                      ),
                      const Divider(),
                      ListTileApp(
                        title: 'Ganti Bahasa'.tr,
                        subtitle:
                            LocalStorageService.getLanguage() ?? "Indonesia",
                        bottomSheetFormType: BottomSheetFormType.language,
                        onSubmitText: (newLanguage) {
                          ProfileController.to.updateLanguage(newLanguage);
                        },
                      ),
                    ],
                  )),
            ),
            16.verticalSpacingRadius,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 21.r, vertical: 14.r),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: ColorStyle.light),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SvgPicture.asset(SvgConstant.icReview),
                            9.horizontalSpaceRadius,
                            Text(
                              'Penilaian',
                              style: Get.textTheme.titleSmall,
                            )
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.evaluationRoute);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorStyle.secondary,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: ColorStyle.white, width: 1),
                              borderRadius: BorderRadius.circular(24),
                            )),
                        child: Text(
                          "Nilai Sekarang".tr,
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            27.verticalSpacingRadius,

            /// Other Info
            Padding(
              padding: EdgeInsets.only(left: 20.r),
              child: Text(
                'Other info'.tr,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorStyle.secondary,
                ),
              ),
            ),
            14.verticalSpacingRadius,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: ColorStyle.light),
              child: Column(
                children: [
                  Obx(() => ListTileApp(
                      title: 'Device Info',
                      titleBold: true,
                      subtitle: ProfileController.to.deviceModel.value)),
                  const Divider(),
                  Obx(() => ListTileApp(
                      title: 'Device Version',
                      titleBold: true,
                      subtitle: ProfileController.to.deviceVersion.value))
                ],
              ),
            ),
            32.verticalSpace,
            ElevatedButton(
                style: ElevatedButtonStyle.mainRounded,
                onPressed: () {
                  LocalStorageService.deleteAll();
                  Get.offAllNamed(Routes.splashRoute);
                },
                child: const Text(
                  'Log Out',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
