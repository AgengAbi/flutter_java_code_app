import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class PinDialog extends StatefulWidget {
  final String pin;

  const PinDialog({
    super.key,
    required this.pin,
  });

  @override
  State<PinDialog> createState() => _PinDialogState();
}

class _PinDialogState extends State<PinDialog> {
  final RxBool obscure = RxBool(true);
  final RxnString errorText = RxnString();
  final TextEditingController controller = TextEditingController();

  int tries = 0;

  Future<void> processPin(String? pin) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (pin == widget.pin) {
      // if pin is correct close the dialog
      Get.back<bool>(result: true);
    } else {
      // if pin incorrect, type again
      tries++;

      if (tries >= 3) {
        // if tries more than 3, close the dialog
        Get.back<bool>(result: false);
      } else {
        // show how many tries user have left
        controller.clear();

        errorText.value = 'PIN wrong! n chances left.'.trParams({
          'n': (3 - tries).toString(),
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 34.w,
      height: 50.h,
      textStyle: Get.textTheme.titleLarge,
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(10.r),
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 6.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // title
          Text(
            'Verify order',
            style: Get.textTheme.labelLarge,
          ),

          // subtitle
          Text(
            'Enter PIN code',
            style: Get.textTheme.bodySmall!.copyWith(color: Colors.black),
          ),

          24.verticalSpacingRadius,

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => Expanded(
                  // pin input
                  child: Pinput(
                    controller: controller,
                    showCursor: false,
                    length: 6,
                    autofocus: true,
                    // separator: Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 3.w),
                    //   child: ColoredBox(
                    //     color: Colors.black,
                    //     child: SizedBox(width: 9.w, height: 2.h),
                    //   ),
                    // ),
                    // separatorPositions: const [2, 4],
                    closeKeyboardWhenCompleted: false,
                    defaultPinTheme: defaultPinTheme,
                    obscureText: obscure.value,
                    onSubmitted: processPin,
                    onCompleted: processPin,
                  ),
                ),
              ),

              10.horizontalSpace,

              // show pin button
              Obx(
                () => InkWell(
                  radius: 24.r,
                  child: Icon(
                    obscure.value ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).primaryColor,
                    size: 20.r,
                  ),
                  onTap: () {
                    obscure.value = !obscure.value;
                  },
                ),
              ),
            ],
          ),

          /// Pesan error
          Obx(
            () => errorText.value != null
                ? Padding(
                    padding:
                        EdgeInsets.only(left: 15.r, right: 15.r, top: 10.r),
                    child: Text(
                      errorText.value!,
                      style: Get.textTheme.bodySmall!
                          .copyWith(color: Theme.of(context).colorScheme.error),
                      textAlign: TextAlign.center,
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
