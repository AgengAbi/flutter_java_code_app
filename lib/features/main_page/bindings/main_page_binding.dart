import 'package:flutter_java_code_app/features/main_page/controllers/main_page_controller.dart';
import 'package:get/get.dart';

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainPageController());
  }
}
