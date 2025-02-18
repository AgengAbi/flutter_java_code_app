import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/features/home_page/controllers/home_page_controller.dart';
import 'package:flutter_java_code_app/features/home_page/view/ui/home_page_screen.dart';
import 'package:flutter_java_code_app/features/main_page/constants/main_page_assets_constant.dart';
import 'package:flutter_java_code_app/features/main_page/controllers/main_page_controller.dart';
import 'package:flutter_java_code_app/features/order/controllers/order_controller.dart';
import 'package:flutter_java_code_app/features/order/view/ui/order_screen.dart';
import 'package:flutter_java_code_app/features/profile/controllers/profile_controller.dart';
import 'package:flutter_java_code_app/features/profile/view/ui/profile_screen.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MainPageScreen extends StatelessWidget {
  MainPageScreen({super.key}) {
    Get.lazyPut(() => HomePageController());
    Get.lazyPut(() => OrderController());
    Get.lazyPut(() => ProfileController());
  }

  final assetsConstant = MainPageAssetsConstant();

  final List<Widget> _pages = [
    HomePageScreen(),
    OrderScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return IndexedStack(
          index: MainPageController.to.currentIndex.value,
          children: _pages,
        );
      }),
      bottomNavigationBar: Obx(() {
        return Padding(
          padding: EdgeInsets.only(top: 12.h),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
            child: BottomNavigationBar(
              backgroundColor: ColorStyle.dark,
              currentIndex: MainPageController.to.currentIndex.value,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              onTap: (index) => MainPageController.to.changeTab(index),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Beranda',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.room_service),
                  label: 'Pesenan',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_outlined),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
