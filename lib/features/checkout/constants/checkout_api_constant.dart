import 'package:flutter_java_code_app/shared/controllers/global_controllers.dart';

class CheckoutApiConstant {
  static String baseUrl = GlobalController.to.baseUrl;
  static String createOrder = '${baseUrl}order/add';
  static String allVoucher = '${baseUrl}voucher/all';
}
