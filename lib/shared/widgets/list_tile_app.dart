import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/constants/cores/assets/svg_constant.dart';
import 'package:flutter_java_code_app/features/home_page/models/level.dart';
import 'package:flutter_java_code_app/features/home_page/models/menu_ui.dart';
import 'package:flutter_java_code_app/features/home_page/models/topping.dart';
import 'package:flutter_java_code_app/features/home_page/sub_features/menu_details/controllers/home_page_menu_details_controller.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:flutter_java_code_app/shared/widgets/selectable_item.dart';
import 'package:flutter_java_code_app/utils/functions/app_logger.dart';
import 'package:flutter_java_code_app/utils/services/hive_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

enum BottomSheetFormType {
  none,
  textForm,
  radio,
  checkbox,
  datePicker,
  language,
}

enum FieldType { none, name, date, phone, email, pin }

class ListTileApp extends StatelessWidget {
  // Optional menu object for order
  final MenuUI? menu;

  /// The leading widget IconData or String for SvgPicture. Nullable.
  final dynamic leading;

  /// The main title text.
  final Widget title;

  /// The subtitle text.
  final String subtitle;

  /// The main title on BotomSheet text.
  final String? titleBottomSheet;

  /// The type of bottom sheet form to display when the tile is tapped.
  final BottomSheetFormType bottomSheetFormType;

  /// For [BottomSheetFormType.textForm]: the initial text to display.
  final String? textFormArgument;

  /// For [BottomSheetFormType.radio]: a list of [Level] items.
  final List<Level>? radioItems;

  /// For [BottomSheetFormType.checkbox]: a list of [Topping] items.
  final List<Topping>? checkboxItems;

  /// Additional callback for when user submit textForm
  final Function(String)? onSubmitText;

  /// FieldType for validation
  final FieldType fieldType;

  // For Subtitle customization
  final bool subtitleBold; // Bold subtitle
  final Color? subtitleColor; // Color for
  final bool titleBold; // Bold

  // Callback custom for when user update data
  final Function(Level)? onUpdateLevel;
  final Function(List<Topping>)? onUpdateTopping;
  final Function(String)? onUpdateNote;

  // Callback custom for when user click on ListTile
  final VoidCallback? onTapCustom;

  ListTileApp({
    super.key,
    this.menu,
    this.leading,
    required dynamic title,
    required this.subtitle,
    this.titleBottomSheet,
    this.bottomSheetFormType = BottomSheetFormType.none,
    this.textFormArgument,
    this.radioItems,
    this.checkboxItems,
    this.onSubmitText,
    this.fieldType = FieldType.none,
    this.subtitleBold = false,
    this.titleBold = false,
    this.subtitleColor,
    this.onTapCustom,
    this.onUpdateLevel,
    this.onUpdateTopping,
    this.onUpdateNote,
  }) : title = title is String ? Text(title) : title as Widget;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      contentPadding: EdgeInsets.zero,
      leading: _buildLeadingWidget(),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: _buildTitleWidget(context)),
          Container(
            constraints: BoxConstraints(
              maxWidth: 120.w,
            ),
            child: Text(
              subtitle,
              style: TextStyle(
                color: subtitleColor ?? Colors.black,
                fontWeight: subtitleBold ? FontWeight.bold : FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
      // Display trailing icon if bottom sheet form type is not none.
      trailing:
          bottomSheetFormType == BottomSheetFormType.none && onTapCustom == null
              ? null
              : const Icon(Icons.chevron_right),
      onTap: () {
        // if bottom sheet form type is link, call onTapCustom if it's not null,
        // can use to navigate to another page or something
        if (bottomSheetFormType == BottomSheetFormType.none) {
          if (onTapCustom != null) {
            onTapCustom!();
          }
          return;
        }
        switch (bottomSheetFormType) {
          case BottomSheetFormType.none:
            // Do nothing.
            break;
          case BottomSheetFormType.textForm:
            _showTextFormBottomSheet(context);
            break;
          case BottomSheetFormType.radio:
            _showRadioBottomSheet(context);
            break;
          case BottomSheetFormType.checkbox:
            _showCheckboxBottomSheet(context);
            break;
          case BottomSheetFormType.datePicker:
            _showDatePicker(context);
            break;
          case BottomSheetFormType.language:
            _showLanguagePicker(context);
            break;
        }
      },
    );
  }

  // Build title widget
  Widget _buildTitleWidget(BuildContext context) {
    if (title is Text) {
      final Text textWidget = title as Text;
      final TextStyle baseStyle =
          textWidget.style ?? DefaultTextStyle.of(context).style;
      return Text(
        textWidget.data ?? "",
        style: baseStyle.copyWith(
          fontWeight: titleBold ? FontWeight.bold : baseStyle.fontWeight,
        ),
        textAlign: textWidget.textAlign,
        maxLines: textWidget.maxLines,
        overflow: textWidget.overflow,
      );
    }
    return title;
  }

  /// Displays a bottom sheet containing a TextFormField and an IconButton.
  void _showTextFormBottomSheet(BuildContext context) {
    final TextEditingController controller =
        TextEditingController(text: textFormArgument ?? '');
    final formKeyModal = GlobalKey<FormState>();

    showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKeyModal,
              child: Wrap(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      titleBottomSheet ??
                          (title is Text ? (title as Text).data! : ''),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            hintText: 'Masukkan teks'.tr,
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            switch (fieldType) {
                              case FieldType.name:
                                if (value == null || value.trim().isEmpty) {
                                  return 'validation.name_empty'.tr;
                                }
                                break;
                              case FieldType.date:
                                if (value == null || value.trim().isEmpty) {
                                  return 'validation.date_empty'.tr;
                                }
                                break;
                              case FieldType.phone:
                                if (value == null || value.trim().isEmpty) {
                                  return 'validation.phone_empty'.tr;
                                }
                                if (!RegExp(r'^[+\d]+$').hasMatch(value)) {
                                  return 'validation.phone_invalid'.tr;
                                }
                                break;
                              case FieldType.email:
                                if (value == null || value.trim().isEmpty) {
                                  return 'validation.email_empty'.tr;
                                }
                                if (!value.contains('@')) {
                                  return 'validation.email_invalid'.tr;
                                }
                                break;
                              case FieldType.pin:
                                if (value == null || value.trim().isEmpty) {
                                  return 'validation.pin_empty'.tr;
                                }
                                if (value.trim().length < 5) {
                                  return 'validation.pin_too_short'.tr;
                                }
                                break;
                              case FieldType.none:
                              default:
                                break;
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        height: 32.r,
                        width: 32.r,
                        decoration: BoxDecoration(
                            color: ColorStyle.info,
                            borderRadius: BorderRadius.circular(30.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 10,
                                spreadRadius: -1,
                              )
                            ]),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          color: ColorStyle.white,
                          icon: const Icon(Icons.check),
                          onPressed: () {
                            if (formKeyModal.currentState!.validate()) {
                              final newText = controller.text.trim();
                              AppLogger.d('TextForm submitted: $newText');
                              if (onSubmitText != null) {
                                onSubmitText!(newText);
                              } else if (onUpdateNote != null) {
                                onUpdateNote!(newText);
                              } else {
                                // Default behavior jika callback tidak disediakan
                              }
                              Navigator.pop(context);
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget? _buildLeadingWidget() {
    if (leading is IconData) {
      return Icon(leading, size: 28.r, color: ColorStyle.info);
    } else if (leading is String) {
      return SvgPicture.asset(
        leading,
        width: 20.r,
        height: 20.r,
      );
    }
    return null;
  }

  /// Displays a horizontal bottom sheet with a list of choices based on [radioItems].
  void _showRadioBottomSheet(BuildContext context) {
    Level? selectedLevel = menu?.levelSelected;
    showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            width: MediaQuery.of(context).size.width,
            // constraints: const BoxConstraints(minHeight: 200),
            padding: const EdgeInsets.all(16.0),
            child: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titleBottomSheet ??
                          (title is Text ? (title as Text).data! : ''),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: (radioItems == null || radioItems!.isEmpty)
                            ? [
                                Text(
                                  'Level tidak tersedia untuk menu ini'.tr,
                                  style: const TextStyle(fontSize: 16),
                                )
                              ]
                            : radioItems!.map((levelItem) {
                                return SelectableItem(
                                  item: levelItem,
                                  isSelected: levelItem == selectedLevel,
                                  label: levelItem.keterangan,
                                  onTap: (selectedItem) {
                                    setState(() {
                                      selectedLevel = selectedItem;
                                    });

                                    AppLogger.d(
                                        'Choice selected: ${selectedItem.keterangan}');

                                    AppLogger.d(
                                        'Choice selected: ${selectedItem.keterangan}');
                                    if (menu != null) {
                                      // Use callback if provided, otherwise use HomePageMenuDetailsController
                                      if (onUpdateLevel != null) {
                                        onUpdateLevel!(selectedItem);
                                      } else {
                                        HomePageMenuDetailsController.to
                                            .updateMenuLevel(selectedItem);
                                      }
                                    }
                                  },
                                );
                              }).toList(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  /// Displays a horizontal bottom sheet with a list of choices based on [checkboxItems].
  void _showCheckboxBottomSheet(BuildContext context) {
    List<bool> selectedList = List<bool>.generate(
      checkboxItems?.length ?? 0,
      (index) {
        if (menu != null && menu!.toppingSelected != null) {
          return menu!.toppingSelected!
              .any((t) => t.idDetail == checkboxItems![index].idDetail);
        }
        return false;
      },
    );

    showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            width: MediaQuery.of(context).size.width,
            // constraints: const BoxConstraints(minHeight: 200),
            padding: const EdgeInsets.all(16.0),
            child: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titleBottomSheet ??
                          (title is Text ? (title as Text).data! : ''),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: (checkboxItems == null ||
                                checkboxItems!.isEmpty)
                            ? [
                                Text(
                                  'Topping tidak tersedia untuk menu ini'.tr,
                                  style: const TextStyle(fontSize: 16),
                                )
                              ]
                            : checkboxItems!.asMap().entries.map((entry) {
                                int index = entry.key;
                                Topping toppingItem = entry.value;
                                bool isSelected = selectedList[index];

                                return SelectableItem(
                                  item: toppingItem,
                                  isSelected: isSelected,
                                  label: toppingItem.keterangan,
                                  onTap: (selectedItem) {
                                    setState(() {
                                      selectedList[index] =
                                          !selectedList[index];
                                    });

                                    AppLogger.d(
                                        'Choice toggled: ${selectedItem.keterangan} now ${selectedList[index]}');

                                    if (menu != null) {
                                      List<Topping> selectedToppings = [];
                                      for (int i = 0;
                                          i < (checkboxItems?.length ?? 0);
                                          i++) {
                                        if (selectedList[i]) {
                                          selectedToppings
                                              .add(checkboxItems![i]);
                                        }
                                      }
                                      if (onUpdateTopping != null) {
                                        onUpdateTopping!(selectedToppings);
                                      } else {
                                        HomePageMenuDetailsController.to
                                            .updateMenuTopping(
                                                selectedToppings);
                                      }
                                    }
                                  },
                                );
                              }).toList(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showDatePicker(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      final formattedDate = "${selectedDate.day.toString().padLeft(2, '0')}-"
          "${selectedDate.month.toString().padLeft(2, '0')}-"
          "${selectedDate.year}";
      AppLogger.d('Date selected: $formattedDate');
      if (onSubmitText != null) onSubmitText!(formattedDate);
    }
  }

  void _showLanguagePicker(BuildContext context) {
    String getLanguageFromLocale(Locale locale) {
      switch (locale.languageCode) {
        case 'en':
          return "English";
        case 'id':
        default:
          return "Indonesia";
      }
    }

    String selectedLanguage =
        Get.locale != null ? getLanguageFromLocale(Get.locale!) : "Indonesia";

    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Ganti Bahasa',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() => selectedLanguage = "Indonesia");
                            Get.updateLocale(const Locale('id', 'ID'));
                            LocalStorageService.setLanguage("Indonesia");
                            // Misalnya, panggil callback jika diperlukan
                            // if (onSubmitText != null) onSubmitText!("Indonesia");
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: selectedLanguage == "Indonesia"
                                    ? ColorStyle.info
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(8)),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 8.r),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(SvgConstant.icIndonesiaFlag),
                                8.horizontalSpace,
                                Text("Indonesia",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: selectedLanguage == "Indonesia"
                                            ? Colors.white
                                            : Colors.black)),
                                if (selectedLanguage == "Indonesia") ...[
                                  const SizedBox(width: 8),
                                  const Icon(Icons.check,
                                      size: 16, color: Colors.white),
                                ] else ...[
                                  const SizedBox(width: 8),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() => selectedLanguage = "English");
                            Get.updateLocale(const Locale('en', 'US'));
                            LocalStorageService.setLanguage("English");
                            // if (onSubmitText != null) onSubmitText!("English");
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: selectedLanguage == "English"
                                    ? ColorStyle.info
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(8)),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 8.r),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(SvgConstant.icEnglishFlag),
                                8.horizontalSpace,
                                Text("Inggris",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: selectedLanguage == "English"
                                            ? Colors.white
                                            : Colors.black)),
                                if (selectedLanguage == "English") ...[
                                  const SizedBox(width: 8),
                                  const Icon(Icons.check,
                                      size: 16, color: Colors.white),
                                ] else ...[
                                  const SizedBox(width: 8),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
