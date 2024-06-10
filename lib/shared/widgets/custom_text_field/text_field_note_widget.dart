import 'package:bas_app/shared/styles/color_style.dart';
import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldNoteWidget extends StatefulWidget {
  const TextFieldNoteWidget({
    super.key,
    required this.onChanged,
    required this.errorText,
    this.initialValue,
  });

  final Function(String?) onChanged;
  final RxString errorText;
  final String? initialValue;

  @override
  State<TextFieldNoteWidget> createState() => _TextFieldNoteWidgetState();
}

class _TextFieldNoteWidgetState extends State<TextFieldNoteWidget> {
  TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    if (widget.initialValue!.isNotEmpty) {
      noteController.text = widget.initialValue ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Keterangan',
          style: blackTextStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: semiBold,
            color: ColorStyle.black2,
          ),
        ),
        10.verticalSpace,
        TextField(
          controller: noteController,
          minLines: 5,
          maxLines: 5,
          keyboardType: TextInputType.multiline,
          style: GoogleFonts.poppins().copyWith(fontSize: 14.sp),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                10.r,
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
