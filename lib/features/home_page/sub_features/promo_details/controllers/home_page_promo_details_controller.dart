import 'package:flutter_java_code_app/features/home_page/sub_features/promo_details/models/promo_details.dart';
import 'package:flutter_java_code_app/features/home_page/sub_features/promo_details/repositories/promo_details_repository.dart';
import 'package:flutter_java_code_app/utils/functions/app_logger.dart';
import 'package:get/get.dart';

class HomePagePromoDetailsController extends GetxController {
  static HomePagePromoDetailsController get to => Get.find();

  final RxInt promoId = 0.obs;
  final Rx<PromoDetails?> promoItem = Rx<PromoDetails?>(null);
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Get value from arguments
    if (Get.arguments != null && Get.arguments['promoItemId'] != null) {
      promoId.value = Get.arguments['promoItemId'] as int;
      fetchPromoDetail();
    } else {
      AppLogger.e('Promo id is null');
      Get.snackbar("Error", "Promo ID tidak ditemukan");
    }
  }

  Future<void> fetchPromoDetail() async {
    isLoading.value = true;
    final result = await PromoDetailsRepository.fetchPromoDetail(promoId.value);

    result.fold(
      (failure) {
        AppLogger.e(failure.message);
        Get.snackbar("Error", failure.message);
      },
      (promo) {
        promoItem.value = promo;
      },
    );
    AppLogger.d(promoItem.value!.idPromo.toString());
    isLoading.value = false;
  }
}
