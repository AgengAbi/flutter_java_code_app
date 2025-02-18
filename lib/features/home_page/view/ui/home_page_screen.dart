import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/features/home_page/constants/home_page_assets_constant.dart';
import 'package:flutter_java_code_app/features/home_page/controllers/home_page_controller.dart';
import 'package:flutter_java_code_app/features/home_page/view/components/promo_content.dart';
import 'package:flutter_java_code_app/shared/widgets/universal_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePageScreen extends StatelessWidget {
  HomePageScreen({super.key});

  final assetsConstant = HomePageAssetsConstant();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const UniversalAppBar(
          showSearch: true,
          // onSearchChanged: (value) => HomePageController.to.keyword(value),
        ),
        body: SmartRefresher(
          controller: HomePageController.to.refreshController,
          // enablePullDown: true,
          // onRefresh: HomePageController.to.onRefresh,
          // enablePullUp: HomePageController.to.canLoadMore.isTrue,
          // onLoading: HomePageController.to.getListOfData,
          // remove 'load failed' on bottom page
          // footer: CustomFooter(
          //   builder: (context, mode) {
          //     if (mode == LoadStatus.failed) {
          //       return const SizedBox.shrink();
          //     }
          //     return Container();
          //   },
          // ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const PromoContent(),
                // Body Content
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                  // child: const MenuContent(),
                  child: const Center(child: Text('Content')),
                ),
              ],
            ),
          ),
        ),
        // floatingActionButton: Obx(() {
        //   return FloatingActionButton(
        //     onPressed: () {
        //       Get.bottomSheet(
        //         Container(
        //           height: MediaQuery.of(context).size.height * 0.5,
        //           padding: const EdgeInsets.all(16),
        //           decoration: const BoxDecoration(
        //             color: Colors.white,
        //             borderRadius:
        //                 BorderRadius.vertical(top: Radius.circular(20)),
        //           ),
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               const Text(
        //                 "Pesanan Anda",
        //                 style: TextStyle(
        //                   fontSize: 20,
        //                   fontWeight: FontWeight.bold,
        //                 ),
        //               ),
        //               const SizedBox(height: 10),
        //               Expanded(
        //                 child: Obx(() {
        //                   final orderList = HomePageController.to.orderList;
        //                   if (orderList.isEmpty) {
        //                     return const Center(
        //                       child: Text("Belum ada menu yang dipilih."),
        //                     );
        //                   }
        //                   return ListView.builder(
        //                     itemCount: orderList.length,
        //                     itemBuilder: (context, index) {
        //                       final menu = orderList[index];
        //                       return ListTile(
        //                         title: Text(menu.nama),
        //                         subtitle: Text(
        //                             "Jumlah: ${menu.quantity},\ntopping: ${menu.toppingSelected?.map((t) => t.keterangan).join(', ')}, \nlevel: ${menu.levelSelected?.keterangan}\nnote: ${menu.note}"),
        //                       );
        //                     },
        //                   );
        //                 }),
        //               ),
        //               ElevatedButton(
        //                 onPressed: () {
        //                   HomePageController.to.onCheckoutPressed();
        //                 },
        //                 child: const Text('Checkout'),
        //               ),
        //             ],
        //           ),
        //         ),
        //         isScrollControlled: true,
        //       );
        //     },
        //     child: Stack(
        //       alignment: Alignment.center,
        //       children: [
        //         const Icon(Icons.shopping_cart),
        //         if (HomePageController.to.orderList.isNotEmpty)
        //           Positioned(
        //             right: 0,
        //             top: 0,
        //             child: Container(
        //               padding: const EdgeInsets.all(4),
        //               decoration: const BoxDecoration(
        //                 color: Colors.red,
        //                 shape: BoxShape.circle,
        //               ),
        //               constraints: const BoxConstraints(
        //                 minWidth: 20,
        //                 minHeight: 20,
        //               ),
        //               child: Obx(() {
        //                 return Text(
        //                   '${HomePageController.to.orderList.length}',
        //                   style: const TextStyle(
        //                     color: Colors.white,
        //                     fontSize: 12,
        //                   ),
        //                   textAlign: TextAlign.center,
        //                 );
        //               }),
        //             ),
        //           ),
        //       ],
        //     ),
        //   );
      ),
    );
  }
}
