import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/configs/routes/route.dart';
import 'package:flutter_java_code_app/features/checkout/controllers/checkout_controller.dart';
import 'package:flutter_java_code_app/features/checkout/sub_features/voucher/controllers/checkout_voucher_controller.dart';
import 'package:flutter_java_code_app/features/checkout/view/components/cart_order_bottom_bar.dart';
import 'package:flutter_java_code_app/features/home_page/view/components/menu_card.dart';
import 'package:flutter_java_code_app/features/order/constants/order_assets_constant.dart';
import 'package:flutter_java_code_app/features/order/sub_features/order_again/controllers/order_order_again_controller.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:flutter_java_code_app/shared/styles/google_text_style.dart';
import 'package:flutter_java_code_app/shared/widgets/list_tile_app.dart';
import 'package:flutter_java_code_app/shared/widgets/section_header.dart';
import 'package:flutter_java_code_app/shared/widgets/universal_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderAgainScreen extends StatelessWidget {
  OrderAgainScreen({super.key});

  final assetsConstant = OrderAssetsConstant();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UniversalAppBar(
        title: 'Pesanan',
        icon: Icons.room_service,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (OrderOrderAgainController.to.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (OrderOrderAgainController.to.menuUIList.isEmpty) {
                return const Center(
                    child: Text('Belum ada menu yang dipilih.'));
              }
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Food section
                    if (OrderOrderAgainController.to.menuUIList
                        .where((menu) =>
                            menu.kategori.toLowerCase() == 'makanan' ||
                            menu.kategori.toLowerCase() == 'food')
                        .isNotEmpty) ...[
                      const SectionHeader(
                          title: 'Makanan', icon: Icons.fastfood),
                      12.verticalSpace,
                      ...OrderOrderAgainController.to.menuUIList
                          .where((menu) =>
                              menu.kategori.toLowerCase() == 'makanan' ||
                              menu.kategori.toLowerCase() == 'food')
                          .map((menu) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.5.h),
                          child: MenuCard(
                            isOrderAgain: true,
                            menu: menu,
                            onIncrement: () => OrderOrderAgainController.to
                                .incrementQuantity(menu),
                            onDecrement: () => OrderOrderAgainController.to
                                .decrementQuantity(menu),
                            isSelected: true,
                          ),
                        );
                      }),
                    ],
                    12.verticalSpace,
                    // Drink section
                    if (OrderOrderAgainController.to.menuUIList
                        .where((menu) =>
                            menu.kategori.toLowerCase() == 'minuman' ||
                            menu.kategori.toLowerCase() == 'drink')
                        .isNotEmpty) ...[
                      const SectionHeader(
                          title: 'Minuman', icon: Icons.local_drink),
                      12.verticalSpace,
                      ...OrderOrderAgainController.to.menuUIList
                          .where((menu) =>
                              menu.kategori.toLowerCase() == 'minuman' ||
                              menu.kategori.toLowerCase() == 'drink')
                          .map((menu) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.5.h),
                          child: MenuCard(
                            isOrderAgain: true,
                            menu: menu,
                            onIncrement: () => OrderOrderAgainController.to
                                .incrementQuantity(menu),
                            onDecrement: () => OrderOrderAgainController.to
                                .decrementQuantity(menu),
                            isSelected: true,
                          ),
                        );
                      }),
                    ],
                    12.verticalSpace,
                    // Snack section
                    if (OrderOrderAgainController.to.menuUIList
                        .where((menu) => menu.kategori.toLowerCase() == 'snack')
                        .isNotEmpty) ...[
                      const SectionHeader(title: 'Snack', icon: Icons.fastfood),
                      12.verticalSpace,
                      ...OrderOrderAgainController.to.menuUIList
                          .where(
                              (menu) => menu.kategori.toLowerCase() == 'snack')
                          .map((menu) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.5.h),
                          child: MenuCard(
                            isOrderAgain: true,
                            menu: menu,
                            onIncrement: () => OrderOrderAgainController.to
                                .incrementQuantity(menu),
                            onDecrement: () => OrderOrderAgainController.to
                                .decrementQuantity(menu),
                            isSelected: true,
                          ),
                        );
                      }),
                    ],
                  ],
                ),
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: Obx(() => Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 25.h, horizontal: 22.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTileApp(
                        title: RichText(
                          text: TextSpan(
                            text: 'Total Pesanan ',
                            style: GoogleTextStyle.fw600.copyWith(
                              fontSize: 18.sp,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    '(${OrderOrderAgainController.to.menuUIList.length} Menu)',
                                style: GoogleTextStyle.fw400.copyWith(
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        subtitle:
                            'Rp ${OrderOrderAgainController.to.totalPrice}',
                        subtitleBold: true,
                        subtitleColor: ColorStyle.primary,
                      ),
                      const Divider(),
                      ListTileApp(
                        bottomSheetFormType: BottomSheetFormType.none,
                        title: 'Diskon',
                        titleBold: true,
                        subtitle:
                            'Rp ${OrderOrderAgainController.to.discountPrice}',
                        subtitleColor: ColorStyle.danger,
                        leading: const Icon(Icons.discount),
                        onTapCustom: () {
                          Get.defaultDialog(
                            title: 'Info Diskon',
                            titleStyle: const TextStyle(
                              color: ColorStyle.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            content: SizedBox(
                              height: 100.h,
                              child: ListView.builder(
                                itemCount:
                                    CheckoutController.discountDummy.length,
                                itemBuilder: (context, index) {
                                  final itemDiscount =
                                      CheckoutController.discountDummy[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          itemDiscount['title']!,
                                          style: GoogleTextStyle.fw400
                                              .copyWith(fontSize: 18.sp),
                                        ),
                                        Text(
                                          itemDiscount['value']!,
                                          style: GoogleTextStyle.fw400
                                              .copyWith(fontSize: 18.sp),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Get.back(),
                                style: TextButton.styleFrom(
                                  backgroundColor: ColorStyle.info,
                                  side: const BorderSide(
                                      color: ColorStyle.primary),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 32.w),
                                  child: const Text(
                                    'Oke',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const Divider(),
                      ListTileApp(
                        leading: const Icon(Icons.card_giftcard),
                        title: 'Voucher',
                        titleBold: true,
                        subtitle: CheckoutVoucherController
                                    .selectedVoucherId.value !=
                                null
                            ? 'Rp ${CheckoutVoucherController.to.selectedVoucherNominal}'
                            : 'Pilih Voucher',
                        onTapCustom: () {
                          Get.toNamed(Routes.checkoutVoucherRoute);
                        },
                      ),
                      const Divider(),
                      ListTileApp(
                        leading: const Icon(Icons.payment),
                        title: 'Pembayaran',
                        titleBold: true,
                        subtitle: 'Pay Later',
                      ),
                    ],
                  ),
                ),
                CartOrderBottomBar(
                  totalPrice:
                      'Rp ${OrderOrderAgainController.to.grandTotalPrice}',
                  onOrderButtonPressed: OrderOrderAgainController.to.verify,
                ),
                const SizedBox(height: 16),
              ],
            ),
          )),
    );
  }
}
