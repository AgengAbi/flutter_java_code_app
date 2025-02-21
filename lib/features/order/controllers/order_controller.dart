import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/features/order/models/order_model.dart';
import 'package:flutter_java_code_app/features/order/repositories/order_repository.dart';
import 'package:flutter_java_code_app/utils/functions/app_logger.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  static OrderController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  RxList<OrderModel> onGoingOrders = <OrderModel>[].obs;
  RxList<OrderModel> historyOrders = <OrderModel>[].obs;

  final RxBool isLoading = true.obs;

  Rx<String> selectedCategory = 'all'.obs;

  Map<String, String> get dateFilterStatus => {
        'all': 'Semua Status'.tr,
        'completed': 'Selesai'.tr,
        'canceled': 'Dibatalkan'.tr,
      };

  // Reactive total price calculated directly from ongoing orders
  RxInt get totalPrice => onGoingOrders
      .fold<int>(
        0,
        (total, order) => total + (order.totalBayar),
      )
      .obs;

  // Reactive total price calculated directly from history orders
  RxInt get completedTotalPrice => historyOrders
      .fold<int>(
        0,
        (total, order) => total + (order.totalBayar),
      )
      .obs;

  Rx<DateTimeRange> selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  ).obs;

  Future<void> fetchOrders() async {
    final result = await OrderRepository.fetchOrders();
    result.fold(
      (failure) {
        AppLogger.d('Failed to retrive data from API');
      },
      (orders) {
        onGoingOrders.value = getOngoingOrders(orders);
        historyOrders.value = getHistoryOrders(orders);
        isLoading(false);
      },
    );
  }

  List<OrderModel> getOngoingOrders(List<OrderModel> orders) {
    return orders
        .where((order) => order.status >= 0 && order.status <= 2)
        .toList();
  }

  List<OrderModel> getHistoryOrders(List<OrderModel> orders) {
    return orders.where((order) => order.status >= 3).toList();
  }

  List<OrderModel> get filteredHistoryOrder {
    final historyOrderList = historyOrders.toList();

    if (selectedCategory.value == 'canceled') {
      historyOrderList.removeWhere((order) => order.status != 4);
    } else if (selectedCategory.value == 'completed') {
      historyOrderList.removeWhere((order) => order.status != 3);
    }

    // historyOrderList.removeWhere((order) =>
    //     DateTime.parse(order.tanggal).isBefore(selectedDateRange.value.start) ||
    //     DateTime.parse(order.tanggal).isAfter(selectedDateRange.value.end));

    historyOrderList.sort((a, b) =>
        DateTime.parse(b.tanggal).compareTo(DateTime.parse(a.tanggal)));

    return historyOrderList;
  }

  void setDateFilter({String? category, DateTimeRange? range}) {
    selectedCategory(category);
    selectedDateRange(range);
  }

  String get totalHistoryOrder {
    final total = filteredHistoryOrder.where((e) => e.status >= 3).fold(
        0, (previousValue, element) => previousValue + element.totalBayar);
    AppLogger.d('Total Harga History Order: $total');

    return total.toString();
  }
}
