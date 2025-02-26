import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/features/evaluation/models/rating.dart';
import 'package:flutter_java_code_app/utils/functions/app_logger.dart';
import 'package:flutter_java_code_app/utils/services/hive_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EvaluationController extends GetxController {
  static EvaluationController get to => Get.find();

  RxInt rating = 0.obs;
  RxList<String> selectedImprovements = <String>[].obs;
  RxString review = ''.obs;
  Rxn<File> selectedImage = Rxn<File>();
  final ImagePicker _picker = ImagePicker();
  final TextEditingController reviewController = TextEditingController();
  RxBool showSubmittedData = false.obs;
  final improvements = <String>[
    'Harga',
    'Rasa',
    'Penyajian makanan',
    'Pelayanan',
    'Fasilitas',
  ];
  RxList<Rating> ratings = <Rating>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    loadRatings();
  }

  void loadRatings() {
    ratings.value = LocalStorageService.ratingBox.values.toList();
  }

  void setRating(int rating) {
    this.rating.value = rating;
  }

  void resetRating() {
    rating.value = 0;
  }

  void setReview(String text) {
    review.value = text;
  }

  void toggleImprovement(String improvement) {
    if (selectedImprovements.contains(improvement)) {
      selectedImprovements.remove(improvement);
    } else {
      selectedImprovements.add(improvement);
    }
  }

  String get ratingLabel {
    switch (rating.value) {
      case 1:
        return 'Buruk';
      case 2:
        return 'Kurang';
      case 3:
        return 'Lumayan';
      case 4:
        return 'Hampir Sempurna';
      case 5:
        return 'Sempurna';
      default:
        return ''; // rating=0 (not rated)
    }
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  void submitRating() {
    final newId = LocalStorageService.ratingBox.values.isEmpty
        ? 1
        : LocalStorageService.ratingBox.values.last.id + 1;

    final newRating = Rating(
      id: newId,
      rating: rating.value,
      improvements: selectedImprovements.toList(),
      review: reviewController.text.trim(),
      imagePath: selectedImage.value?.path,
      createdAt: DateTime.now(),
    );

    LocalStorageService.ratingBox.add(newRating);

    loadRatings();

    showSubmittedData.value = true;

    Get.snackbar('Berhasil', 'Penilaian Anda telah dikirim!');

    rating.value = 0;
    selectedImprovements.clear();
    reviewController.text = '';
    selectedImage.value = null;
    showSubmittedData.value = false;

    tryGoBack();
  }

  void tryGoBack() {
    if (Navigator.canPop(Get.context!)) {
      Navigator.pop(Get.context!);
    } else {
      AppLogger.d('Tidak ada halaman sebelumnya dalam stack');
    }
  }

  @override
  void onClose() {
    reviewController.dispose();
    super.onClose();
  }
}
