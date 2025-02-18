import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetApp extends StatelessWidget {
  final String title;
  final String message;
  final Widget? customContent;

  const BottomSheetApp({
    super.key,
    required this.title,
    required this.message,
    required this.customContent,
  });

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      isScrollControlled: true, // Bottomsheet adjust size to keyboard
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.r,
            right: 16.r,
            top: 16.r,
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom, // Adjust bottomsheet height to keyboard
          ),
          child: SingleChildScrollView(
            // For bottomsheet not hidden by keyboard
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 10.r),
                TextFormField(
                  initialValue: message,
                  decoration: const InputDecoration(
                    hintText: 'Enter your message',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.r),
                // Custom content
                customContent!,
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _showBottomSheet(context),
      child: const Text("Open BottomSheet"),
    );
  }
}
