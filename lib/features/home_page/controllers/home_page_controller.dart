import 'package:flutter_java_code_app/features/home_page/models/promo.dart';
import 'package:flutter_java_code_app/features/home_page/repositories/home_page_repository.dart';
import 'package:flutter_java_code_app/utils/functions/app_logger.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePageController extends GetxController {
  static HomePageController get to => Get.find();

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  // * Promo
  final RxList<Promo> promos = <Promo>[].obs;
  final RxBool isPromosLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getPromos();
  }

  Future<void> getPromos() async {
    final result = await HomePageRepository.fetchPromos();
    result.fold(
      (failure) {
        AppLogger.e(failure.message);
      },
      (fetchedPromos) async {
        promos.assignAll(fetchedPromos);
        AppLogger.d(
            'Total promos: ${promos.length}, promos: ${promos.map((e) => e.idPromo).join(', ')}');
        isPromosLoading.value = false;
      },
    );
  }
}
