import 'package:bas_app/shared/styles/color_style.dart';
import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TextFieldLabelTopWidget extends StatefulWidget {
  const TextFieldLabelTopWidget({
    super.key,
    required this.title,
    required this.hint,
    required this.onChanged,
    this.width,
    required this.errorText,
    this.initialValue,
    this.keyboardType,
  });

  final String title;
  final String hint;
  final Function(String?) onChanged;
  final double? width;
  final RxString errorText;
  final String? initialValue;
  final TextInputType? keyboardType;

  @override
  State<TextFieldLabelTopWidget> createState() =>
      _TextFieldLabelTopWidgetState();
}

class _TextFieldLabelTopWidgetState extends State<TextFieldLabelTopWidget> {
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: blackTextStyle.copyWith(
                fontWeight: medium,
                fontSize: 14.sp,
                color: const Color(0xffA3A3A3),
              ),
            ),
            5.verticalSpace,
            SizedBox(
              width: widget.width,
              child: TextField(
                controller: inputController,
                keyboardType: widget.keyboardType ?? TextInputType.text,
                decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle: blackTextStyle.copyWith(
                    color: const Color(0xffBBBDC7),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.r),
                    borderSide: const BorderSide(
                      color: Color(0xffBBBDC7),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(
                      color: ColorStyle.primary,
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
