import 'package:bas_app/shared/styles/color_style.dart';
import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MainDropdownFilter extends StatefulWidget {
  const MainDropdownFilter({
    super.key,
    this.textStyle,
    required this.onChanged,
    required this.items,
    required this.dataLength,
  });

  final TextStyle? textStyle;
  final void Function(String?) onChanged;
  final List<String> items;
  final RxInt dataLength;

  @override
  State<MainDropdownFilter> createState() => _MainDropdownFilterState();
}

class _MainDropdownFilterState extends State<MainDropdownFilter> {
  String selectedItem = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Row(
        children: [
          Text(
            'Data Wilayah',
            style: blackTextStyle.copyWith(
              fontWeight: semiBold,
              fontSize: 14.sp,
              color: ColorStyle.black2,
            ),
          ),
          5.horizontalSpace,
          Obx(
            () => Text(
              '(${widget.dataLength.value} Baris)',
              style: blackTextStyle.copyWith(
                fontSize: 12.sp,
                color: const Color(
                  0xffA3A3A3,
                ),
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 30.h,
            width: 120.w,
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                  borderSide: const BorderSide(
                    color: Color(0xffC5C6CC),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                  borderSide: const BorderSide(color: ColorStyle.primary),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 19.w),
              ),
              value: selectedItem.isEmpty ? widget.items.first : selectedItem,
              style: blackTextStyle.copyWith(
                color: ColorStyle.black2,
                fontSize: 10.sp,
              ),
              onChanged: (value) {
                setState(() {
                  selectedItem = value ?? '';
                  widget.onChanged(value);
                });
              },
              items: widget.items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: blackTextStyle.copyWith(
                      fontSize: 10.sp,
                      fontWeight: semiBold,
                      color: ColorStyle.black2,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}


    // value: widget.items.isNotEmpty && selectedItem.isNotEmpty
              //     ? widget.items.firstWhere(
              //         (element) => element == selectedItem,
              //       )
              //     : widget.items.first,