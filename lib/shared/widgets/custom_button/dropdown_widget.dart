import 'package:bas_app/shared/styles/color_style.dart';
import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DropdownWidget extends StatefulWidget {
  const DropdownWidget({
    super.key,
    required this.listItem,
    required this.onChanged,
    required this.errorText,
    this.initialValue,
  });

  final List<String> listItem;
  final Function(String?) onChanged;
  final RxString errorText;
  final String? initialValue;

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String selectedItem = '';

  @override
  void initState() {
    if (widget.initialValue!.isNotEmpty) {
      selectedItem = widget.initialValue ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: const BorderSide(
                color: Color(0xffC5C6CC),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(
                color: ColorStyle.primary,
              ),
            ),
          ),
          hint: Text(
            'Pilih Sumber Batok',
            style: blackTextStyle.copyWith(
              color: ColorStyle.black2,
              fontSize: 14.sp,
            ),
          ),
          value: widget.listItem.isNotEmpty && selectedItem.isNotEmpty
              ? widget.listItem.firstWhere(
                  (element) => element == selectedItem,
                )
              : null,
          style: blackTextStyle.copyWith(
            color: ColorStyle.black2,
            fontSize: 13.sp,
          ),
          onChanged: (String? value) {
            setState(() {
              selectedItem = value ?? '';
              widget.onChanged(value);
              if (selectedItem.isNotEmpty) {
                widget.errorText.value = '';
              }
            });
          },
          items: widget.listItem.map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: blackTextStyle.copyWith(
                    fontSize: 14.sp,
                    fontWeight: semiBold,
                    color: ColorStyle.black2,
                  ),
                ),
              );
            },
          ).toList(),
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
}
