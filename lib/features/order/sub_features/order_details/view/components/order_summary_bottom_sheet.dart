import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/configs/themes/app_theme.dart';
import 'package:flutter_java_code_app/constants/cores/assets/svg_constant.dart';
import 'package:flutter_java_code_app/features/order/sub_features/order_details/controllers/order_order_details_controller.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:flutter_java_code_app/shared/styles/google_text_style.dart';
import 'package:flutter_java_code_app/shared/widgets/list_tile_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderSummaryBottomSheet extends StatelessWidget {
  const OrderSummaryBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final order = OrderDetailsController.to.orderItem.value;
      final totalOrder = order?.detail.length ?? 0;
      final totalPrice = order?.totalBayar ?? 0;
      final voucher = order?.potongan ?? 0;
      final totalPayment = order?.totalBayar ?? 0;
      final status = order?.status ?? 0;

      // Function for build step
      Widget buildStep({
        required bool isActive,
        required String title,
      }) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Circle step
            Container(
              width: 24.r,
              height: 24.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? ColorStyle.info : Colors.grey,
              ),
              child: isActive
                  ? const Icon(Icons.check, color: Colors.white, size: 20)
                  : null,
            ),
            8.verticalSpace,
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: isActive ? ColorStyle.info : Colors.grey,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      }

      final isStep1Active = status >= 0;
      final isStep2Active = status >= 1;
      final isStep3Active = status >= 2;

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTileApp(
              title: RichText(
                text: TextSpan(
                  text: 'Total pesanan '.tr,
                  style: GoogleTextStyle.fw600.copyWith(
                    fontSize: 18.sp,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: '($totalOrder Menu)',
                      style: GoogleTextStyle.fw400
                          .copyWith(fontSize: 18.sp, color: Colors.black),
                    ),
                  ],
                ),
              ),
              subtitle: 'Rp $totalPrice',
              subtitleBold: true,
              subtitleColor: ColorStyle.info,
            ),
            const Divider(),
            ListTileApp(
              leading: SvgConstant.icVoucher,
              title: 'Voucher'.tr,
              titleBold: true,
              subtitle: 'Rp. $voucher',
              subtitleColor: Colors.red,
            ),
            const Divider(),
            ListTileApp(
              leading: SvgConstant.icPayment,
              title: 'Pembayaran'.tr,
              titleBold: true,
              subtitle: 'Pay Later',
            ),
            const Divider(),
            ListTileApp(
              title: 'Total pembayaran'.tr,
              titleBold: true,
              subtitle: 'Rp. $totalPayment',
              subtitleColor: ColorStyle.info,
              subtitleBold: true,
            ),
            const Divider(),
            8.verticalSpace,
            if (status < 2)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      OrderDetailsController.to.cancelOrder();
                    },
                    style: ElevatedButtonStyles.secondary,
                    child: Text('Batalkan'.tr),
                  ),
                  8.horizontalSpace,
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButtonStyles.primary,
                    child: Text('Terima Pesanan'.tr),
                  ),
                ],
              ),
            8.verticalSpace,
            Text(
              'Pesanan kamu sedang disiapkan'.tr,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            12.verticalSpace,
            Row(
              children: [
                // Step 1
                buildStep(
                  isActive: isStep1Active,
                  title: 'Pesanan\nditerima'.tr,
                ),
                8.horizontalSpace,
                Expanded(
                  child: Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                ),
                8.horizontalSpace,
                // Step 2
                buildStep(
                  isActive: isStep2Active,
                  title: 'Silahkan\ndiambil'.tr,
                ),
                8.horizontalSpace,
                Expanded(
                  child: Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                ),
                8.horizontalSpace,
                // Step 3
                buildStep(
                  isActive: isStep3Active,
                  title: 'Pesanan\nselesai'.tr,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
