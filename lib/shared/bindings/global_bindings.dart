import 'package:flutter_java_code_app/shared/controllers/global_controllers.dart';
import 'package:get/get.dart';

class GlobalBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(GlobalController());
  }
}
