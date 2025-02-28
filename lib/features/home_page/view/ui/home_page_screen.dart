import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/features/home_page/constants/home_page_assets_constant.dart';
import 'package:flutter_java_code_app/features/home_page/controllers/home_page_controller.dart';
import 'package:flutter_java_code_app/features/home_page/view/components/floating_action_button_cart.dart';
import 'package:flutter_java_code_app/features/home_page/view/components/menu_content.dart';
import 'package:flutter_java_code_app/features/home_page/view/components/promo_content.dart';
import 'package:flutter_java_code_app/shared/widgets/universal_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePageScreen extends StatelessWidget {
  HomePageScreen({super.key});

  final assetsConstant = HomePageAssetsConstant();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: UniversalAppBar(
              showSearch: true,
              onSearchChanged: (value) => HomePageController.to.keyword(value),
            ),
            body: SmartRefresher(
              controller: HomePageController.to.homeRefreshController,
              enablePullDown: true,
              onRefresh: () async {
                HomePageController.to.getHomePageData();
                HomePageController.to.homeRefreshController.refreshCompleted();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const PromoContent(),
                    // Body Content
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.w, vertical: 20.h),
                      child: const MenuContent(),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: const FloatingActionButtonCart()));
  }
}
