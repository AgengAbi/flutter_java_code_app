import 'package:get/get.dart';

class MainPageController extends GetxController {
  static MainPageController get to => Get.find();

  RxInt currentIndex = 0.obs;
  RxBool isLoading = false.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }
}
