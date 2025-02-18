import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_java_code_app/features/sign_in/constants/sign_in_api_constant.dart';
import 'package:flutter_java_code_app/features/sign_in/models/login_response_model.dart';
import 'package:flutter_java_code_app/shared/models/failure.dart';
import 'package:flutter_java_code_app/utils/services/dio_service.dart';

class SignInRepository {
  SignInRepository._();

  static Future<Either<Failure, LoginResponseModel>> login(
    String email,
    String password,
  ) async {
    try {
      final dio = DioService.dioCall();
      final response = await dio.post(
        SignInApiConstant.login,
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        return Right(LoginResponseModel.fromJson(response.data));
      } else {
        return Left(ServerFailure(
          message:
              response.data['errors']?.join(", ") ?? "Terjadi kesalahan server",
          statusCode: response.statusCode ?? 500,
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
