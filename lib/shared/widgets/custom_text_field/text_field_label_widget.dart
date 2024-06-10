import 'package:bas_app/shared/styles/color_style.dart';
import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TextFieldLabelWidget extends StatefulWidget {
  const TextFieldLabelWidget({
    super.key,
    required this.title,
    required this.onChanged,
    this.width,
    required this.errorText,
    this.initialValue,
  });

  final String title;
  final Function(String?) onChanged;
  final double? width;
  final RxString errorText;
  final String? initialValue;

  @override
  State<TextFieldLabelWidget> createState() => _TextFieldLabelWidgetState();
}

class _TextFieldLabelWidgetState extends State<TextFieldLabelWidget> {
  TextEditingController inputController = TextEditingController();

  @override
  void initState() {
    if (widget.initialValue!.isNotEmpty) {
      inputController.text = widget.initialValue ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.title,
              style: blackTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 14.sp,
                color: ColorStyle.black2,
              ),
            ),
            20.horizontalSpace,
            Expanded(
              child: TextField(
                controller: inputController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
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
                  suffixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                    child: Text(
                      '.Kg',
                      style: blackTextStyle.copyWith(
                        color: const Color(0xffBBBDC7),
                        fontSize: 12.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                onChanged: (value) {
                  widget.onChanged(value);
                  if (value.isNotEmpty) {
                    widget.errorText.value = '';
                  } else {
                    widget.errorText.value = 'Tidak boleh kosong';
                  }
                },
              ),
            ),
          ],
        ),
        Obx(
          () => Visibility(
            visible: widget.errorText.isNotEmpty,
            child: Container(
              margin: EdgeInsets.only(top: 10.w),
              child: Text(
                widget.errorText.value,
                style: redTextStyle.copyWith(
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
