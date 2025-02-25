import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_java_code_app/features/checkout/constants/checkout_api_constant.dart';
import 'package:flutter_java_code_app/features/checkout/sub_features/voucher/models/voucher.dart';
import 'package:flutter_java_code_app/shared/models/failure.dart';
import 'package:flutter_java_code_app/utils/services/dio_service.dart';
import 'package:flutter_java_code_app/utils/services/hive_service.dart';

class VoucherRepository {
  VoucherRepository._();

  static Future<Either<Failure, List<Voucher>>> fetchVouchers() async {
    try {
      final dio = DioService.dioCall(token: LocalStorageService.getAuthToken());

      final response = await dio.get(CheckoutApiConstant.allVoucher);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];

        final List<Voucher> vouchers =
            data.map((e) => Voucher.fromJson(e)).toList();
        return Right(vouchers);
      } else {
        return Left(ServerFailure(
            message: 'Error getting vouchers',
            statusCode: response.statusCode));
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
