import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/configs/routes/route.dart';
import 'package:flutter_java_code_app/constants/cores/assets/image_constant.dart';
import 'package:flutter_java_code_app/constants/cores/assets/svg_constant.dart';
import 'package:flutter_java_code_app/features/order/controllers/order_controller.dart';
import 'package:flutter_java_code_app/features/order/view/components/date_picker.dart';
import 'package:flutter_java_code_app/features/order/view/components/dropdown_status.dart';
import 'package:flutter_java_code_app/features/order/view/components/order_item_card.dart';
import 'package:flutter_java_code_app/utils/functions/app_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class OrderHistoryTabView extends StatelessWidget {
  const OrderHistoryTabView({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (OrderController.to.isLoading.value) {
        const CircularNotchedRectangle();
      }
      if (OrderController.to.filteredHistoryOrder.isEmpty) {
        AppLogger.d('Empty history orders');
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstant.bgPattern),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(SvgConstant.icNullOrders),
                SizedBox(height: 10.h),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 350.w),
                  child: Text(
                    "Mulai buat pesanan.\nMakanan yang kamu pesan akan muncul di sini agar kami bisa menemukan favoritmu lagi!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 21.sp,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(25.w, 12.h, 25.w, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownStatus(
                      items: OrderController.to.historyFilterStatus,
                      selectedItem:
                          OrderController.to.selectedCategoryOnHistory.value,
                      onChanged: (value) {
                        if (value != null) {
                          OrderController.to
                              .setDateFilterHistory(category: value);
                        }
                      },
                    ),
                    DatePicker(
                      onChanged: (dateRange) {
                        OrderController.to
                            .setDateFilterHistory(range: dateRange);
                      },
                      selectedDate:
                          OrderController.to.selectedDateRangeOnHistory.value,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async => OrderController.to.fetchOrders(),
                  child: ListView.separated(
                    padding: EdgeInsets.all(25.r),
                    itemBuilder: (context, index) => OrderItemCard(
                      order: OrderController.to.filteredHistoryOrder[index],
                      onTap: () {
                        Get.toNamed(
                          Routes.orderOrderDetailsRoute,
                          arguments: {
                            'orderId': OrderController
                                .to.filteredHistoryOrder[index].idOrder,
                          },
                        );
                      },
                      onGiveReview: () {
                        Get.toNamed(
                          Routes.createEvaluationRoute,
                        );
                      },
                      onOrderAgain: () {
                        Get.toNamed(
                          Routes.orderOrderAgainRoute,
                          arguments: {
                            'orderId': OrderController
                                .to.filteredHistoryOrder[index].idOrder,
                          },
                        );
                      },
                    ),
                    separatorBuilder: (context, index) => 16.verticalSpace,
                    itemCount: OrderController.to.filteredHistoryOrder.length,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Harga",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Obx(() => Text(
                          "Rp ${OrderController.to.totalHistoryOrder}",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
