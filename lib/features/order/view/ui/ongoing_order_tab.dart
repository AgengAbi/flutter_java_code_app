import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/configs/routes/route.dart';
import 'package:flutter_java_code_app/constants/cores/assets/image_constant.dart';
import 'package:flutter_java_code_app/constants/cores/assets/svg_constant.dart';
import 'package:flutter_java_code_app/features/order/controllers/order_controller.dart';
import 'package:flutter_java_code_app/features/order/view/components/date_picker.dart';
import 'package:flutter_java_code_app/features/order/view/components/dropdown_status.dart';
import 'package:flutter_java_code_app/features/order/view/components/order_item_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class OnGoingOrderTabView extends StatelessWidget {
  const OnGoingOrderTabView({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (OrderController.to.isLoading.value ||
          OrderController.to.onGoingOrders.isEmpty) {
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
                    "Sudah Pesan? \nLacak pesananmu di sini.",
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

      return Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(25.w, 12.h, 25.w, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownStatus(
                  items: OrderController.to.onGoingFilterStatus,
                  selectedItem:
                      OrderController.to.selectedCategoryOnGoing.value,
                  onChanged: (value) {
                    if (value != null) {
                      OrderController.to.setDateFilterOnGoing(category: value);
                    }
                  },
                ),
                DatePicker(
                  onChanged: (dateRange) {
                    OrderController.to.setDateFilterOnGoing(range: dateRange);
                  },
                  selectedDate:
                      OrderController.to.selectedDateRangeOnGoing.value,
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
                  order: OrderController.to.filteredOnGoingOrder[index],
                  onTap: () {
                    Get.toNamed(
                      Routes.orderOrderDetailsRoute,
                      arguments: {
                        'orderId': OrderController
                            .to.filteredOnGoingOrder[index].idOrder,
                      },
                    );
                  },
                  onOrderAgain: () {},
                ),
                separatorBuilder: (context, index) => 16.verticalSpace,
                itemCount: OrderController.to.filteredOnGoingOrder.length,
              ),
            ),
          ),
        ],
      );
    });
  }
}
