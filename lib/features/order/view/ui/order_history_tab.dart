import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/configs/routes/route.dart';
import 'package:flutter_java_code_app/features/order/controllers/order_controller.dart';
import 'package:flutter_java_code_app/features/order/view/components/date_picker.dart';
import 'package:flutter_java_code_app/features/order/view/components/dropdown_status.dart';
import 'package:flutter_java_code_app/features/order/view/components/order_item_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderHistoryTabView extends StatelessWidget {
  const OrderHistoryTabView({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
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
                    items: OrderController.to.dateFilterStatus,
                    selectedItem: OrderController.to.selectedCategory.value,
                    onChanged: (value) {
                      if (value != null) {
                        OrderController.to.setDateFilter(category: value);
                      }
                    },
                  ),
                  DatePicker(
                    onChanged: (dateRange) {
                      OrderController.to.setDateFilter(range: dateRange);
                    },
                    selectedDate: OrderController.to.selectedDateRange.value,
                  ),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => OrderController.to.fetchOrders(),
                child: Obx(
                  () => ListView.separated(
                    padding: EdgeInsets.all(25.r),
                    itemBuilder: (context, index) => OrderItemCard(
                      order: OrderController.to.historyOrders[index],
                      onTap: () {
                        Get.toNamed(
                          '${Routes.orderRoute}/${OrderController.to.historyOrders[index].idOrder}',
                        );
                      },
                      onOrderAgain: () {},
                    ),
                    separatorBuilder: (context, index) => 16.verticalSpace,
                    itemCount: OrderController.to.historyOrders.length,
                  ),
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
  }
}
