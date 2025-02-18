import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/constants/cores/assets/image_constant.dart';
import 'package:flutter_java_code_app/features/sign_in/controllers/sign_in_controller.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:flutter_java_code_app/shared/styles/elevated_button_style.dart';
import 'package:flutter_java_code_app/shared/styles/google_text_style.dart';
import 'package:flutter_java_code_app/utils/services/analytics_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AnalyticsService.logScreen('Sign In Screen');

    return Scaffold(
      appBar: null,
      extendBody: false,
      backgroundColor: ColorStyle.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(45),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 121.h),
              GestureDetector(
                onDoubleTap: () => SignInController.to.flavorSeting(),
                child: Image.asset(
                  ImageConstant.logo,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 121.h),
              Text(
                'Masuk untuk melanjutkan!',
                style: GoogleTextStyle.fw600.copyWith(
                  fontSize: 22.sp,
                  color: ColorStyle.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.h),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: SignInController.to.emailCtrl
                        ..text = 'admin@gmail.com',
                      decoration: const InputDecoration(
                        labelText: "Alamat Email",
                        hintText: "Masukkan email Anda",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorStyle.primary,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorStyle.primary,
                            width: 2.0, // Bolder when focused
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email tidak boleh kosong";
                        }
                        if (!GetUtils.isEmail(value)) {
                          return "Format email tidak valid";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        SignInController.to.emailValue.value = value ?? "";
                      },
                    ),
                    SizedBox(height: 20.h),

                    /// TextField For Password
                    Obx(
                      () => TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: SignInController.to.passwordCtrl
                          ..text = 'admin',
                        obscureText: SignInController.to.isPassword.value,
                        decoration: InputDecoration(
                          labelText: "Kata Sandi",
                          hintText: "Masukkan password Anda",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorStyle.primary,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorStyle.primary,
                              width: 2.0,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              SignInController.to.isPassword.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: SignInController.to.showPassword,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password tidak boleh kosong";
                          }
                          if (value.length < 3) {
                            return "Password minimal 3 karakter";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          SignInController.to.passwordValue.value = value ?? "";
                        },
                      ),
                    ),

                    SizedBox(height: 40.h),
                    ElevatedButton(
                      style: ElevatedButtonStyle.mainRounded,
                      onPressed: () =>
                          SignInController.to.validateForm(_formKey, context),
                      child: Text(
                        "Masuk",
                        style: GoogleTextStyle.fw800.copyWith(
                          fontSize: 14.sp,
                          color: ColorStyle.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
