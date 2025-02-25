import 'package:flutter_java_code_app/features/evaluation/controllers/evaluation_controller.dart';
import 'package:flutter_java_code_app/features/evaluation/sub_features/chat_rating/controllers/evaluation_chat_rating_controller.dart';
import 'package:get/get.dart';

class EvaluationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EvaluationController());
  }
}

class EvaluationChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EvaluationChatRatingController());
  }
}
