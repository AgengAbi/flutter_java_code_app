import 'package:flutter_java_code_app/shared/controllers/global_controllers.dart';

class SignInApiConstant {
  static String baseUrl = GlobalController.to.baseUrl;
  static String login = '${baseUrl}auth/login';
}
