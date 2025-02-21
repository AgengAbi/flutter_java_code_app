import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/constants/cores/assets/svg_constant.dart';
import 'package:flutter_java_code_app/features/checkout/constants/checkout_assets_constant.dart';
import 'package:flutter_java_code_app/features/checkout/controllers/checkout_controller.dart';
import 'package:flutter_java_code_app/features/checkout/view/components/cart_order_bottom_bar.dart';
import 'package:flutter_java_code_app/features/checkout/view/components/tile_option.dart';
import 'package:flutter_java_code_app/features/home_page/controllers/home_page_controller.dart';
import 'package:flutter_java_code_app/features/home_page/view/components/menu_card.dart';
import 'package:flutter_java_code_app/shared/widgets/section_header.dart';
import 'package:flutter_java_code_app/shared/widgets/universal_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key});

  final assetsConstant = CheckoutAssetsConstant();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UniversalAppBar(
        title: 'Pesanan',
        icon: Icons.room_service,
      ),
      body: Obx(() {
        if (CheckoutController.to.orderList.isEmpty) {
          return const Center(child: Text('Belum ada menu yang dipilih.'));
        } else {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (CheckoutController.to.foodItems.isNotEmpty) ...[
                  const SectionHeader(
                    title: 'Makanan',
                    icon: SvgConstant.icFood,
                  ),
                  12.verticalSpace,
                  ...CheckoutController.to.foodItems.map((foodItem) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.5.h),
                      child: MenuCard(
                        menu: foodItem,
                        onIncrement: () =>
                            CheckoutController.to.incrementQuantity(foodItem),
                        onDecrement: () =>
                            CheckoutController.to.decrementQuantity(foodItem),
                        isSelected: HomePageController.to.selectedItems
                            .contains(foodItem),
                      ),
                    );
                  }),
                ],
                12.verticalSpace,
                if (CheckoutController.to.drinkItems.isNotEmpty) ...[
                  const SectionHeader(
                    title: 'Minuman',
                    icon: SvgConstant.icDrink,
                  ),
                  12.verticalSpace,
                  ...CheckoutController.to.drinkItems.map((foodItem) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.5.h),
                      child: MenuCard(
                        menu: foodItem,
                        onIncrement: () =>
                            CheckoutController.to.incrementQuantity(foodItem),
                        onDecrement: () =>
                            CheckoutController.to.decrementQuantity(foodItem),
                        isSelected: HomePageController.to.selectedItems
                            .contains(foodItem),
                      ),
                    );
                  }),
                ],
                12.verticalSpace,
                if (CheckoutController.to.snackItems.isNotEmpty) ...[
                  const SectionHeader(
                    title: 'Snack',
                    icon: SvgConstant.icFood,
                  ),
                  12.verticalSpace,
                  ...CheckoutController.to.snackItems.map((foodItem) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.5.h),
                      child: MenuCard(
                        menu: foodItem,
                        onIncrement: () =>
                            CheckoutController.to.incrementQuantity(foodItem),
                        onDecrement: () =>
                            CheckoutController.to.decrementQuantity(foodItem),
                        isSelected: HomePageController.to.selectedItems
                            .contains(foodItem),
                      ),
                    );
                  }),
                ],
              ],
            ),
          );
        }
      }),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 22.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Total order tile
                    TileOption(
                      title: 'Total orders',
                      subtitle:
                          '(${CheckoutController.to.orderList.length} Menu):',
                      icon: Icons.payments_outlined,
                      message:
                          'Rp ${CheckoutController.to.totalPrice.toString()}',
                      titleStyle: Get.textTheme.bodyLarge,
                      messageStyle: Get.textTheme.labelLarge!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                    Divider(color: Colors.black54, height: 2.h),

                    // Discount tile
                    TileOption(
                      icon: Icons.discount_outlined,
                      iconSize: 24.r,
                      title: 'Discount',
                      message: 'Rp ${CheckoutController.to.discountPrice}',
                      titleStyle: Get.textTheme.bodyLarge,
                      messageStyle: Get.textTheme.labelLarge!
                          .copyWith(color: Theme.of(context).colorScheme.error),
                    ),

                    // Payment options tile
                    TileOption(
                      icon: Icons.payment_outlined,
                      iconSize: 24.r,
                      title: 'Payment',
                      message: 'Pay Later',
                      titleStyle: Get.textTheme.bodyLarge,
                      messageStyle: Get.textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              CartOrderBottomBar(
                totalPrice: 'Rp ${CheckoutController.to.grandTotalPrice}',
                onOrderButtonPressed: CheckoutController.to.verify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
