import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/configs/routes/route.dart';
import 'package:flutter_java_code_app/features/home_page/controllers/home_page_controller.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FloatingActionButtonCart extends StatelessWidget {
  const FloatingActionButtonCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Container(
        width: 56.r,
        height: 56.r,
        decoration: BoxDecoration(
            color: ColorStyle.info,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 10,
                spreadRadius: -1,
                offset: const Offset(0, 2),
              )
            ]),
        child: IconButton(
          onPressed: () {
            Get.toNamed(Routes.checkoutRoute);
            // Get.bottomSheet(
            //   Container(
            //     height: MediaQuery.of(context).size.height * 0.5,
            //     padding: const EdgeInsets.all(16),
            //     decoration: const BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            //     ),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         const Text(
            //           "Pesanan Anda",
            //           style: TextStyle(
            //             fontSize: 20,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //         const SizedBox(height: 10),
            //         Expanded(
            //           child: Obx(() {
            //             final orderList = HomePageController.to.orderList;
            //             if (orderList.isEmpty) {
            //               return const Center(
            //                 child: Text("Belum ada menu yang dipilih."),
            //               );
            //             }
            //             return ListView.builder(
            //               itemCount: orderList.length,
            //               itemBuilder: (context, index) {
            //                 final menu = orderList[index];
            //                 return ListTile(
            //                   title: Text(menu.nama),
            //                   subtitle: Text(
            //                       "Jumlah: ${menu.quantity},\ntopping: ${menu.toppingSelected?.map((t) => t.keterangan).join(', ')}, \nlevel: ${menu.levelSelected?.keterangan}\nnote: ${menu.note}"),
            //                 );
            //               },
            //             );
            //           }),
            //         ),
            //         ElevatedButton(
            //           onPressed: () {
            //             // HomePageController.to.onCheckoutPressed();
            //           },
            //           child: const Text('Checkout'),
            //         ),
            //       ],
            //     ),
            //   ),
            //   isScrollControlled: true,
            // );
          },
          icon: const Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
          ),
        ),
      ),
      Positioned(
        right: -3,
        top: -8,
        child: Obx(() => HomePageController.to.orderList.isNotEmpty
            ? Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  HomePageController.to.orderList.length.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : const SizedBox.shrink()),
      )
    ]);
  }
}
