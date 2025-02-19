import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_java_code_app/features/order/constants/order_api_constant.dart';
import 'package:flutter_java_code_app/features/order/models/order_model.dart';
import 'package:flutter_java_code_app/shared/models/failure.dart';
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

        List<dynamic> last10Data =
            data.length > 10 ? data.sublist(data.length - 10) : data;

        final List<OrderModel> orders =
            last10Data.map((e) => OrderModel.fromJson(e)).toList();
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
