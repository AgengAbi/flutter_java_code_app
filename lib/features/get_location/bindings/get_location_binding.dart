import 'package:flutter_java_code_app/features/get_location/controllers/get_location_controller.dart';
import 'package:get/get.dart';

class GetLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GetLocationController());
  }
}
