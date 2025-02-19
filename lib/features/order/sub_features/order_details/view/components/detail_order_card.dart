import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/features/order/sub_features/order_details/models/order_detail_model.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DetailOrderCard extends StatelessWidget {
  final OrderDetail detail;
  const DetailOrderCard(this.detail, {super.key});

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: EdgeInsets.all(7.r),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.black87,
            offset: Offset(0, 2),
            blurRadius: 6,
            spreadRadius: -1,
          ),
        ],
      ),
      child: Row(
        children: [
          // Bagian gambar
          Container(
            height: 90.h,
            width: 90.w,
            margin: EdgeInsets.only(right: 12.w),
            padding: EdgeInsets.all(5.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.white,
            ),
            child: CachedNetworkImage(
              imageUrl: detail.foto.isNotEmpty
                  ? detail.foto
                  : 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
              fit: BoxFit.contain,
              errorWidget: (context, url, error) => CachedNetworkImage(
                imageUrl:
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Detail produk
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detail.nama,
                  style: Get.textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  'Rp ${detail.harga}',
                  style: Get.textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                4.verticalSpace,
                Row(
                  children: [
                    Icon(
                      Icons.edit_note_outlined,
                      size: 18.sp,
                      color: ColorStyle.primary,
                    ),
                    4.horizontalSpace,
                    Text(
                      detail.catatan.isNotEmpty
                          ? detail.catatan
                          : 'Tidak ada Catatan',
                      style: Get.textTheme.bodySmall!.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 75.r,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            alignment: Alignment.center,
            child: Text(
              '${detail.jumlah}',
              style: TextStyle(color: Colors.black, fontSize: 16.sp),
            ),
          ),
        ],
      ),
    );
  }
}
