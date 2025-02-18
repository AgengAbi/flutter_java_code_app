import 'package:flutter/material.dart';

class TextFormFieldCustoms extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? initialValue;
  final String label;
  final String hint;
  final bool isRequired;
  final String? requiredText;

  const TextFormFieldCustoms({
    super.key,
    this.controller,
    this.keyboardType,
    this.initialValue,
    required this.label,
    required this.hint,
    this.isRequired = false,
    this.requiredText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          initialValue:
              controller == null ? initialValue : null, // Avoid conflict
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
          ),
          validator: (value) {
            if (isRequired && (value == null || value.isEmpty)) {
              return requiredText ?? 'This field is required';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
