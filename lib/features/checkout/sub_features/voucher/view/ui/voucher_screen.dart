import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/constants/cores/assets/svg_constant.dart';
import 'package:flutter_java_code_app/features/checkout/constants/checkout_assets_constant.dart';
import 'package:flutter_java_code_app/features/checkout/sub_features/voucher/controllers/checkout_voucher_controller.dart';
import 'package:flutter_java_code_app/features/checkout/sub_features/voucher/view/components/voucher_item_card.dart';
import 'package:flutter_java_code_app/shared/widgets/universal_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VoucherScreen extends StatelessWidget {
  VoucherScreen({super.key});

  final assetsConstant = CheckoutAssetsConstant();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UniversalAppBar(
        title: 'Pilih Voucher',
        icon: SvgConstant.icVoucher,
      ),
      body: Obx(() {
        if (CheckoutVoucherController.vouchers.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 16.h),
          child: ListView.builder(
            itemCount: CheckoutVoucherController.vouchers.length,
            itemBuilder: (context, index) {
              final voucher = CheckoutVoucherController.vouchers[index];
              return VoucherItemCard(voucher: voucher);
            },
          ),
        );
      }),
    );
  }
}
