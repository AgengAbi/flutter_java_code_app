import 'package:dartz/dartz.dart';
import 'package:flutter_java_code_app/features/home_page/constants/home_page_api_constant.dart';
import 'package:flutter_java_code_app/features/home_page/models/promo.dart';
import 'package:flutter_java_code_app/shared/models/failure.dart';
import 'package:flutter_java_code_app/utils/functions/app_logger.dart';
import 'package:flutter_java_code_app/utils/services/dio_service.dart';
import 'package:flutter_java_code_app/utils/services/hive_service.dart';

class HomePageRepository {
  HomePageRepository._();

  var apiConstant = HomePageApiConstant();

  // * Promo
  static Future<Either<Failure, List<Promo>>> fetchPromos() async {
    try {
      final dio = DioService.dioCall(token: LocalStorageService.getAuthToken());

      final response = await dio.get(HomePageApiConstant.getAllPromos);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        final List<Promo> promos = data.map((e) => Promo.fromJson(e)).toList();
        return Right(promos);
      } else {
        return Left(ServerFailure(
            message: 'Error getting promos', statusCode: response.statusCode));
      }
    } catch (e) {
      AppLogger.e('Error getting promos: $e');
      return Left(NetworkFailure());
    }
  }
}
