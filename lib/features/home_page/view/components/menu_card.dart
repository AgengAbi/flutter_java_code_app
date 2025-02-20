import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/configs/routes/route.dart';
import 'package:flutter_java_code_app/features/home_page/models/menu_ui.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:flutter_java_code_app/shared/styles/google_text_style.dart';
import 'package:flutter_java_code_app/shared/widgets/quantity_control.dart';
import 'package:flutter_java_code_app/utils/functions/app_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class MenuCard extends StatelessWidget {
  final MenuUI menu;
  final bool isSelected;
  final void Function()? onIncrement;
  final void Function()? onDecrement;
  final bool isReactive;

  const MenuCard({
    super.key,
    required this.menu,
    this.onIncrement,
    this.onDecrement,
    this.isSelected = false,
    this.isReactive = true,
  });

  @override
  Widget build(BuildContext context) {
    final int currentQuantity = menu.quantity;

    return Container(
      padding: EdgeInsets.all(7.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: currentQuantity > 0 ? ColorStyle.info : Colors.transparent,
          width: 2.w,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorStyle.dark.withOpacity(0.5),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  AppLogger.d('MenuCard tapped for menu: ${menu.nama}');
                  Get.toNamed(Routes.homePageMenuDetailsRoute,
                      arguments: {'menuUI': menu});
                },
                child: Row(
                  children: [
                    Hero(
                      tag: 'menu_${menu.idMenu}',
                      child: Container(
                        height: 90.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.grey[100],
                        ),
                        child: CachedNetworkImage(
                          imageUrl: menu.foto,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            menu.nama,
                            style: TextStyle(fontSize: 20.sp),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            'Rp. ${NumberFormat("#,##0", "id_ID").format(menu.harga)}',
                            style: const TextStyle(
                              color: ColorStyle.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.edit_note,
                                color: ColorStyle.primary,
                              ),
                              Text(
                                'Tambahakan Catatan',
                                style: GoogleTextStyle.fw400.copyWith(
                                  color: ColorStyle.grey,
                                  fontSize: 12.sp,
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
            ),
          ),

          // Right section: Quantity Control.
          if (isReactive)
            QuantityControl(
              currentQuantity: currentQuantity,
              onIncrement: onIncrement,
              onDecrement: onDecrement,
            ),
        ],
      ),
    );
  }
}
