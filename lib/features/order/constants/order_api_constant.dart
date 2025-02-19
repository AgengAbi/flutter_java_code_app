import 'package:flutter_java_code_app/shared/controllers/global_controllers.dart';

class OrderApiConstant {
  static String baseUrl = GlobalController.to.baseUrl;
  static String getOrders = '${baseUrl}order/user';
  static String getOrderDetails = '${baseUrl}order/detail';
}
