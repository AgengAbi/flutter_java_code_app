import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/constants/cores/assets/svg_constant.dart';
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
            HomePageMenuDetailsController.to.menuDetails.value == null) {
          return const MenuDetailShimmer();
        }

        final details = HomePageMenuDetailsController.to.menuDetails.value!;
        final menus = HomePageMenuDetailsController.to.menuUI.value!;

        return DetailStackSheet(
          containerHeightPercentage: 0.3,
          containerContent: Hero(
            tag: 'menu_${menus.idMenu}',
            child: CachedNetworkImage(
              imageUrl: HomePageMenuDetailsController.to.menuUI.value!.foto,
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
                        details.nama,
                        overflow: TextOverflow.visible,
                        maxLines: 2,
                        style: GoogleTextStyle.fw600.copyWith(
                          fontSize: 24.sp,
                          color: ColorStyle.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    4.horizontalSpace,
                    QuantityControl(
                      currentQuantity:
                          HomePageMenuDetailsController.to.quantity,
                      onIncrement: () {
                        HomePageMenuDetailsController.to.incrementQuantity(
                            HomePageMenuDetailsController.to.menuUI.value!);
                      },
                      onDecrement: () {
                        HomePageMenuDetailsController.to.decrementQuantity(
                            HomePageMenuDetailsController.to.menuUI.value!);
                      },
                    ),
                  ],
                ),
                16.verticalSpace,
                // Description
                Text(
                  details.deskripsi,
                  style: GoogleTextStyle.fw400.copyWith(
                    fontSize: 14.sp,
                  ),
                ),
                32.verticalSpace,
                const Divider(),
                ListTileApp(
                  leading: SvgConstant.icPrice,
                  subtitleBold: true,
                  subtitleColor: ColorStyle.primary,
                  title: 'Harga',
                  subtitle: details.harga.toString(),
                ),
                const Divider(),
                // ListTileApp(
                //   leading: SvgConstant.icLevel,
                //   // menu: updatedMenu,
                //   title: 'Level',
                //   titleBottomSheet: 'Pilih Level',
                //   subtitle: details.level?.keterangan ?? '',
                //   bottomSheetFormType: BottomSheetFormType.radio,
                //   radioItems: details.level,
                // ),
                // const Divider(),
                // ListTileApp(
                //   leading: SvgConstant.icTopping,
                //   // menu: updatedMenu,
                //   title: 'Topping',
                //   titleBottomSheet: 'Pilih Topping',
                //   subtitle: details.toppingSelected
                //           ?.map((t) => t.keterangan)
                //           .join(', ') ??
                //       '',
                //   bottomSheetFormType: BottomSheetFormType.checkbox,
                //   checkboxItems: details.topping,
                // ),
                // const Divider(),
                // ListTileApp(
                //   leading: SvgConstant.icNote,
                //   // menu: updatedMenu,
                //   title: 'Catatan',
                //   titleBottomSheet: 'Buat Catatan',
                //   subtitle: details.note ?? '',
                //   bottomSheetFormType: BottomSheetFormType.textForm,
                //   textFormArgument: details.note ?? '',
                // ),
                // const Divider(),
                32.verticalSpace,
                // Add to Order Button
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      style: ElevatedButtonStyle.mainRounded,
                      onPressed: HomePageMenuDetailsController.to.quantity > 0
                          ? () {
                              // HomePageController.to.addMenuToOrder(updatedMenu);
                              Get.snackbar("Pesanan",
                                  "${details.nama} berhasil ditambahkan ke pesanan!");
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
            16.verticalSpace,
            // Description shimmer
            Container(
              width: double.infinity,
              height: 80.h,
              color: Colors.white,
            ),
            32.verticalSpace,
            const Divider(),
            // Price tile shimmer
            Container(
              width: double.infinity,
              height: 20.h,
              color: Colors.white,
            ),
            const Divider(),
            // Level tile shimmer
            Container(
              width: double.infinity,
              height: 20.h,
              color: Colors.white,
            ),
            const Divider(),
            // Topping tile shimmer
            Container(
              width: double.infinity,
              height: 20.h,
              color: Colors.white,
            ),
            const Divider(),
            // Note tile shimmer
            Container(
              width: double.infinity,
              height: 20.h,
              color: Colors.white,
            ),
            const Divider(),
            32.verticalSpace,
            // Button shimmer
            Container(
              width: double.infinity,
              height: 48.h,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
