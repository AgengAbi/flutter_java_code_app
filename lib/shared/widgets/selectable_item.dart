import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';

class SelectableItem<T> extends StatelessWidget {
  final T item;
  final bool isSelected;
  final ValueChanged<T> onTap;
  final String label;

  const SelectableItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(item),
      child: Container(
        margin: const EdgeInsets.only(right: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          border:
              Border.all(color: isSelected ? ColorStyle.info : ColorStyle.info),
          borderRadius: BorderRadius.circular(16),
          color: isSelected ? ColorStyle.info : Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            if (isSelected)
              const Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Icon(Icons.check, size: 16, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}
