import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/constants/cores/assets/svg_constant.dart';
import 'package:flutter_java_code_app/features/home_page/controllers/home_page_controller.dart';
import 'package:flutter_java_code_app/features/home_page/view/components/promo_card.dart';
import 'package:flutter_java_code_app/shared/widgets/section_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shimmer/shimmer.dart';

class PromoContent extends StatelessWidget {
  const PromoContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          if (HomePageController.to.isPromosLoading.value ||
              HomePageController.to.promos.isEmpty) {
            return _buildPromoShimmerLoading();
          } else {
            return Column(
              children: [
                // Section Header
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 16.h),
                  child: const SectionHeader(
                    title: 'Promo yang Tersedia',
                    icon: SvgConstant.icDiscount,
                  ),
                ),
                CarouselSlider.builder(
                  itemCount: HomePageController.to.promos.length,
                  options: CarouselOptions(
                    height: 200.h,
                    enlargeCenterPage: false,
                    viewportFraction: 0.8,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                  ),
                  itemBuilder: (context, index, realIndex) {
                    final promo = HomePageController.to.promos[index];
                    return PromoCard(
                      promoItem: promo,
                      enableShadow: true,
                    );
                  },
                ),
              ],
            );
          }
        }),
      ],
    );
  }

  _buildPromoShimmerLoading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 16.h),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: Colors.grey[300],
                ),
                height: 40.h,
                width: 300.w,
              ),
            )),
        16.verticalSpace,
        CarouselSlider.builder(
          itemCount: 3,
          options: CarouselOptions(
            height: 200.h,
            enlargeCenterPage: true,
            viewportFraction: 0.8,
          ),
          itemBuilder: (context, index, realIndex) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 200.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
