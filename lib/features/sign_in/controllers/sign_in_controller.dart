import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_java_code_app/configs/routes/route.dart';
import 'package:flutter_java_code_app/constants/cores/api/api_constant.dart';
import 'package:flutter_java_code_app/features/sign_in/models/user_auth.dart';
import 'package:flutter_java_code_app/features/sign_in/repositories/sign_in_repository.dart';
import 'package:flutter_java_code_app/shared/controllers/global_controllers.dart';
import 'package:flutter_java_code_app/shared/models/failure.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:flutter_java_code_app/shared/styles/google_text_style.dart';
import 'package:flutter_java_code_app/utils/functions/app_logger.dart';
import 'package:flutter_java_code_app/utils/services/hive_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class SignInController extends GetxController {
  static SignInController get to => Get.find();

  /// Form Variable Setting
  // GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailCtrl = TextEditingController();
  RxString emailValue = "".obs;
  TextEditingController passwordCtrl = TextEditingController();
  RxString passwordValue = "".obs;
  RxBool isPassword = true.obs;
  RxBool isRememberMe = false.obs;
  late Box<UserAuth> userBox;

  @override
  void onInit() {
    super.onInit();
    GlobalController.to.checkConnection();
  }

  @override
  void dispose() {
    super.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
  }

  void showPassword() {
    isPassword.value = !isPassword.value;
  }

  void validateForm(GlobalKey<FormState> formKey, context) async {
    await GlobalController.to.checkConnection();

    bool isValid = formKey.currentState!.validate();
    Get.focusScope!.unfocus();

    if (isValid && GlobalController.to.isConnect.value == true) {
      EasyLoading.show(
        status: 'Sedang diproses.....',
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false,
      );

      formKey.currentState!.save();

      final result =
          await SignInRepository.login(emailCtrl.text, passwordCtrl.text);

      EasyLoading.dismiss();

      result.fold(
        (failure) {
          if (failure is NetworkFailure) {
            PanaraInfoDialog.show(
              context,
              title: "Warning",
              message: failure.message,
              buttonText: "Coba lagi",
              onTapDismiss: () {
                Get.back();
              },
              panaraDialogType: PanaraDialogType.warning,
              barrierDismissible: false,
            );
          } else if (failure is ServerFailure) {
            if (failure.statusCode == 422) {
              // Wrong password
              PanaraInfoDialog.show(
                context,
                title: "Warning",
                message: failure.message,
                buttonText: "Coba lagi",
                onTapDismiss: () {
                  Get.back();
                },
                panaraDialogType: PanaraDialogType.warning,
                barrierDismissible: false,
              );
            } else {
              PanaraInfoDialog.show(
                context,
                title: "Error",
                message:
                    "Terjadi kesalahan (${failure.statusCode}): ${failure.message}",
                buttonText: "Coba lagi",
                onTapDismiss: () {
                  Get.back();
                },
                panaraDialogType: PanaraDialogType.error,
                barrierDismissible: false,
              );
            }
          }
        },
        (response) async {
          if (response.userAuth != null && response.token != null) {
            await LocalStorageService.setUserAuth(response.userAuth!);
            await LocalStorageService.setAuthToken(response.token!);
            EasyLoading.dismiss();
            AppLogger.d('User has logged in: ${response.userAuth!.email}');
            Get.offAllNamed(Routes.getLocationRoute);
          } else {
            PanaraInfoDialog.show(
              context,
              title: "Error",
              message: "Data user tidak ditemukan.",
              buttonText: "Coba lagi",
              onTapDismiss: () {
                Get.back();
              },
              panaraDialogType: PanaraDialogType.error,
              barrierDismissible: false,
            );
          }
        },
      );
    } else if (GlobalController.to.isConnect.value == false) {
      Get.toNamed(Routes.noConnectionRoute);
    }
  }

  /// Flavor setting
  void flavorSeting() async {
    Get.bottomSheet(
      Obx(
        () => Wrap(
          children: [
            Container(
              width: double.infinity.w,
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
                vertical: 5.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: ColorStyle.white,
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      GlobalController.to.isStaging.value = false;
                      GlobalController.to.baseUrl = ApiConstant.production;
                    },
                    title: Text(
                      "Production",
                      style: GoogleTextStyle.fw400.copyWith(
                        color: GlobalController.to.isStaging.value == true
                            ? ColorStyle.black
                            : ColorStyle.primary,
                        fontSize: 14.sp,
                      ),
                    ),
                    trailing: GlobalController.to.isStaging.value == true
                        ? null
                        : Icon(
                            Icons.check,
                            color: ColorStyle.primary,
                            size: 14.sp,
                          ),
                  ),
                  Divider(
                    height: 1.h,
                  ),
                  ListTile(
                    onTap: () {
                      GlobalController.to.isStaging.value = true;
                      GlobalController.to.baseUrl = ApiConstant.staging;
                    },
                    title: Text(
                      "Staging",
                      style: GoogleTextStyle.fw400.copyWith(
                        color: GlobalController.to.isStaging.value == true
                            ? ColorStyle.primary
                            : ColorStyle.black,
                        fontSize: 14.sp,
                      ),
                    ),
                    trailing: GlobalController.to.isStaging.value == true
                        ? Icon(
                            Icons.check,
                            color: ColorStyle.primary,
                            size: 14.sp,
                          )
                        : null,
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
