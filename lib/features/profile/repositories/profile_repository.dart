import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_java_code_app/features/profile/constants/profile_api_constant.dart';
import 'package:flutter_java_code_app/features/profile/models/user.dart';
import 'package:flutter_java_code_app/shared/models/failure.dart';
import 'package:flutter_java_code_app/utils/services/dio_service.dart';
import 'package:flutter_java_code_app/utils/services/hive_service.dart';

class ProfileRepository {
  ProfileRepository._();

  var apiConstant = ProfileApiConstant();

  static Future<Either<Failure, User>> fetchUserDetails() async {
    try {
      final dio = DioService.dioCall(token: LocalStorageService.getAuthToken());

      final userId = LocalStorageService.userAuthBox.values.first.idUser;
      final response =
          await dio.get('${ProfileApiConstant.detailUser}/$userId');

      if (response.statusCode == 200 && response.data['status_code'] == 200) {
        final user = User.fromJson(response.data['data']);
        return Right(user);
      } else {
        return Left(ServerFailure(message: 'Error getting user details'));
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
