import 'package:flutter_java_code_app/configs/routes/route.dart';
import 'package:flutter_java_code_app/features/home_page/models/menu_ui.dart';
import 'package:flutter_java_code_app/features/home_page/models/promo.dart';
import 'package:flutter_java_code_app/features/home_page/repositories/home_page_repository.dart';
import 'package:flutter_java_code_app/utils/functions/app_logger.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePageController extends GetxController {
  static HomePageController get to => Get.find();

  final RefreshController homeRefreshController =
      RefreshController(initialRefresh: false);

  // * Promo
  final RxList<Promo> promos = <Promo>[].obs;
  final RxBool isPromosLoading = false.obs;

  // * Menu List
  final RxList<MenuUI> menus = <MenuUI>[].obs;
  final RxBool isMenusLoading = false.obs;

  // * Filtered Menu List
  RxList<String> uniqueCategories = <String>[].obs;
  final RxBool isCategoryLoading = true.obs;
  final RxString keyword = ''.obs;
  final RxString selectedCategory = 'semua menu'.obs;

  // *
  RxList<MenuUI> selectedItems = <MenuUI>[].obs;

  // * Cart Order List
  RxList<MenuUI> orderList = <MenuUI>[].obs;

  @override
  void onInit() {
    super.onInit();
    getPromos();
    getMenus();
  }

  Future<void> getPromos() async {
    final result = await HomePageRepository.fetchPromos();
    result.fold(
      (failure) {
        AppLogger.e(failure.message);
      },
      (fetchedPromos) async {
        promos.assignAll(fetchedPromos);
        // AppLogger.d('Total promos: ${promos.length}');
        isPromosLoading.value = false;
      },
    );
  }

  Future<void> getMenus() async {
    final result = await HomePageRepository.fetchMenus();
    result.fold(
      (failure) {
        AppLogger.e(failure.message);
      },
      (fetchedMenus) async {
        menus.assignAll(fetchedMenus);
        isMenusLoading.value = false;
        // Fetching unique categories
        fetchUniqueCategories();
      },
    );
  }

  // Getter for unique category list of data with defult value 'all'
  Future<void> fetchUniqueCategories() async {
    final categories = menus.map((menu) => menu.kategori).toSet().toList();
    categories.sort();
    uniqueCategories.value = ['semua menu', ...categories];
    isCategoryLoading.value = false;
  }

  // Getter for return data menu that have been filtered
  List<MenuUI> get filteredList {
    final keywordLower = keyword.value.toLowerCase();
    final selected = selectedCategory.value.toLowerCase();

    final filtered = menus.where((menu) {
      final nameLower = menu.nama.toLowerCase();
      final categoryLower = menu.kategori.toLowerCase();

      final matchKeyword =
          keywordLower.isEmpty || nameLower.contains(keywordLower);
      final matchCategory =
          selected == 'semua menu' || categoryLower == selected;

      return matchKeyword && matchCategory;
    }).toList();

    return filtered;
  }

  // Counter quantity of menu
  void incrementQuantity(MenuUI menu) {
    AppLogger.d(
        'Increment quantity: ${menu.nama} - current quantity: ${menu.quantity}');
    if (menu.quantity == 0) {
      Get.toNamed(Routes.homePageMenuDetailsRoute, arguments: {'menuUI': menu});
      menu.quantity++;
      AppLogger.d(
          'Navigated to detail and incremented, new quantity: ${menu.quantity}');
    } else {
      menu.quantity++;
    }
    menus.refresh();
  }

  void decrementQuantity(MenuUI menu) {
    if (menu.quantity > 0) {
      menu.quantity--;
      AppLogger.d('Quantity decremented to ${menu.quantity}');

      // if quantiy is 0, remove from order list
      if (menu.quantity == 0) {
        menu.note = '';
        orderList.removeWhere((m) => m.idMenu == menu.idMenu);
      }
    }
    menus.refresh();
  }

  int getQuantity(MenuUI menu) {
    AppLogger.d(
        'Get quantity of menu: ${menu.idMenu} - current quantity: ${menu.quantity}');
    final existingItem = menus.firstWhereOrNull((m) => m.idMenu == menu.idMenu);
    return existingItem?.quantity ?? 0;
  }

  void addMenuToOrder(MenuUI menu) {
    final index = orderList.indexWhere((m) => m.idMenu == menu.idMenu);
    if (menu.quantity == 0) {
      if (index != -1) {
        orderList.removeAt(index);
      }
    } else {
      if (index != -1) {
        orderList[index].quantity = menu.quantity;
      } else {
        orderList.add(menu);
      }
    }
    menus.refresh();
  }
}
