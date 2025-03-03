import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/constants/cores/assets/svg_constant.dart';
import 'package:flutter_java_code_app/features/home_page/controllers/home_page_controller.dart';
import 'package:flutter_java_code_app/features/home_page/sub_features/menu_details/controllers/home_page_menu_details_controller.dart';
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

class MenuDetailsScreen extends StatelessWidget {
  const MenuDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const UniversalAppBar(
        title: 'Detail Menu',
      ),
      body: Obx(() {
        if (HomePageMenuDetailsController.to.isLoading.value ||
            HomePageMenuDetailsController.to.selectedMenuDetail.value == null) {
          return const MenuDetailShimmer();
        }
        // Ambil instance menu dari controller detail
        final menu = HomePageMenuDetailsController.to.selectedMenuDetail.value!;
        final quantity = HomePageMenuDetailsController.to.getQuantity();

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
                // Name and Quantity
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
                      onIncrement: () {
                        HomePageMenuDetailsController.to.incrementQuantity();
                      },
                      onDecrement: () {
                        HomePageMenuDetailsController.to.decrementQuantity();
                      },
                    ),
                  ],
                ),
                16.verticalSpace,
                // Description
                Text(
                  menu.deskripsi,
                  style: GoogleTextStyle.fw400.copyWith(
                    fontSize: 14.sp,
                  ),
                ),
                32.verticalSpace,
                const Divider(),
                ListTileApp(
                  leading: SvgConstant.icPrice,
                  subtitleBold: true,
                  subtitleColor: ColorStyle.info,
                  title: 'Harga'.tr,
                  subtitle: menu.harga.toString(),
                ),
                const Divider(),
                ListTileApp(
                  leading: SvgConstant.icLevel,
                  menu: menu,
                  title: 'Level'.tr,
                  titleBottomSheet: 'Pilih Level'.tr,
                  subtitle: menu.levelSelected?.keterangan ?? '',
                  bottomSheetFormType: BottomSheetFormType.radio,
                  radioItems: menu.level,
                ),
                const Divider(),
                ListTileApp(
                  leading: SvgConstant.icTopping,
                  menu: menu,
                  title: 'Topping'.tr,
                  titleBottomSheet: 'Pilih Topping'.tr,
                  subtitle: menu.toppingSelected
                          ?.map((t) => t.keterangan)
                          .join(', ') ??
                      '',
                  bottomSheetFormType: BottomSheetFormType.checkbox,
                  checkboxItems: menu.topping,
                ),
                const Divider(),
                ListTileApp(
                  leading: SvgConstant.icNote,
                  menu: menu,
                  title: 'Catatan'.tr,
                  titleBottomSheet: 'Buat Catatan'.tr,
                  subtitle: menu.note ?? '',
                  bottomSheetFormType: BottomSheetFormType.textForm,
                  textFormArgument: menu.note ?? '',
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
                              HomePageController.to.addMenuToOrder(menu);
                              Get.snackbar(
                                  "Pesanan".tr,
                                  "${menu.nama} berhasil ditambahkan ke pesanan!"
                                      .tr);
                            }
                          : null,
                      child: Text(
                        "Tambahkan Ke Pesanan".tr,
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
                // Debug section untuk menampilkan data level dan topping
                // Container(
                //   margin: EdgeInsets.only(top: 16.r),
                //   padding: EdgeInsets.all(8.r),
                //   decoration: BoxDecoration(
                //     color: Colors.grey.shade200,
                //     borderRadius: BorderRadius.circular(8.r),
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         "DEBUG INFO",
                //         style: GoogleTextStyle.fw600.copyWith(
                //           fontSize: 16.sp,
                //           color: Colors.red,
                //         ),
                //       ),
                //       8.verticalSpace,
                //       Text(
                //         "Levels: ${menu.level != null ? menu.level!.map((lvl) => lvl.toJson().toString()).join(', ') : 'Tidak ada level'}",
                //         style: GoogleTextStyle.fw400.copyWith(fontSize: 14.sp),
                //       ),
                //       8.verticalSpace,
                //       Text(
                //         "Toppings: ${menu.topping != null ? menu.topping!.map((top) => top.toJson().toString()).join(', ') : 'Tidak ada topping'}",
                //         style: GoogleTextStyle.fw400.copyWith(fontSize: 14.sp),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class MenuDetailShimmer extends StatelessWidget {
  const MenuDetailShimmer({super.key});

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
            // Name and Quantity row shimmer
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
