import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/features/evaluation/models/rating.dart';
import 'package:flutter_java_code_app/features/evaluation/sub_features/chat_rating/models/ChatMessage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EvaluationChatRatingController extends GetxController {
  static EvaluationChatRatingController get to => Get.find();

  RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final TextEditingController chatTextController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  late Rating ratingItem;

  @override
  void onInit() {
    super.onInit();
    ratingItem = Get.arguments ?? 0;
    if (messages.isEmpty) {
      messages.add(ChatMessage(
        sender: 'admin',
        text: 'Review sebelumnya: Penilaian Anda telah diterima. Terima kasih!',
        imagePath: null,
        timestamp: DateTime.now(),
      ));
      messages.add(ChatMessage(
        sender: 'user',
        text: ratingItem.review,
        imagePath: null,
        timestamp: DateTime.now(),
      ));
      Future.delayed(const Duration(seconds: 2), () {
        messages.add(ChatMessage(
          sender: 'admin',
          text: 'Terima kasih atas feedback Anda!',
          imagePath: null,
          timestamp: DateTime.now(),
        ));
      });
    }
  }

  void sendTextMessage() {
    final text = chatTextController.text.trim();
    if (text.isNotEmpty) {
      messages.add(ChatMessage(
        sender: 'user',
        text: text,
        imagePath: null,
        timestamp: DateTime.now(),
      ));
      chatTextController.clear();

      Future.delayed(const Duration(seconds: 2), () {
        messages.add(ChatMessage(
          sender: 'admin',
          text: 'Terima kasih atas feedback Anda!',
          imagePath: null,
          timestamp: DateTime.now(),
        ));
      });
    }
  }

  Future<void> sendImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      messages.add(ChatMessage(
        sender: 'user',
        text: null,
        imagePath: image.path,
        timestamp: DateTime.now(),
      ));

      // Simulasi balasan admin
      Future.delayed(const Duration(seconds: 2), () {
        messages.add(ChatMessage(
          sender: 'admin',
          text: 'Foto sudah diterima!',
          imagePath: null,
          timestamp: DateTime.now(),
        ));
      });
    }
  }

  @override
  void onClose() {
    chatTextController.dispose();
    super.onClose();
  }
}
