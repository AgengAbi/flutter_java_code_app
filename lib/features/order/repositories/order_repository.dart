import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_java_code_app/features/order/constants/order_api_constant.dart';
import 'package:flutter_java_code_app/features/order/models/order_model.dart';
import 'package:flutter_java_code_app/shared/models/failure.dart';
import 'package:flutter_java_code_app/utils/functions/app_logger.dart';
import 'package:flutter_java_code_app/utils/services/dio_service.dart';
import 'package:flutter_java_code_app/utils/services/hive_service.dart';

class OrderRepository {
  OrderRepository._();

  static Future<Either<Failure, List<OrderModel>>> fetchOrders() async {
    try {
      final dio = DioService.dioCall(token: LocalStorageService.getAuthToken());

      final userId = LocalStorageService.userAuthBox.values.first.idUser;
      final response = await dio.get('${OrderApiConstant.getOrders}/$userId');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];

        // Retrieve one order for each status 1,2,3,4
        // Logging: tampilkan semua status unik dalam data
        final statuses = data.map((order) => order['status']).toSet();
        AppLogger.d('Distinct statuses in data: $statuses');

        // Ambil satu order untuk masing-masing status 1, 2, 3, dan 4
        List<dynamic> extraOrders = [];
        for (var s in [1, 2, 3, 4]) {
          var order = data.firstWhere(
            (element) {
              // Pastikan kita membandingkan integer
              final statusValue = int.tryParse(element['status'].toString());
              return statusValue == s;
            },
            orElse: () => null,
          );
          if (order != null) {
            extraOrders.add(order);
            AppLogger.d(
                'Found extra order for status $s: id_order ${order['id_order']}');
          } else {
            AppLogger.d('No extra order found for status $s');
          }
        }
        AppLogger.d('Total extra orders: ${extraOrders.length}');

        // Retrieve the 20 latest data
        final List<dynamic> latest20Data =
            data.length > 20 ? data.sublist(data.length - 20) : data;

        // Reverse the order of the 20 latest data
        final List<dynamic> reversedData = latest20Data.reversed.toList();

        // Avoid duplication: if order with status 1,2,3,4 already exists in reversedData, don't add it again
        extraOrders = extraOrders
            .where((order) => !reversedData
                .any((element) => element['id_order'] == order['id_order']))
            .toList();

        final List<dynamic> combinedData = [...extraOrders, ...reversedData];

        final List<OrderModel> orders =
            combinedData.map((e) => OrderModel.fromJson(e)).toList();
        return Right(orders);
      } else {
        return Left(ServerFailure(
            message: 'Error getting orders', statusCode: response.statusCode));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(ServerFailure(
            message: e.response!.data['errors']?.join(", ") ??
                "Terjadi kesalahan server",
            statusCode: e.response!.statusCode ?? 500));
      } else {
        return Left(NetworkFailure());
      }
    }
  }
}
