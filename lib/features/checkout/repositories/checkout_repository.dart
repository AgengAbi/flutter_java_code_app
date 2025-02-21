import 'package:flutter_java_code_app/features/checkout/constants/checkout_api_constant.dart';
import 'package:flutter_java_code_app/utils/functions/app_logger.dart';
import 'package:flutter_java_code_app/utils/services/dio_service.dart';
import 'package:flutter_java_code_app/utils/services/hive_service.dart';

class CheckoutRepository {
  CheckoutRepository._();

  static Future<String> createOrder(Map<String, dynamic> orderData) async {
    try {
      final dio = DioService.dioCall(
        token: LocalStorageService.getAuthToken(),
      );
      final response = await dio.post(
        CheckoutApiConstant.createOrder,
        data: orderData,
      );

      // Jika response status code 200, ambil pesan sukses dari API
      if (response.statusCode == 200) {
        final responseData = response.data;
        final String message =
            responseData['data']?['message'] ?? 'Order berhasil diproses';
        return message;
      } else {
        // Jika status code bukan 200, kembalikan pesan error
        return 'Order gagal dengan status code: ${response.statusCode}';
      }
    } catch (e) {
      AppLogger.e('Error creating order: $e');
      return 'Terjadi kesalahan saat memproses order: $e';
    }
  }
}
