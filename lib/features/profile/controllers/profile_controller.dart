import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/features/profile/models/user.dart';
import 'package:flutter_java_code_app/features/profile/repositories/profile_repository.dart';
import 'package:flutter_java_code_app/shared/models/failure.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:flutter_java_code_app/shared/widgets/image_picker_dialog.dart';
import 'package:flutter_java_code_app/utils/functions/app_logger.dart';
import 'package:flutter_java_code_app/utils/services/hive_service.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  RxBool isLoading = false.obs;
  Rx<User?> user = Rx<User?>(null);
  Rx<Failure?> failure = Rx<Failure?>(null);

  // * ImagePicker
  final Rx<File?> _imageFile = Rx<File?>(null);

  // * Device Info
  RxString deviceModel = ''.obs;
  RxString deviceVersion = ''.obs;

  File? get imageFile => _imageFile.value;

  @override
  void onInit() {
    super.onInit();

    getUserDetails();
    getDeviceInformation();
  }

  /// Method to pick an image and update the profile photo
  Future<void> pickImage() async {
    // Show dialog to select the image source
    ImageSource? imageSource = await _showImagePickerDialog();

    // If no source is selected, return
    if (imageSource == null) return;

    // Select the image from the chosen source
    final pickedFile = await ImagePicker().pickImage(
      source: imageSource,
      maxWidth: 300,
      maxHeight: 300,
      imageQuality: 75,
    );

    // Open the cropper if an image is selected
    if (pickedFile != null) {
      _imageFile.value = File(pickedFile.path);

      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _imageFile.value!.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper'.tr,
            toolbarColor: ColorStyle.primary,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'Cropper'.tr,
          ),
        ],
      );

      // Update the selected image if cropping is successful
      if (croppedFile != null) {
        _imageFile.value = File(croppedFile.path);
      }
    }
  }

  /// Dialog to choose the image source (camera or gallery)
  Future<ImageSource?> _showImagePickerDialog() async {
    return await showDialog<ImageSource>(
      context: Get.context!,
      builder: (context) => const ImagePickerDialog(),
    );
  }

  Future getDeviceInformation() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceModel.value = androidInfo.model;
    deviceVersion.value = androidInfo.version.release;
  }

  // * User info
  Future<void> getUserDetails() async {
    isLoading.value = true;

    // Check if there is already user data stored locally
    final storedUser = LocalStorageService.getUser();

    if (storedUser != null) {
      // If there is, use the stored data locally
      user.value = storedUser;
      isLoading.value = false;
    } else {
      // If there is no data, fetch it from the server
      final result = await ProfileRepository.fetchUserDetails();
      result.fold(
        (failure) {
          this.failure.value = failure;
          isLoading.value = false;
        },
        (userData) async {
          await LocalStorageService.setUser(userData);
          user.value = userData;
          isLoading.value = false;
        },
      );
    }
  }

  // * Change user info
  Future<void> updateUserName(String newName) async {
    if (user.value != null) {
      final updatedUser = user.value!.copyWith(nama: newName);
      user.value = updatedUser;
      await LocalStorageService.setUser(updatedUser);
      AppLogger.d("User name updated to $newName");
      user.refresh();
    }
  }

  Future<void> updateBirthDate(String newBirthDate) async {
    if (user.value != null) {
      final updatedUser = user.value!.copyWith(tglLahir: newBirthDate);
      user.value = updatedUser;
      await LocalStorageService.setUser(updatedUser);
      AppLogger.d("User birth date updated to $newBirthDate");
      user.refresh();
    }
  }

  Future<void> updatePhoneNumber(String newPhoneNumber) async {
    if (user.value != null) {
      final updatedUser = user.value!.copyWith(telepon: newPhoneNumber);
      user.value = updatedUser;
      await LocalStorageService.setUser(updatedUser);
      AppLogger.d("User phone number updated to $newPhoneNumber");
      user.refresh();
    }
  }

  Future<void> updateEmail(String newEmail) async {
    if (user.value != null) {
      final updatedUser = user.value!.copyWith(email: newEmail);
      user.value = updatedUser;
      await LocalStorageService.setUser(updatedUser);
      AppLogger.d("User email updated to $newEmail");
      user.refresh();
    }
  }

  Future<void> updatePIN(String newPIN) async {
    if (user.value != null) {
      final updatedUser = user.value!.copyWith(pin: newPIN);
      user.value = updatedUser;
      await LocalStorageService.setUser(updatedUser);
      AppLogger.d("User PIN updated to $newPIN");
      user.refresh();
    }
  }

  Future<void> updateLanguage(String newLanguage) async {
    AppLogger.d("Language updated to $newLanguage");
    if (newLanguage == 'Indonesia') {
      Get.updateLocale(const Locale('id', 'ID'));
    } else if (newLanguage == 'English') {
      Get.updateLocale(const Locale('en', 'US'));
    }
  }
}
