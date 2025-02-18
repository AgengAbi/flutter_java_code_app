import 'package:dartz/dartz.dart';
import 'package:flutter_java_code_app/features/home_page/constants/home_page_api_constant.dart';
import 'package:flutter_java_code_app/features/home_page/sub_features/promo_details/models/promo_details.dart';
import 'package:flutter_java_code_app/shared/models/failure.dart';
import 'package:flutter_java_code_app/utils/functions/app_logger.dart';
import 'package:flutter_java_code_app/utils/services/dio_service.dart';
import 'package:flutter_java_code_app/utils/services/hive_service.dart';

class PromoDetailsRepository {
  PromoDetailsRepository._();

  static Future<Either<Failure, PromoDetails?>> fetchPromoDetail(
      int promoId) async {
    try {
      final dio = DioService.dioCall(token: LocalStorageService.getAuthToken());

      final response =
          await dio.get('${HomePageApiConstant.getPromoDetail}/$promoId');

      if (response.statusCode == 200) {
        final promo = PromoDetails.fromJson(response.data['data']);
        return Right(promo);
      } else {
        return Left(ServerFailure(
            message: 'Error getting promo detail',
            statusCode: response.statusCode));
      }
    } catch (e) {
      AppLogger.e('Error getting promo detail: $e');
      return Left(NetworkFailure());
    }
  }
}
