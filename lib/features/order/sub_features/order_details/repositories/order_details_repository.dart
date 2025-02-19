import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_java_code_app/features/order/constants/order_api_constant.dart';
import 'package:flutter_java_code_app/features/order/sub_features/order_details/models/order_detail_model.dart';
import 'package:flutter_java_code_app/shared/models/failure.dart';
import 'package:flutter_java_code_app/utils/services/dio_service.dart';
import 'package:flutter_java_code_app/utils/services/hive_service.dart';

class OrderDetailsRepository {
  OrderDetailsRepository._();

  static Future<Either<Failure, OrderDetailModel>> fetchOrderDetails(
      int orderId) async {
    try {
      final dio = DioService.dioCall(token: LocalStorageService.getAuthToken());

      final response =
          await dio.get('${OrderApiConstant.getOrderDetails}/$orderId');

      if (response.statusCode == 200) {
        final data = response.data['data'] as Map<String, dynamic>;
        final orderDetails = OrderDetailModel.fromJson(data);
        return Right(orderDetails);
      } else {
        return Left(ServerFailure(
          message: 'Error getting order details',
          statusCode: response.statusCode,
        ));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(ServerFailure(
          message: e.response!.data['errors']?.join(", ") ??
              "Terjadi kesalahan server",
          statusCode: e.response!.statusCode ?? 500,
        ));
      } else {
        return Left(NetworkFailure());
      }
    }
  }
}
