import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/constants/cores/assets/svg_constant.dart';
import 'package:flutter_java_code_app/features/order/sub_features/order_again_details/controllers/order_order_again_details_controller.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:flutter_java_code_app/shared/styles/elevated_button_style.dart';
import 'package:flutter_java_code_app/shared/styles/google_text_style.dart';
import 'package:flutter_java_code_app/shared/widgets/detail_stack_sheet.dart';
import 'package:flutter_java_code_app/shared/widgets/list_tile_app.dart';
import 'package:flutter_java_code_app/shared/widgets/quantity_control.dart';
import 'package:flutter_java_code_app/shared/widgets/universal_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class OrderAgainMenuDetailsScreen extends StatelessWidget {
  const OrderAgainMenuDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const UniversalAppBar(title: 'Detail Menu'),
      body: Obx(() {
        final controller = OrderOrderAgainDetailsController.to;
        if (controller.isLoading.value ||
            controller.selectedMenuDetail.value == null) {
          return const OrderAgainMenuDetailShimmer();
        }
        final menu = controller.selectedMenuDetail.value!;
        final quantity = controller.getQuantity();
        return DetailStackSheet(
          containerHeightPercentage: 0.3,
          containerContent: Hero(
            tag: 'menu_${menu.idMenu}',
            child: CachedNetworkImage(
              imageUrl: menu.foto,
              height: 250.h,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 250.h,
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          draggableContent: SingleChildScrollView(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and Quantity Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        menu.nama,
                        overflow: TextOverflow.visible,
                        maxLines: 2,
                        style: GoogleTextStyle.fw600.copyWith(
                          fontSize: 24.sp,
                          color: ColorStyle.info,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    4.horizontalSpace,
                    QuantityControl(
                      currentQuantity: quantity,
                      onIncrement: () => controller.incrementQuantity(),
                      onDecrement: () => controller.decrementQuantity(),
                    ),
                  ],
                ),
                16.verticalSpace,
                // Description
                Text(
                  menu.deskripsi,
                  style: GoogleTextStyle.fw400.copyWith(fontSize: 14.sp),
                ),
                32.verticalSpace,
                const Divider(),
                ListTileApp(
                  leading: SvgConstant.icPrice,
                  subtitleBold: true,
                  subtitleColor: ColorStyle.info,
                  title: 'Harga',
                  subtitle: menu.harga.toString(),
                ),
                const Divider(),
                ListTileApp(
                  leading: SvgConstant.icLevel,
                  menu: menu,
                  title: 'Level',
                  titleBottomSheet: 'Pilih Level',
                  subtitle: menu.levelSelected?.keterangan ?? '',
                  bottomSheetFormType: BottomSheetFormType.radio,
                  radioItems: menu.level,
                  onUpdateLevel: (selectedLevel) =>
                      OrderOrderAgainDetailsController.to
                          .updateMenuLevel(selectedLevel),
                ),
                const Divider(),
                ListTileApp(
                  leading: SvgConstant.icTopping,
                  menu: menu,
                  title: 'Topping',
                  titleBottomSheet: 'Pilih Topping',
                  subtitle: menu.toppingSelected
                          ?.map((t) => t.keterangan)
                          .join(', ') ??
                      '',
                  bottomSheetFormType: BottomSheetFormType.checkbox,
                  checkboxItems: menu.topping,
                  onUpdateTopping: (selectedToppings) =>
                      OrderOrderAgainDetailsController.to
                          .updateMenuTopping(selectedToppings),
                ),
                const Divider(),
                ListTileApp(
                  leading: SvgConstant.icNote,
                  menu: menu,
                  title: 'Catatan',
                  titleBottomSheet: 'Buat Catatan',
                  subtitle: menu.note ?? '',
                  bottomSheetFormType: BottomSheetFormType.textForm,
                  textFormArgument: menu.note ?? '',
                  onUpdateNote: (newNote) => OrderOrderAgainDetailsController.to
                      .updateMenuNote(newNote),
                ),
                const Divider(),
                32.verticalSpace,
                // Add to Order Button
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      style: ElevatedButtonStyle.mainRounded,
                      onPressed: menu.quantity > 0
                          ? () {
                              // Misalnya, perbarui data di order again (atau berikan feedback)
                              Get.snackbar(
                                  "Pesanan", "${menu.nama} telah diperbarui!");
                              // Jika diperlukan, navigasi kembali:
                              // Get.back();
                            }
                          : null,
                      child: Text(
                        "Tambahkan Ke Pesanan",
                        style: GoogleTextStyle.fw800.copyWith(
                          fontSize: 14.sp,
                          color: ColorStyle.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                24.verticalSpace,
              ],
            ),
          ),
        );
      }),
    );
  }
}

class OrderAgainMenuDetailShimmer extends StatelessWidget {
  const OrderAgainMenuDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return DetailStackSheet(
      containerHeightPercentage: 0.3,
      containerContent: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 250.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
      ),
      draggableContent: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shimmer for Name and Quantity Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 200.w,
                  height: 24.h,
                  color: Colors.white,
                ),
                Container(
                  width: 50.w,
                  height: 24.h,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
