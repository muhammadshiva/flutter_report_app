import 'package:flutter/material.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldNoteWidgetCustom extends StatelessWidget {
  const TextFieldNoteWidgetCustom({
    super.key,
    required this.controller,
    required this.errorText,
  });

  final TextEditingController controller;
  final RxString errorText;

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
          key: const Key('keterangan'),
          controller: controller,
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
          // focusNode: keteranganFocusNode,
          onEditingComplete: () {},
          onTap: () {
            // controller.isScroll.value = true;

            // scrollController.animateTo(
            //   10 * 100,
            //   duration: const Duration(milliseconds: 300),
            //   curve: Curves.easeOut,
            // );
          },
          onChanged: (value) {
            // if (value.isNotEmpty) {
            //   errorText.value = '';
            // } else {
            //   errorText.value = 'Tidak boleh kosong';
            // }
          },
        ),
        Obx(
          () => Visibility(
            visible: errorText.isEmpty ? false : true,
            child: Container(
              margin: EdgeInsets.only(top: 10.w),
              child: Text(
                errorText.value,
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
