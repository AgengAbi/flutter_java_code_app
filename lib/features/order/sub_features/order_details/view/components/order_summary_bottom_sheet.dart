import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/features/order/sub_features/order_details/controllers/order_order_details_controller.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
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
      final totalPayment = totalPrice - voucher;
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

      final isStep1Active = status == 0;
      final isStep2Active = status == 1;
      final isStep3Active = status == 2;

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'Total Pesanan:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    8.horizontalSpace,
                    Text(
                      '($totalOrder Menu)',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Text(
                  'Rp. $totalPrice',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorStyle.info,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Voucher:', style: TextStyle(fontSize: 18)),
                Column(
                  children: [
                    Text(
                      'Rp.$voucher',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pembayaran:', style: TextStyle(fontSize: 18)),
                Text('Paylater', style: TextStyle(fontSize: 18)),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Payment:',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Rp $totalPayment',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorStyle.info,
                  ),
                ),
              ],
            ),
            const Divider(),
            16.verticalSpace,
            Text(
              'Pesanan kamu sedang disiapkan',
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
                  title: 'Pesanan\nditerima',
                ),
                Expanded(
                  child: Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                ),
                // Step 2
                buildStep(
                  isActive: isStep2Active,
                  title: 'Silahkan\ndiambil',
                ),
                Expanded(
                  child: Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                ),
                // Step 3
                buildStep(
                  isActive: isStep3Active,
                  title: 'Pesanan\nselesai',
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
