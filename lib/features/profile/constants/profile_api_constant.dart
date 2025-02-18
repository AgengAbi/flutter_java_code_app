import 'package:flutter_java_code_app/shared/controllers/global_controllers.dart';

class ProfileApiConstant {
  static String baseUrl = GlobalController.to.baseUrl;
  static String detailUser = '${baseUrl}user/detail';
}
