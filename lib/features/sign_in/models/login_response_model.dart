import 'package:flutter_java_code_app/features/sign_in/models/user_auth.dart';

class LoginResponseModel {
  final UserAuth? userAuth;
  final String? token;
  final List<String>? errors;

  LoginResponseModel({
    this.userAuth,
    this.token,
    this.errors,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      userAuth: json['data']?['user'] != null
          ? UserAuth.fromJson(json['data']['user'])
          : null,
      token: json['data']?['token'],
      errors: json['errors'] != null ? List<String>.from(json['errors']) : null,
    );
  }
}
