import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/constants/cores/assets/svg_constant.dart';
import 'package:flutter_java_code_app/features/order/sub_features/order_details/controllers/order_order_details_controller.dart';
import 'package:flutter_java_code_app/features/order/sub_features/order_details/view/components/detail_order_card.dart';
import 'package:flutter_java_code_app/features/order/sub_features/order_details/view/components/order_summary_bottom_sheet.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:flutter_java_code_app/shared/widgets/section_header.dart';
import 'package:flutter_java_code_app/shared/widgets/universal_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OrderDetailsController.to;

    return Scaffold(
      appBar: const UniversalAppBar(
        title: 'Pesanan',
        icon: Icons.room_service_rounded,
        actions: [],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Food section
                if (controller.foodItems.detail.isNotEmpty) ...[
                  const SectionHeader(
                    title: 'Makanan',
                    icon: SvgConstant.icFood,
                    color: ColorStyle.info,
                  ),
                  12.verticalSpace,
                  Column(
                    children: controller.foodItems.detail
                        .map((food) => Column(
                              children: [
                                DetailOrderCard(food),
                                12.verticalSpace,
                              ],
                            ))
                        .toList(),
                  ),
                ],
                12.verticalSpace,
                // Drink Section
                if (controller.drinkItems.detail.isNotEmpty) ...[
                  const SectionHeader(
                    title: 'Minuman',
                    icon: SvgConstant.icDrink,
                    color: ColorStyle.info,
                  ),
                  12.verticalSpace,
                  Column(
                    children: controller.drinkItems.detail
                        .map((drink) => Column(
                              children: [
                                DetailOrderCard(drink),
                                12.verticalSpace,
                              ],
                            ))
                        .toList(),
                  ),
                ],
                12.verticalSpace,
                // Snack Section
                if (controller.snackItems.detail.isNotEmpty) ...[
                  const SectionHeader(
                    title: 'Snack',
                    icon: Icons.icecream_outlined,
                    color: ColorStyle.info,
                  ),
                  12.verticalSpace,
                  Column(
                    children: controller.snackItems.detail
                        .map((snack) => Column(
                              children: [
                                DetailOrderCard(snack),
                                12.verticalSpace,
                              ],
                            ))
                        .toList(),
                  ),
                ],
                56.verticalSpace,
              ],
            ),
          );
        }
      }),
      bottomSheet: const OrderSummaryBottomSheet(),
    );
  }
}
