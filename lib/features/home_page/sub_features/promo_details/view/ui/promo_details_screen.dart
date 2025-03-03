import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_java_code_app/constants/cores/assets/svg_constant.dart';
import 'package:flutter_java_code_app/features/home_page/sub_features/promo_details/controllers/home_page_promo_details_controller.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:flutter_java_code_app/shared/widgets/detail_stack_sheet.dart';
import 'package:flutter_java_code_app/shared/widgets/universal_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class PromoDetailScreen extends StatelessWidget {
  const PromoDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UniversalAppBar(
        title: 'Promo',
        icon: SvgConstant.icDiscount,
      ),
      body: Obx(() {
        if (HomePagePromoDetailsController.to.isLoading.value) {
          return const PromoDetailShimmer();
        }

        final promo = HomePagePromoDetailsController.to.promoItem.value;
        return DetailStackSheet(
          containerHeightPercentage: 0.3,
          containerContent: Center(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag:
                        'promo_${HomePagePromoDetailsController.to.promoId.value}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.r),
                      child: CachedNetworkImage(
                        imageUrl: promo?.foto ??
                            'https://cdn-site.gojek.com/uploads/PROMO_EDUKASI_COBAINGOJEK_FB_Ads_1_29d7243ace/PROMO_EDUKASI_COBAINGOJEK_FB_Ads_1_29d7243ace.jpg',
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
              Text('Nama Promo'.tr, style: Get.textTheme.titleMedium),
              10.verticalSpace,
              Text(promo?.nama ?? '',
                  style: TextStyle(
                      fontSize: 24.sp,
                      color: ColorStyle.primary,
                      fontWeight: FontWeight.bold)),
              const Divider(),
              Row(
                children: [
                  Icon(Icons.list, color: ColorStyle.primary, size: 32.r),
                  12.horizontalSpace,
                  Text('Syarat dan Ketentuan',
                      style: Get.textTheme.titleMedium),
                ],
              ),
              10.verticalSpace,
              Padding(
                padding: EdgeInsets.only(left: 35.w),
                child: Html(
                  data: promo?.syaratKetentuan ?? '',
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class PromoDetailShimmer extends StatelessWidget {
  const PromoDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 200.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
              ),
            ),
          ),
          20.verticalSpace,
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 200.w,
              height: 24.h,
              color: Colors.white,
            ),
          ),
          10.verticalSpace,
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 80.h,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
