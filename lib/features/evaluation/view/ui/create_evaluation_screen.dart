import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/features/evaluation/controllers/evaluation_controller.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:flutter_java_code_app/shared/widgets/universal_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateEvaluationScreen extends StatelessWidget {
  const CreateEvaluationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UniversalAppBar(
        title: 'Penilaian',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 16.h),
          child: Column(children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xffF0F0F0),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Berikan Penilaianmu!',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  8.verticalSpace,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(() => Row(
                            children: List.generate(5, (index) {
                              final starIndex = index + 1;
                              return GestureDetector(
                                onTap: () => EvaluationController.to
                                    .setRating(starIndex),
                                child: Padding(
                                  // Bisa atur spacing horizontal di sini, misal 4.0, 2.0, atau 0.0
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  child: Icon(
                                    Icons.star,
                                    size: 24, // Atur ukuran bintang
                                    color:
                                        EvaluationController.to.rating.value >=
                                                starIndex
                                            ? Colors.orange
                                            : Colors.grey,
                                  ),
                                ),
                              );
                            }),
                          )),
                      // 8.horizontalSpace,
                      const Spacer(),
                      Obx(
                        () => Text(
                          EvaluationController.to.ratingLabel,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // const Spacer(),
                      // GestureDetector(
                      //   onTap: () => EvaluationController.to.resetRating(),
                      //   child: Text(
                      //     'Hapus semua',
                      //     style: TextStyle(
                      //       color: Colors.grey,
                      //       fontSize: 12.sp,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            16.verticalSpace,
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xffF0F0F0),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Apa yang bisa ditingkatkan?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // 🔸 Checklist items
                  Obx(
                    () => Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children:
                          EvaluationController.to.improvements.map((item) {
                        final isSelected = EvaluationController
                            .to.selectedImprovements
                            .contains(item);
                        return GestureDetector(
                          onTap: () =>
                              EvaluationController.to.toggleImprovement(item),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: isSelected
                                    ? ColorStyle.primary
                                    : Colors.grey,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  item,
                                  style: TextStyle(
                                    color: isSelected
                                        ? ColorStyle.primary
                                        : Colors.black,
                                  ),
                                ),
                                if (isSelected) ...[
                                  const SizedBox(width: 4),
                                  const Icon(Icons.check_circle,
                                      size: 12, color: ColorStyle.primary),
                                ]
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  8.verticalSpace,
                  const Divider(),
                  8.verticalSpace,

                  const Text(
                    'Tulis Review',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  8.verticalSpace,
                  TextField(
                    controller: EvaluationController.to.reviewController,
                    maxLines: 3,
                    onChanged: (val) => EvaluationController.to.setReview(val),
                    decoration: const InputDecoration(
                      hintText:
                          'Mohon Menjaga kebersihan, kemarin meja masih kotor',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),

                  16.verticalSpace,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () =>
                              EvaluationController.to.submitRating(),
                          label: const Text('Kirim Penilaian',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorStyle.info,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                              side: const BorderSide(
                                  color: ColorStyle.primary, width: 1),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => EvaluationController.to.pickImage(),
                        icon: const Icon(Icons.photo_library_rounded),
                        style: IconButton.styleFrom(
                          foregroundColor: ColorStyle.info,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            side: const BorderSide(
                                color: ColorStyle.primary, width: 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            16.verticalSpace,
            Obx(
              () => EvaluationController.to.showSubmittedData.value
                  ? Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Rating: ${EvaluationController.to.rating.value}',
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 4),
                          Text(
                              'Yang bisa ditingkatkan: ${EvaluationController.to.selectedImprovements.join(", ")}',
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 4),
                          Text(
                              'Review: ${EvaluationController.to.reviewController.text}',
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                          Obx(
                            () => EvaluationController.to.selectedImage.value !=
                                    null
                                ? Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Image.file(
                                      EvaluationController
                                          .to.selectedImage.value!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ]),
        ),
      ),
    );
  }
}
