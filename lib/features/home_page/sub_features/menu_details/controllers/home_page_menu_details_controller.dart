import 'package:flutter_java_code_app/features/home_page/controllers/home_page_controller.dart';
import 'package:flutter_java_code_app/features/home_page/models/level.dart';
import 'package:flutter_java_code_app/features/home_page/models/menu_ui.dart';
import 'package:flutter_java_code_app/features/home_page/models/topping.dart';
import 'package:flutter_java_code_app/features/home_page/sub_features/menu_details/repositories/menu_details_repository.dart';
import 'package:flutter_java_code_app/utils/functions/app_logger.dart';
import 'package:get/get.dart';

class HomePageMenuDetailsController extends GetxController {
  static HomePageMenuDetailsController get to => Get.find();

  final RxBool isLoading = true.obs;
  // Gunakan Rx untuk menyimpan referensi instance menu yang sama
  final Rx<MenuUI?> selectedMenuDetail = Rx<MenuUI?>(null);

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args['menuUI'] != null) {
      // Dapatkan menu yang dipassing lewat argument
      MenuUI passedMenu = args['menuUI'] as MenuUI;
      // Cari referensi yang sama di list menu HomePageController
      final menuInHomePage = HomePageController.to.menus
          .firstWhereOrNull((m) => m.idMenu == passedMenu.idMenu);
      if (menuInHomePage != null) {
        selectedMenuDetail.value = menuInHomePage;
        fetchMenuDetail(menuInHomePage);
        AppLogger.d(
            'onInit menu: ${menuInHomePage.idMenu} - ${menuInHomePage.nama}');
      } else {
        // Jika tidak ditemukan, fallback ke passedMenu
        selectedMenuDetail.value = passedMenu;
        fetchMenuDetail(passedMenu);
        AppLogger.d(
            'onInit menu fallback: ${passedMenu.idMenu} - ${passedMenu.nama}');
      }
    } else {
      AppLogger.e('Menu id is null');
      Get.snackbar("Error", "Menu ID tidak ditemukan");
    }
  }

  // Ambil detail menu dari API dan perbarui instance menu melalui updateForm
  Future<void> fetchMenuDetail(MenuUI menu) async {
    final result = await MenuDetailsRepository.fetchDetailMenu(menu.idMenu);
    result.fold(
      (failure) {
        AppLogger.e('Error: ${failure.message}');
        isLoading(false);
      },
      (menuDetail) {
        AppLogger.d('Menu detail fetched');
        // Update instance menu yang sama dengan data detail baru
        menu.updateForm(menuDetail);
        // Perbarui list menu di HomePageController jika diperlukan
        HomePageController.to.menus.refresh();
        selectedMenuDetail.refresh();
        isLoading(false);
      },
    );
  }

  // Fungsi-fungsi update yang menggunakan referensi selectedMenuDetail
  void incrementQuantity() {
    if (selectedMenuDetail.value != null) {
      HomePageController.to.incrementQuantity(selectedMenuDetail.value!);
    }
  }

  void decrementQuantity() {
    if (selectedMenuDetail.value != null) {
      HomePageController.to.decrementQuantity(selectedMenuDetail.value!);
    }
  }

  int getQuantity() {
    if (selectedMenuDetail.value != null) {
      return HomePageController.to.getQuantity(selectedMenuDetail.value!);
    }
    return 0;
  }

  void updateMenuLevel(Level selectedLevel) {
    if (selectedMenuDetail.value != null) {
      final menu = selectedMenuDetail.value!;
      menu.levelSelected = selectedLevel;
      int index = HomePageController.to.menus
          .indexWhere((m) => m.idMenu == menu.idMenu);
      if (index != -1) {
        HomePageController.to.menus[index].levelSelected = selectedLevel;
        HomePageController.to.menus.refresh();
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
      int index = HomePageController.to.menus
          .indexWhere((m) => m.idMenu == menu.idMenu);
      if (index != -1) {
        HomePageController.to.menus[index].toppingSelected = selectedToppings;
        HomePageController.to.menus.refresh();
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
      int index = HomePageController.to.menus
          .indexWhere((m) => m.idMenu == menu.idMenu);
      if (index != -1) {
        HomePageController.to.menus[index].note = newNote;
        HomePageController.to.menus.refresh();
      }
      selectedMenuDetail.refresh();
      AppLogger.d('Menu ${menu.nama} note diupdate menjadi: $newNote');
    }
  }
}
