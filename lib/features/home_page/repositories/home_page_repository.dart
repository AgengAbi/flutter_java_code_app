import 'package:dartz/dartz.dart';
import 'package:flutter_java_code_app/features/home_page/constants/home_page_api_constant.dart';
import 'package:flutter_java_code_app/features/home_page/models/menu.dart';
import 'package:flutter_java_code_app/features/home_page/models/menu_ui.dart';
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

  // * Menu list
  // Retrieve base list menu (without detail)
  static Future<Either<Failure, List<MenuUI>>> fetchMenus() async {
    try {
      String? token = LocalStorageService.getAuthToken();
      final dio = DioService.dioCall(token: token);
      final response = await dio.get(HomePageApiConstant.getAllMenus);

      if (response.statusCode == 200) {
        final List<dynamic> menuResponse = response.data['data'];
        AppLogger.i(
            'Successfully fetched menu data. Total: ${menuResponse.length} items');

        final List<Menu> menus =
            menuResponse.map((json) => Menu.fromJson(json)).toList();

        final List<MenuUI> menuUIList =
            menus.map((menu) => MenuUI.fromMenu(menu)).toList();

        return Right(menuUIList);
      } else {
        AppLogger.w(
            'Failed to fetch menu data. Status Code: ${response.statusCode}');
        return Left(ServerFailure(
            message: 'Failed to retrieve menu data',
            statusCode: response.statusCode));
      }
    } catch (e, stacktrace) {
      AppLogger.e('Unexpected Error: $e', e, stacktrace);
      return Left(NetworkFailure());
    }
  }
}
