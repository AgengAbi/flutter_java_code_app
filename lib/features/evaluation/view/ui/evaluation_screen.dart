import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/configs/routes/route.dart';
import 'package:flutter_java_code_app/features/evaluation/constants/evaluation_assets_constant.dart';
import 'package:flutter_java_code_app/features/evaluation/controllers/evaluation_controller.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:flutter_java_code_app/shared/widgets/universal_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EvaluationScreen extends StatelessWidget {
  EvaluationScreen({super.key});

  final assetsConstant = EvaluationAssetsConstant();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UniversalAppBar(
        title: 'Daftar Penilaian',
      ),
      body: Obx(() {
        final items = EvaluationController.to.ratings;
        if (items.isEmpty) {
          return const Center(child: Text("Belum ada penilaian"));
        }
        return SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(left: 25.w, top: 16.h, right: 25.w, bottom: 0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final ratingItem = items[index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.evaluationChatRatingRoute,
                        arguments: ratingItem);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8.h),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xffF0F0F0),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 4),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.date_range,
                                size: 16, color: ColorStyle.primary),
                            const SizedBox(width: 4),
                            Text(
                              ratingItem.improvements.isNotEmpty
                                  ? ratingItem.improvements.first
                                  : "Penilaian",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                  color: ColorStyle.primary),
                            ),
                            16.horizontalSpace,
                            Row(
                              children: List.generate(
                                ratingItem.rating,
                                (i) => const Icon(Icons.star,
                                    color: Colors.orange, size: 16),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ratingItem.review,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Tambah Penilaian',
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () => {
          Get.toNamed(Routes.createEvaluationRoute),
        },
        backgroundColor: ColorStyle.info,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
