import 'package:flutter_java_code_app/features/checkout/sub_features/voucher/models/voucher.dart';
import 'package:flutter_java_code_app/features/checkout/sub_features/voucher/repositories/voucher_repository.dart';
import 'package:flutter_java_code_app/utils/functions/app_logger.dart';
import 'package:get/get.dart';

class CheckoutVoucherController extends GetxController {
  static CheckoutVoucherController get to => Get.find();

  static RxList<Voucher> vouchers = <Voucher>[].obs;
  static final RxnInt selectedVoucherId = RxnInt();

  @override
  void onInit() {
    super.onInit();
    getVouchers();
  }

  Future<void> getVouchers() async {
    final result = await VoucherRepository.fetchVouchers();
    result.fold(
      (failure) {
        AppLogger.e(failure.message);
      },
      (fetchedVouchers) async {
        vouchers.assignAll(fetchedVouchers);
        AppLogger.d('Total vouchers: ${vouchers.length}');
      },
    );
  }

  static void selectVoucher(Voucher voucher) {
    if (selectedVoucherId.value == voucher.idVoucher) {
      selectedVoucherId.value = null;
    } else {
      selectedVoucherId.value = voucher.idVoucher;
    }
  }

  int get selectedVoucherNominal {
    if (selectedVoucherId.value != null) {
      try {
        return vouchers
            .firstWhere(
              (v) => v.idVoucher == selectedVoucherId.value,
            )
            .nominal;
      } catch (e) {
        return 0;
      }
    }
    return 0;
  }
}
