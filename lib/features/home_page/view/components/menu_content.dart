import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/constants/cores/assets/svg_constant.dart';
import 'package:flutter_java_code_app/features/home_page/controllers/home_page_controller.dart';
import 'package:flutter_java_code_app/features/home_page/view/components/menu_card.dart';
import 'package:flutter_java_code_app/features/home_page/view/components/menu_chip.dart';
import 'package:flutter_java_code_app/shared/widgets/section_header.dart';
import 'package:flutter_java_code_app/utils/functions/app_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class MenuContent extends StatefulWidget {
  const MenuContent({super.key});

  @override
  State<MenuContent> createState() => MenuContentState();
}

class MenuContentState extends State<MenuContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          if (HomePageController.to.isCategoryLoading.value) {
            return _buildShimmerForMenuChip();
          } else {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    HomePageController.to.uniqueCategories.map((category) {
                  String sectionTitle = category.capitalize!;
                  AppLogger.d('Section title: $sectionTitle');
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: MenuChip(
                      text: sectionTitle.tr,
                      icon: category == 'makanan'
                          ? SvgConstant.icFood
                          : category == 'minuman'
                              ? SvgConstant.icDrink
                              : category == 'snack'
                                  ? Icons.icecream_outlined
                                  : Icons.view_list_outlined,
                      isSelected: HomePageController.to.selectedCategory.value
                              .toLowerCase() ==
                          category,
                      onTap: () {
                        HomePageController.to.selectedCategory.value = category;
                      },
                    ),
                  );
                }).toList(),
              ),
            );
          }
        }),
        20.verticalSpace,
        Obx(() {
          if (HomePageController.to.selectedCategory.value.toLowerCase() ==
              'semua menu') {
            final uniqueCats = HomePageController.to.filteredList
                .map((menu) => menu.kategori.toLowerCase())
                .toSet()
                .toList();
            uniqueCats.sort();
            AppLogger.d('Unique categories: $uniqueCats');
            return uniqueCats.isEmpty
                ? _buildShimmerForMenuCards()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: uniqueCats.map((cat) {
                      final sectionTitle =
                          cat[0].toUpperCase() + cat.substring(1);
                      final listData = HomePageController.to.filteredList
                          .where((menu) => menu.kategori.toLowerCase() == cat)
                          .toList();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionHeader(
                            title: sectionTitle.tr,
                            icon: cat == 'makanan'
                                ? SvgConstant.icFood
                                : cat == 'minuman'
                                    ? SvgConstant.icDrink
                                    : cat == 'snack'
                                        ? Icons.icecream_outlined
                                        : Icons.view_list_outlined,
                          ),
                          12.verticalSpace,
                          ...listData.map((menu) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.5.h),
                              child: MenuCard(
                                menu: menu,
                                onIncrement: () => HomePageController.to
                                    .incrementQuantity(menu),
                                onDecrement: () => HomePageController.to
                                    .decrementQuantity(menu),
                                isSelected: HomePageController.to.selectedItems
                                    .contains(menu),
                              ),
                            );
                          }), // This converts the Iterable to List<Widget>
                          20.verticalSpace,
                        ],
                      );
                    }).toList(), // This converts the Iterable to List<Widget>
                  );
          } else {
            return Column(
              children: HomePageController.to.filteredList.map((menu) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.5.h),
                  child: MenuCard(
                    menu: menu,
                    onDecrement: () =>
                        HomePageController.to.decrementQuantity(menu),
                    onIncrement: () =>
                        HomePageController.to.incrementQuantity(menu),
                  ),
                );
              }).toList(),
            );
          }
        }),
      ],
    );
  }

  Widget _buildShimmerForMenuChip() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Row(
        children: List.generate(3, (index) {
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: Colors.grey[300],
              ),
              height: 40.h,
              width: 100.w,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildShimmerForMenuCards() {
    return Column(
      children: List.generate(3, (index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.5.h),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Colors.grey[300],
              ),
              height: 120.h,
            ),
          ),
        );
      }),
    );
  }
}
