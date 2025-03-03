import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/configs/themes/app_theme.dart';
import 'package:flutter_java_code_app/features/order/models/order_model.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderItemCard extends StatelessWidget {
  const OrderItemCard({
    super.key,
    required this.order,
    this.onTap,
    this.onOrderAgain,
    this.onGiveReview,
  });

  final OrderModel order;
  final VoidCallback? onTap;
  final VoidCallback? onOrderAgain;
  final VoidCallback? onGiveReview;

  @override
  Widget build(BuildContext context) {
    final int status = order.status;
    final List<MenuModel> menu = order.menu;
    final int menuCount = menu.length;

    String statusText = '';
    IconData statusIcon = Icons.cancel;
    Color statusColor = Colors.red;

    switch (status.toInt()) {
      case 0:
        statusText = "Pesanan diterima".tr;
        statusIcon = Icons.access_time;
        statusColor = Colors.orange;
        break;
      case 1:
        statusText = "Silahkan diambil".tr;
        statusIcon = Icons.check;
        statusColor = Colors.blueAccent;
        break;
      case 2:
        statusText = "Pesanan selesai".tr;
        statusIcon = Icons.check_circle;
        statusColor = Colors.green;
        break;
      case 3:
        statusText = "Selesai".tr;
        statusIcon = Icons.check_circle;
        statusColor = Colors.green;
        break;
      case 4:
        statusText = "Dibatalkan".tr;
        statusIcon = Icons.cancel_outlined;
        statusColor = Colors.red;
        break;
      default:
        statusText = "Tidak dapat ditracking".tr;
        statusIcon = Icons.cancel;
        statusColor = Colors.red;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                menu.isNotEmpty ? menu.first.foto : "",
                width: 60.w,
                height: 60.w,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.image_not_supported,
                  size: 60.w,
                  color: Colors.grey.shade300,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            statusIcon,
                            size: 16.w,
                            color: statusColor,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            statusText,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: statusColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        order.tanggal,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    menu.map((e) => e.nama).join(", "),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        "Rp ${order.totalBayar}",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorStyle.info,
                        ),
                      ),
                      12.horizontalSpace,
                      Text(
                        "($menuCount Menu)",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      if (status == 4)
                        ElevatedButton(
                          onPressed: onGiveReview,
                          style: ElevatedButtonStyles.smallSecondary,
                          child: Text(
                            "Beri penilaian".tr,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      if (status == 4) SizedBox(width: 8.w),
                      if (status == 4 || status == 3)
                        ElevatedButton(
                          onPressed: onOrderAgain,
                          style: ElevatedButtonStyles.smallPrimary,
                          child: Text(
                            "Pesan lagi".tr,
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
