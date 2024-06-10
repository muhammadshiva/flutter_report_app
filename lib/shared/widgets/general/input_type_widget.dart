import 'package:bas_app/shared/styles/color_style.dart';
import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class InputTypeWidget extends StatefulWidget {
  const InputTypeWidget({
    super.key,
    required this.onChanged,
    required this.errorText,
    this.initialValue,
  });

  final Function(String?) onChanged;
  final RxString errorText;
  final String? initialValue;

  @override
  State<InputTypeWidget> createState() => _InputTypeWidgetState();
}

class _InputTypeWidgetState extends State<InputTypeWidget> {
  List<String> inputType = ['Penambahan', 'Pengurangan'];
  String selectedInputType = '';

  @override
  void initState() {
    if (widget.initialValue!.isNotEmpty) {
      selectedInputType = widget.initialValue ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Jenis Input',
          style: blackTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 14.sp,
            color: ColorStyle.black2,
          ),
        ),
        5.verticalSpace,
        Text(
          'Pilih jenis input data penambahan atau pengurangan',
          style: blackTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 11.sp,
            color: ColorStyle.grey2,
          ),
        ),
        10.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: inputType
              .map(
                (value) => Stack(
                  children: [
                    Positioned(
                      left: 130.w,
                      top: 6.w,
                      child: selectedInputType != value
                          ? Icon(
                              Icons.circle_outlined,
                              size: 14.w,
                              color: ColorStyle.grey2,
                            )
                          : Icon(
                              Icons.check_circle_rounded,
                              size: 14.w,
                              color: selectedInputType == value && selectedInputType == 'Penambahan'
                                  ? Colors.green
                                  : selectedInputType == value && selectedInputType == 'Pengurangan'
                                      ? ColorStyle.r5
                                      : ColorStyle.grey2,
                            ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          selectedInputType = value;
                          if (selectedInputType.isNotEmpty) widget.onChanged(value);
                          if (selectedInputType.isNotEmpty) {
                            widget.errorText.value = '';
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 32.w,
                          vertical: 12.w,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.r),
                          color: selectedInputType == value && selectedInputType == 'Penambahan'
                              ? Colors.green.withOpacity(0.11)
                              : selectedInputType == value && selectedInputType == 'Pengurangan'
                                  ? ColorStyle.r5.withOpacity(0.11)
                                  : Colors.transparent,
                          border: Border.all(
                            color: selectedInputType == value && selectedInputType == 'Penambahan'
                                ? Colors.green
                                : selectedInputType == value && selectedInputType == 'Pengurangan'
                                    ? ColorStyle.r5
                                    : ColorStyle.grey2,
                          ),
                        ),
                        child: Text(
                          value,
                          style: GoogleFonts.poppins().copyWith(
                            color: selectedInputType == value && selectedInputType == 'Penambahan'
                                ? Colors.green
                                : selectedInputType == value && selectedInputType == 'Pengurangan'
                                    ? ColorStyle.r5
                                    : ColorStyle.grey2,
                            fontWeight: semiBold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
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
