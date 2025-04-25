import 'package:flutter/material.dart';

class ChoiceChipApp extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final Widget? leadingIcon;

  const ChoiceChipApp({
    super.key,
    required this.label,
    required this.selected,
    this.onTap,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: selected ? Colors.blue : Colors.grey),
          borderRadius: BorderRadius.circular(8),
          color: selected
              ? Colors.blue.withValues(alpha: 0.2)
              : Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leadingIcon != null) ...[
              leadingIcon!,
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: TextStyle(color: selected ? Colors.blue : Colors.black),
            ),
            if (selected) ...[
              const SizedBox(width: 4),
              const Icon(Icons.check, size: 16, color: Colors.blue),
            ],
          ],
        ),
      ),
    );
  }
}
