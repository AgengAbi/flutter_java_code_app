import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/features/order/constants/order_assets_constant.dart';
import 'package:flutter_java_code_app/features/order/view/ui/ongoing_order_tab.dart';
import 'package:flutter_java_code_app/features/order/view/ui/order_history_tab.dart';
import 'package:flutter_java_code_app/shared/widgets/universal_app_bar.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({super.key});

  final assetsConstant = OrderAssetsConstant();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: UniversalAppBar(
            showTabs: true,
            tabs: [
              Tab(text: 'Sedang Berjalan'.tr),
              Tab(text: 'Riwayat'.tr),
            ],
          ),
          body: const TabBarView(
            children: [
              OnGoingOrderTabView(),
              OrderHistoryTabView(),
            ],
          ),
        ),
      ),
    );
  }
}
