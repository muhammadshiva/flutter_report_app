import 'package:bas_app/shared/styles/color_style.dart';
import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatefulWidget {
  const DateWidget({
    super.key,
    this.margin,
    required this.onChanged,
    required this.errorText,
    required this.initialValue,
  });

  final EdgeInsetsGeometry? margin;
  final Function(String?) onChanged;
  final RxString errorText;
  final String? initialValue;

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    if (widget.initialValue!.isNotEmpty) {
      dateController.text = widget.initialValue ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: dateController,
          style: GoogleFonts.poppins().copyWith(
            color: ColorStyle.black2,
            fontSize: 14.sp,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: const BorderSide(
                color: Color(0xffC5C6CC),
              ),
            ),
            hintText: 'Pilih Tanggal',
            hintStyle: GoogleFonts.poppins().copyWith(
              color: ColorStyle.black2,
              fontSize: 14.sp,
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: const Icon(
                Icons.calendar_month_outlined,
                color: Color(0xffBBBDC7),
              ),
            ),
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: const Icon(
                Icons.arrow_drop_down_outlined,
                color: Color(0xffBBBDC7),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorStyle.primary, width: 1.0),
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
          readOnly: true,
          keyboardType: TextInputType.datetime,
          onTap: () {
            selectDate(context, dateController);
            if (dateController.text.isNotEmpty) {
              widget.errorText.value = '';
            }
          },
        ),
        5.verticalSpace,
        Obx(
          () => Visibility(
            visible: widget.errorText.isNotEmpty,
            child: Text(
              widget.errorText.value,
              style: redTextStyle.copyWith(
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> selectDate(BuildContext context, TextEditingController dateController) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('id', 'ID'),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          datePickerTheme: const DatePickerThemeData(
            surfaceTintColor: Colors.white,
          ),
          colorScheme: const ColorScheme.light(
            primary: ColorStyle.primary,
            onPrimary: Colors.white,
            onSurface: Colors.black,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              backgroundColor: ColorStyle.primary,
              foregroundColor: Colors.white,
            ),
          ),
        ),
        child: child!,
      ),
    );

    if (pickedDate != null) {
      dateController.text = DateFormat('dd MMMM yyyy', 'id_ID').format(pickedDate);
      widget.onChanged(DateFormat('yyyy-MM-dd').format(pickedDate));
      if (dateController.text.isNotEmpty) {
        widget.errorText.value = '';
      }
    }
  }
}
