import 'package:flutter_java_code_app/configs/routes/route.dart';
import 'package:flutter_java_code_app/features/get_location/view/ui/get_location_screen.dart';
import 'package:flutter_java_code_app/utils/functions/app_logger.dart';
import 'package:flutter_java_code_app/utils/services/location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class GetLocationController extends GetxController {
  static GetLocationController get to => Get.find();

  /// Location
  RxString statusLocation = RxString('loading');
  RxString messageLocation = RxString('');
  Rxn<Position> position = Rxn<Position>();
  RxnString address = RxnString();

  @override
  void onReady() {
    super.onReady();

    getLocation();
    LocationServices.streamService.listen((status) => getLocation());
  }

  Future<void> getLocation() async {
    if (Get.isDialogOpen == false) {
      Get.dialog(const GetLocationScreen(), barrierDismissible: false);
    }

    try {
      /// Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        /// If location services are not enabled, show a Panara dialog asking to enable it
        PanaraConfirmDialog.show(
          Get.context!,
          title: "Fitur lokasi tidak aktif".tr,
          message: "Tolong aktifkan fitur lokasi untuk lanjut.".tr,
          confirmButtonText: "OK".tr,
          cancelButtonText: "Batal".tr,
          onTapCancel: () {
            Get.offAllNamed(Routes.splashRoute);
          },
          onTapConfirm: () {
            Get.back();
            Geolocator.openLocationSettings(); // Open location settings
          },
          panaraDialogType: PanaraDialogType.normal,
          barrierDismissible:
              false, // Prevent dismissing the dialog by tapping outside
        );
        return; // Exit the method to prevent location fetching if the location is off
      }

      /// Fetch the current location
      statusLocation.value = 'loading';
      final locationResult = await LocationServices.getCurrentPosition();

      if (locationResult.success) {
        AppLogger.d('Location is close enough');

        /// If the location is close enough, get the address information
        position.value = locationResult.position;
        address.value = locationResult.address;
        statusLocation.value = 'success';

        await Future.delayed(const Duration(seconds: 1));
        Get.offAllNamed(Routes.mainPageRoute);
      } else {
        /// If the location is not close enough, show an error message
        statusLocation.value = 'error';
        messageLocation.value = locationResult.message!;
      }
    } catch (e) {
      /// If a server error occurs
      AppLogger.e(e.toString());
      statusLocation.value = 'error';
      messageLocation.value = 'Server error'.tr;
    }
  }
}
