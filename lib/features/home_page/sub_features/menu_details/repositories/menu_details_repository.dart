import 'package:dartz/dartz.dart';
import 'package:flutter_java_code_app/features/home_page/constants/home_page_api_constant.dart';
import 'package:flutter_java_code_app/features/home_page/sub_features/menu_details/models/menu_detail.dart';
import 'package:flutter_java_code_app/shared/models/failure.dart';
import 'package:flutter_java_code_app/utils/functions/app_logger.dart';
import 'package:flutter_java_code_app/utils/services/dio_service.dart';
import 'package:flutter_java_code_app/utils/services/hive_service.dart';

class MenuDetailsRepository {
  MenuDetailsRepository._();

  var apiConstant = HomePageApiConstant();

  static Future<Either<Failure, MenuDetail>> fetchMenuDetails(
      int idMenu) async {
    try {
      final dio = DioService.dioCall(token: LocalStorageService.getAuthToken());

      final response =
          await dio.get('${HomePageApiConstant.getMenuDetail}/$idMenu');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final MenuDetail menuDetail = MenuDetail.fromJson(data);

        return Right(menuDetail);
      } else {
        return Left(ServerFailure(
          message: 'Error fetching menu detail',
          statusCode: response.statusCode,
        ));
      }
    } catch (e) {
      AppLogger.e('Error fetching menu detail: $e');
      return Left(NetworkFailure());
    }
  }
}
