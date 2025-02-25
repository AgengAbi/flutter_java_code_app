import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_java_code_app/features/checkout/sub_features/voucher/models/voucher.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:flutter_java_code_app/shared/widgets/detail_stack_sheet.dart';
import 'package:flutter_java_code_app/shared/widgets/universal_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VoucherDetail extends StatelessWidget {
  const VoucherDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final Voucher voucher = Get.arguments as Voucher;
    print('${voucher.periodeMulai} - ${voucher.periodeSelesai}');
    return Scaffold(
        appBar: const UniversalAppBar(
          title: 'Detail Voucher',
        ),
        body: DetailStackSheet(
          containerHeightPercentage: 0.3,
          containerContent: Center(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'voucher_${voucher.idVoucher}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.r),
                      child: CachedNetworkImage(
                        imageUrl: voucher.infoVoucher,
                        width: double.infinity,
                        height: 200.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          draggableContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(voucher.nama,
                  style: TextStyle(
                      fontSize: 24.sp,
                      color: ColorStyle.primary,
                      fontWeight: FontWeight.bold)),
              4.verticalSpace,
              Html(
                data: voucher.catatan,
                style: {
                  "body": Style(
                    fontSize: FontSize(14.sp),
                    fontWeight: FontWeight.w400,
                  ),
                },
              ),
              32.verticalSpace,
              const Divider(),
              ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.calendar_month_outlined,
                    color: ColorStyle.primary,
                  ),
                  title: Transform.translate(
                    offset: const Offset(-12, 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Valid Date',
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            '${DateFormat('yyyy/MM/dd').format(voucher.periodeMulai)} - ${DateFormat('yyyy/MM/dd').format(voucher.periodeSelesai)}',
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                        ]),
                  )),
              const Divider(),
            ],
          ),
        ));
  }
}
