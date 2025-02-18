import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

/// * UniversalAppBar is a flexible app bar that adapts to different use cases. 🚀
/// It can act as a:
/// 1️⃣ **Standard AppBar** with a title, optional icon, and actions.
/// 2️⃣ **Search AppBar** when `showSearch` is true.
/// 3️⃣ **Tab Bar** when `showTabs` is true and `tabs` are provided.
///
/// ---
///
/// ## Usage Examples:
///
/// ### 1️⃣ Standard AppBar (RoundedAppBar)
/// ```dart
/// UniversalAppBar(
///   title: "Home",
///   icon: Icons.home,
///   actions: [
///     IconButton(
///       icon: Icon(Icons.settings),
///       onPressed: () {},
///     ),
///   ],
/// )
/// ```
///
/// ### 2️⃣ Search AppBar (Search Mode)
/// ```dart
/// UniversalAppBar(
///   showSearch: true,
///   searchController: TextEditingController(),
///   onSearchChanged: (value) {
///     print("Searching: \$value");
///   },
/// )
/// ```
///
/// ### 3️⃣ Tab Bar (OrderTopBar Mode)
/// ```dart
/// UniversalAppBar(
///   showTabs: true,
///   tabs: [
///     Tab(text: 'On going'),
///     Tab(text: 'History'),
///   ],
/// )
/// ```

class UniversalAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UniversalAppBar({
    super.key,
    this.title,
    this.icon,
    this.onBackButtonPressed,
    this.actions,
    this.enableBackButton = true,
    this.titleStyle,
    this.showSearch = false,
    this.searchController,
    this.onSearchChanged,
    this.showTabs = false,
    this.tabs,
  });

  final String? title;
  final dynamic icon;
  final VoidCallback? onBackButtonPressed;
  final List<Widget>? actions;
  final bool enableBackButton;
  final TextStyle? titleStyle;
  final bool showSearch;
  final TextEditingController? searchController;
  final ValueChanged<String>? onSearchChanged;
  final bool showTabs;
  final List<Tab>? tabs;

  @override
  Widget build(BuildContext context) {
    if (showSearch) {
      // 🔹 MODE SEARCH BAR
      return Container(
        width: double.infinity,
        height: 68.h,
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.r)),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(111, 24, 24, 24),
              blurRadius: 15,
              spreadRadius: -1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: TextField(
          controller: searchController,
          style: Get.textTheme.labelSmall?.copyWith(fontSize: 18.sp),
          maxLines: 1,
          onChanged: onSearchChanged,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30.r)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            isDense: true,
            prefixIcon: Icon(Icons.search, size: 26.h),
            prefixIconColor: Theme.of(context).primaryColor,
            hintText: 'Search'.tr,
            hintStyle: Get.textTheme.labelSmall?.copyWith(fontSize: 14.sp),
          ),
        ),
      );
    } else if (showTabs && tabs != null) {
      // 🔹 MODE TAB BAR
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.r)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 10,
              spreadRadius: -1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: TabBar(
          tabs: tabs!,
          indicatorColor: Theme.of(context).primaryColor,
          indicatorWeight: 3.h,
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Colors.grey[400],
          labelStyle: TextStyle(color: Colors.black87, fontSize: 14.sp),
        ),
      );
    } else {
      // 🔹 MODE APP BAR STANDARD
      return AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) _buildIcon(context),
            if (icon != null && title != null) SizedBox(width: 10.w),
            if (title != null)
              Text(title!,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600)),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        leading: enableBackButton
            ? IconButton(
                splashRadius: 30.r,
                icon: Icon(Icons.chevron_left, color: Colors.black, size: 36.r),
                onPressed:
                    onBackButtonPressed ?? () => Get.back(closeOverlays: true),
              )
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.r)),
        ),
        actions: actions,
      );
    }
  }

  // Function to dynamically build the icon
  Widget _buildIcon(BuildContext context) {
    if (icon is IconData) {
      // If the icon is of type IconData
      return Icon(icon, size: 28.r, color: Theme.of(context).primaryColor);
    } else if (icon is String) {
      // If the icon is of type String (for SVG)
      return SvgPicture.asset(
        icon,
        width: 16.r,
        height: 16.r,
        // color: Theme.of(context).primaryColor,
      );
    }
    return const SizedBox.shrink(); // Return empty widget if icon is null
  }

  @override
  Size get preferredSize {
    if (showSearch) {
      return Size.fromHeight(68.h); // Height search bar
    } else if (showTabs) {
      return const Size.fromHeight(kToolbarHeight); // Height tab bar
    }
    return const Size.fromHeight(kToolbarHeight); // Height default app bar
  }
}
