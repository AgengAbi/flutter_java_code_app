import 'package:flutter/material.dart';
import 'package:flutter_java_code_app/shared/styles/color_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final void Function(DateTimeRange) onChanged;
  final DateTimeRange selectedDate;

  const DatePicker({
    super.key,
    required this.onChanged,
    required this.selectedDate,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late DateTimeRange _currentDateRange;

  @override
  void initState() {
    super.initState();
    _currentDateRange = widget.selectedDate;
  }

  Future<void> _pickDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: _currentDateRange,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            colorScheme: const ColorScheme.light(primary: Colors.blue),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child ?? Container(),
        );
      },
    );

    if (picked != null && picked != _currentDateRange) {
      setState(() {
        _currentDateRange = picked;
      });
      widget.onChanged(_currentDateRange);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Format tanggal menjadi hari/bulan/tahun (dd/MM/yy)
    String formattedStartDate =
        DateFormat('dd/MM/yy').format(_currentDateRange.start);
    String formattedEndDate =
        DateFormat('dd/MM/yy').format(_currentDateRange.end);

    return InkWell(
      onTap: _pickDateRange,
      borderRadius: BorderRadius.circular(30.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: ColorStyle.primary, width: 1.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$formattedStartDate - $formattedEndDate',
              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
            ),
            6.horizontalSpace,
            Icon(
              Icons.calendar_month_outlined,
              size: 20.sp,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
