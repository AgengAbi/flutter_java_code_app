import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropdownStatus extends StatelessWidget {
  final Map<String, String> items;
  final String selectedItem;
  final void Function(String?)? onChanged;

  const DropdownStatus({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: ColorStyle.primary),
        ),
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
              value: selectedItem,
              isDense: true,
              icon: const Icon(Icons.arrow_drop_down, size: 18),
              elevation: 8,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
              alignment: Alignment.center,
              onChanged: onChanged,
              items: items.entries
                  .map((entry) => DropdownMenuItem<String>(
                        value: entry.key,
                        child: Text(entry.value),
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
