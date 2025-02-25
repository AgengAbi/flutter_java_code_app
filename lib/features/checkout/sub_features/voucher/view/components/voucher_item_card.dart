import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/features/checkout/sub_features/voucher/controllers/checkout_voucher_controller.dart';
import 'package:flutter_java_code_app/features/checkout/sub_features/voucher/models/voucher.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VoucherItemCard extends StatelessWidget {
  final Voucher voucher;
  const VoucherItemCard({super.key, required this.voucher});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xffF0F0F0),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(111, 24, 24, 24),
            blurRadius: 4,
            spreadRadius: -1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.w, top: 8.h, right: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    voucher.nama,
                    style: Get.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Obx(() {
                  final isSelected =
                      CheckoutVoucherController.selectedVoucherId.value ==
                          voucher.idVoucher;
                  return Checkbox(
                    value: isSelected,
                    fillColor: WidgetStateProperty.all(Colors.transparent),
                    checkColor: ColorStyle.info,
                    side: WidgetStateBorderSide.resolveWith(
                      (states) => const BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    onChanged: (value) {
                      CheckoutVoucherController.selectVoucher(voucher);
                    },
                  );
                }),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(
                '/voucher_detail',
                arguments: voucher,
              );
            },
            child: Hero(
              tag: 'voucher_${voucher.idVoucher}',
              child: Container(
                height: 180.h,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(111, 24, 24, 24),
                      blurRadius: 8,
                      spreadRadius: -1,
                      offset: Offset(0, 1),
                    ),
                  ],
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(voucher.infoVoucher),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
