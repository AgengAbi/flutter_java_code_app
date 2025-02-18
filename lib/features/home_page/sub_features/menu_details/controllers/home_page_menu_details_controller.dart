import 'package:flutter_java_code_app/features/home_page/controllers/home_page_controller.dart';
import 'package:flutter_java_code_app/features/home_page/sub_features/menu_details/models/menu_detail.dart';
import 'package:flutter_java_code_app/features/home_page/sub_features/menu_details/repositories/menu_details_repository.dart';
import 'package:flutter_java_code_app/shared/models/menu_ui.dart';
import 'package:flutter_java_code_app/utils/functions/app_logger.dart';
import 'package:get/get.dart';

class HomePageMenuDetailsController extends GetxController {
  static HomePageMenuDetailsController get to => Get.find();

  final RxBool isLoading = true.obs;
  final Rx<MenuDetail?> menuDetails = Rx<MenuDetail?>(null);
  final Rx<MenuUI?> menuUI = Rx<MenuUI?>(null);
  late int quantity = 0;

  @override
  void onInit() {
    super.onInit();
    // Get value from arguments
    if (Get.arguments != null && Get.arguments['menuUI'] != null) {
      menuUI.value = Get.arguments['menuUI'] as MenuUI;
      getMenuDetails(menuUI.value!.idMenu);
    } else {
      AppLogger.e('Menu id is null');
      Get.snackbar("Error", "Menu ID tidak ditemukan");
    }
    quantity = HomePageController.to.getQuantity(menuUI.value!);
  }

  Future<void> getMenuDetails(int idMenu) async {
    final result = await MenuDetailsRepository.fetchMenuDetails(idMenu);

    result.fold((failure) {
      AppLogger.e('Error getting menu details: $failure');
    }, (details) {
      menuDetails.value = details;
      isLoading(false);
    });
  }

  void incrementQuantity(MenuUI menu) {
    HomePageController.to.incrementQuantity(menu);
  }

  void decrementQuantity(MenuUI menu) {
    HomePageController.to.decrementQuantity(menu);
  }
}
