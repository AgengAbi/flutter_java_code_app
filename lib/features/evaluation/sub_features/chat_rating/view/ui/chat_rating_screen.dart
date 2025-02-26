import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/constants/cores/assets/image_constant.dart';
import 'package:flutter_java_code_app/features/evaluation/sub_features/chat_rating/controllers/evaluation_chat_rating_controller.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:flutter_java_code_app/shared/widgets/universal_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatRatingScreen extends StatelessWidget {
  const ChatRatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = EvaluationChatRatingController.to;

    return Scaffold(
      appBar: const UniversalAppBar(
        title: 'Balasan Review',
      ),
      backgroundColor: const Color(0xffF0F0F0),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.r),
                image: const DecorationImage(
                  image: AssetImage(ImageConstant.bgPattern),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  // Bubble Tanggal (hard-coded)
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: ColorStyle.info,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      EvaluationChatRatingController.formattedDate,
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                  // Daftar pesan
                  Expanded(
                    child: Obx(() {
                      final msgs = controller.messages;
                      return ListView.builder(
                        itemCount: msgs.length,
                        itemBuilder: (context, index) {
                          final msg = msgs[index];
                          final isUser = (msg.sender == 'user');
                          return Align(
                            alignment: isUser
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: isUser
                                    ? Colors.blue[100]
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              // If imagePath is not null, display image
                              // If imagePath is null, display bubble
                              child: msg.imagePath != null
                                  ? _buildImageBubble(
                                      msg.imagePath!, msg.timestamp, isUser)
                                  : _buildTextBubble(
                                      msg.text ?? '',
                                      msg.timestamp,
                                      isUser,
                                    ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          // Input Section (textfield + buttons)
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.chatTextController,
                    decoration: InputDecoration(
                      hintText: 'Tulis Pesan...',
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.photo_library),
                  onPressed: () => controller.sendImage(),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => controller.sendTextMessage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextBubble(String text, DateTime timestamp, bool isUser) {
    final timeString = _formatTime(timestamp);
    return Column(
      crossAxisAlignment:
          isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: isUser
              ? [
                  Text(
                    timeString,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  4.horizontalSpace,
                  const Icon(Icons.account_circle_rounded,
                      size: 14, color: ColorStyle.primary),
                ]
              : [
                  const Icon(Icons.account_circle_rounded,
                      size: 14, color: ColorStyle.primary),
                  4.horizontalSpace,
                  Text(
                    timeString,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
        ),
        4.verticalSpace,
        Text(text),
      ],
    );
  }

  Widget _buildImageBubble(String imagePath, DateTime timestamp, bool isUser) {
    final timeString = _formatTime(timestamp);
    return Column(
      crossAxisAlignment:
          isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: isUser
              ? [
                  Text(
                    timeString,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  4.horizontalSpace,
                  const Icon(Icons.account_circle_rounded,
                      size: 14, color: ColorStyle.primary),
                ]
              : [
                  const Icon(Icons.account_circle_rounded,
                      size: 14, color: ColorStyle.primary),
                  4.horizontalSpace,
                  Text(
                    timeString,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
        ),
        4.verticalSpace,
        Image.file(File(imagePath)),
      ],
    );
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour.$minute';
  }
}
