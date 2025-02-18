import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailStackSheet extends StatelessWidget {
  final double containerHeightPercentage; // Misal: 0.3 berarti 30% dari layar
  final Widget containerContent;
  final Widget draggableContent;

  const DetailStackSheet({
    super.key,
    required this.containerHeightPercentage,
    required this.containerContent,
    required this.draggableContent,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = 1.sh; // Menggunakan flutter_screenutil
    double containerHeight = containerHeightPercentage * screenHeight;
    double draggableHeightPercentage = 1 - containerHeightPercentage;

    return Stack(
      children: [
        Container(
          height: containerHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xffF0F0F0),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20.r),
            ),
          ),
          child: containerContent,
        ),
        DraggableScrollableSheet(
          initialChildSize: draggableHeightPercentage,
          minChildSize: draggableHeightPercentage,
          maxChildSize: 1.0,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.r),
                ),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 32.h),
                  child: draggableContent,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
