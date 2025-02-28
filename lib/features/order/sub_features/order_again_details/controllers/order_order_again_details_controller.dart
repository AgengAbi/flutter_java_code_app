import 'package:flutter_java_code_app/features/home_page/models/level.dart';
import 'package:flutter_java_code_app/features/home_page/models/menu_ui.dart';
import 'package:flutter_java_code_app/features/home_page/models/topping.dart';
import 'package:flutter_java_code_app/features/home_page/sub_features/menu_details/repositories/menu_details_repository.dart';
import 'package:flutter_java_code_app/features/order/sub_features/order_again/controllers/order_order_again_controller.dart';
import 'package:flutter_java_code_app/utils/functions/app_logger.dart';
import 'package:get/get.dart';

class OrderOrderAgainDetailsController extends GetxController {
  static OrderOrderAgainDetailsController get to => Get.find();

  final RxBool isLoading = true.obs;
  final Rx<MenuUI?> selectedMenuDetail = Rx<MenuUI?>(null);

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args['menuUI'] != null) {
      // Ambil referensi MenuUI yang dipassing dari OrderAgainScreen
      selectedMenuDetail.value = args['menuUI'] as MenuUI;
      // Jika perlu, lakukan fetch detail untuk update atribut detail
      fetchMenuDetail(selectedMenuDetail.value!);
    } else {
      AppLogger.e('Menu tidak ditemukan dalam argument');
      Get.snackbar("Error", "Menu tidak ditemukan");
    }
  }

  Future<void> fetchMenuDetail(MenuUI menu) async {
    // Opsional: jika kamu perlu mengambil data detail dari API,
    // gunakan repository yang sudah ada (MenuDetailsRepository)
    final result = await MenuDetailsRepository.fetchDetailMenu(menu.idMenu);
    result.fold(
      (failure) {
        AppLogger.e('Error: ${failure.message}');
        isLoading.value = false;
      },
      (fetchedMenu) {
        AppLogger.d('Menu detail fetched untuk id: ${menu.idMenu}');
        // Update instance menu menggunakan method updateForm agar data detail (level, topping) terisi
        menu.updateForm(fetchedMenu);
        selectedMenuDetail.refresh();
        isLoading.value = false;
      },
    );
  }

  void incrementQuantity() {
    OrderOrderAgainController.to.incrementQuantity(selectedMenuDetail.value!);
  }

  void decrementQuantity() {
    OrderOrderAgainController.to.decrementQuantity(selectedMenuDetail.value!);
  }

  void updateMenuLevel(Level selectedLevel) {
    if (selectedMenuDetail.value != null) {
      final menu = selectedMenuDetail.value!;
      menu.levelSelected = selectedLevel;
      int index = OrderOrderAgainController.to.menuUIList
          .indexWhere((m) => m.idMenu == menu.idMenu);
      if (index != -1) {
        OrderOrderAgainController.to.menuUIList[index].levelSelected =
            selectedLevel;
        OrderOrderAgainController.to.menuUIList.refresh();
      }
      selectedMenuDetail.refresh();
      AppLogger.d(
          'Menu ${menu.nama} levelSelected diupdate menjadi: ${selectedLevel.keterangan}');
    }
  }

  void updateMenuTopping(List<Topping> selectedToppings) {
    if (selectedMenuDetail.value != null) {
      final menu = selectedMenuDetail.value!;
      menu.toppingSelected = selectedToppings;
      int index = OrderOrderAgainController.to.menuUIList
          .indexWhere((m) => m.idMenu == menu.idMenu);
      if (index != -1) {
        OrderOrderAgainController.to.menuUIList[index].toppingSelected =
            selectedToppings;
        OrderOrderAgainController.to.menuUIList.refresh();
      }
      selectedMenuDetail.refresh();
      AppLogger.d(
          'Menu ${menu.nama} toppingSelected diupdate menjadi: ${selectedToppings.map((t) => t.keterangan).join(', ')}');
    }
  }

  void updateMenuNote(String newNote) {
    if (selectedMenuDetail.value != null) {
      final menu = selectedMenuDetail.value!;
      menu.note = newNote;
      int index = OrderOrderAgainController.to.menuUIList
          .indexWhere((m) => m.idMenu == menu.idMenu);
      if (index != -1) {
        OrderOrderAgainController.to.menuUIList[index].note = newNote;
        OrderOrderAgainController.to.menuUIList.refresh();
      }
      selectedMenuDetail.refresh();
      AppLogger.d('Menu ${menu.nama} note diupdate menjadi: $newNote');
    }
  }

  int getQuantity() {
    return OrderOrderAgainController.to.getQuantity(selectedMenuDetail.value!);
  }
}
