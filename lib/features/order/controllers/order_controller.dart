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

  Rx<String> selectedCategoryOnGoing = 'all'.obs;
  Rx<String> selectedCategoryOnHistory = 'all'.obs;

  Map<String, String> get onGoingFilterStatus => {
        'all': 'Semua Status'.tr,
        'order received': 'Pesanan diterima'.tr,
        'please take it': 'Silahkan diambil'.tr,
        'order complated': 'Pesanan selesai'.tr,
      };

  Map<String, String> get historyFilterStatus => {
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

  Rx<DateTimeRange> selectedDateRangeOnGoing = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  ).obs;

  Rx<DateTimeRange> selectedDateRangeOnHistory = DateTimeRange(
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

    if (selectedCategoryOnHistory.value == 'canceled') {
      historyOrderList.removeWhere((order) => order.status != 3);
    } else if (selectedCategoryOnHistory.value == 'completed') {
      historyOrderList.removeWhere((order) => order.status != 4);
    }

    historyOrderList.removeWhere((order) =>
        DateTime.parse(order.tanggal)
            .isBefore(selectedDateRangeOnHistory.value.start) ||
        DateTime.parse(order.tanggal)
            .isAfter(selectedDateRangeOnHistory.value.end));

    historyOrderList.sort((a, b) {
      final dateA = DateTime.tryParse(a.tanggal) ?? DateTime(0);
      final dateB = DateTime.tryParse(b.tanggal) ?? DateTime(0);
      return dateB.compareTo(dateA);
    });

    return historyOrderList;
  }

  List<OrderModel> get filteredOnGoingOrder {
    final onGoingOrderList = onGoingOrders.toList();

    if (selectedCategoryOnGoing.value == 'order received') {
      onGoingOrderList.removeWhere((order) => order.status != 0);
    } else if (selectedCategoryOnGoing.value == 'please take it') {
      onGoingOrderList.removeWhere((order) => order.status != 1);
    } else if (selectedCategoryOnGoing.value == 'order complated') {
      onGoingOrderList.removeWhere((order) => order.status != 2);
    }

    onGoingOrderList.removeWhere((order) =>
        DateTime.parse(order.tanggal)
            .isBefore(selectedDateRangeOnGoing.value.start) ||
        DateTime.parse(order.tanggal)
            .isAfter(selectedDateRangeOnGoing.value.end));

    onGoingOrderList.sort((a, b) {
      final dateA = DateTime.tryParse(a.tanggal) ?? DateTime(0);
      final dateB = DateTime.tryParse(b.tanggal) ?? DateTime(0);
      return dateB.compareTo(dateA);
    });

    return onGoingOrderList;
  }

  void setDateFilterHistory({String? category, DateTimeRange? range}) {
    selectedCategoryOnHistory(category);
    selectedDateRangeOnHistory(range);
  }

  void setDateFilterOnGoing({String? category, DateTimeRange? range}) {
    selectedCategoryOnGoing(category);
    selectedDateRangeOnGoing(range);
  }

  String get totalHistoryOrder {
    final total = filteredHistoryOrder.where((e) => e.status >= 3).fold(
        0, (previousValue, element) => previousValue + element.totalBayar);
    AppLogger.d('Total Harga History Order: $total');

    return total.toString();
  }
}
