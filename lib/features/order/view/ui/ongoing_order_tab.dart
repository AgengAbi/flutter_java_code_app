import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/configs/routes/route.dart';
import 'package:flutter_java_code_app/features/order/controllers/order_controller.dart';
import 'package:flutter_java_code_app/features/order/view/components/date_picker.dart';
import 'package:flutter_java_code_app/features/order/view/components/dropdown_status.dart';
import 'package:flutter_java_code_app/features/order/view/components/order_item_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnGoingOrderTabView extends StatelessWidget {
  const OnGoingOrderTabView({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    // analytics.setCurrentScreen(
    //   screenName: 'Ongoing Order Screen',
    //   screenClassOverride: 'Trainee',
    // );

    return Column(
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
                  }),
              DatePicker(
                onChanged: (dateRange) {
                  OrderController.to.setDateFilter(range: dateRange);
                },
                selectedDate: OrderController.to.selectedDateRange.value,
              )
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
                  order: OrderController.to.onGoingOrders[index],
                  onTap: () {
                    Get.toNamed(
                      Routes.orderOrderDetailsRoute,
                      arguments: {
                        'orderId':
                            OrderController.to.onGoingOrders[index].idOrder,
                      },
                    );
                  },
                  onOrderAgain: () {},
                ),
                separatorBuilder: (context, index) => 16.verticalSpace,
                itemCount: OrderController.to.onGoingOrders.length,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
