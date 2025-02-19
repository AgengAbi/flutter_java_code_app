import 'package:flutter_java_code_app/configs/routes/route.dart';
import 'package:flutter_java_code_app/utils/functions/app_logger.dart';
import 'package:flutter_java_code_app/utils/services/hive_service.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2));

    Get.offAllNamed(Routes.signInRoute);

    final user = LocalStorageService.getUserAuth();
    final token = LocalStorageService.getAuthToken();

    if (token != null) {
      AppLogger.d('User has logged in: ${user!.nama}');
      Get.offAllNamed(Routes.mainPageRoute);
    } else {
      Get.offAllNamed(Routes.signInRoute);
    }
  }
}
