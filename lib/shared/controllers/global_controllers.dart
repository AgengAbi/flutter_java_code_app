// import 'dart:io';

// import 'package:get/get.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';
// import 'package:venturo_core/configs/routes/route.dart';

// class GlobalController extends GetxController {
//   static GlobalController get to => Get.find();

//   /// Check Connection Variable
//   var isConnect = false.obs;

//   // @override
//   // void onInit() {
//   //   super.onInit();
//   //   ever(isConnect, (bool connected) {
//   //     if (!connected) {
//   //       Get.offAllNamed(Routes.noConnectionRoute);
//   //     }
//   //   });
//   //   checkConnection(); // Check Connection When Initialized
//   // }

//   /// Check Connection Setting
//   Future<void> checkConnection() async {
//     try {
//       final result = await InternetAddress.lookup('space.venturo.id');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         isConnect.value = true;
//       }
//     } on SocketException catch (exception, stackTrace) {
//       isConnect.value = false;
//       await Sentry.captureException(
//         exception,
//         stackTrace: stackTrace,
//       );

//       Get.offAllNamed(Routes.noConnectionRoute);
//     }
//   }
// }

import 'dart:io';

import 'package:flutter_java_code_app/configs/routes/route.dart';
import 'package:flutter_java_code_app/constants/cores/api/api_constant.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class GlobalController extends GetxController {
  static GlobalController get to => Get.find();

  var baseUrl = ApiConstant.production;
  var isStaging = false.obs;

  /// Check Connection Variable
  var isConnect = false.obs;

  @override
  void onInit() {
    super.onInit();
    ever(isConnect, (bool connected) {
      if (!connected) {
        Get.offAllNamed(Routes.noConnectionRoute);
      }
    });
    checkConnection(); // Check Connection When Initialized
  }

  /// Check Connection Setting
  Future<void> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('space.venturo.id');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnect.value = true;
      }
    } on SocketException catch (exception, stackTrace) {
      isConnect.value = false;
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );

      Get.offAllNamed(Routes.noConnectionRoute);
    }
  }
}
