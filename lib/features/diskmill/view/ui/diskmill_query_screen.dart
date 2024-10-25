import 'package:bas_app/features/diskmill/controllers/diskmill_query_controller.dart';
import 'package:bas_app/shared/styles/color_style.dart';
import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:bas_app/shared/widgets/custom_button/button_widget.dart';
import 'package:bas_app/shared/widgets/custom_button/dropdown_widget.dart';
import 'package:bas_app/shared/widgets/custom_text_field/date_widget.dart';
import 'package:bas_app/shared/widgets/custom_text_field/text_field_label_widget.dart';
import 'package:bas_app/shared/widgets/custom_text_field/text_field_note_widget.dart';
import 'package:bas_app/shared/widgets/general/app_bar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DiskmillQueryScreen extends StatelessWidget {
  const DiskmillQueryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = DiskmillQueryController.to;

    return Scaffold(
      appBar: AppBarCustom(
        title: '${controller.isEdit.isTrue ? 'Edit' : 'Input'} Data Diskmill',
        onBack: () {
          Get.back();
        },
      ),
      body: SizedBox(
        height: 1.sh,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: ListView(
                  children: [
                    20.verticalSpace,
                    DateWidget(
                      initialValue: controller.tanggalTxtInit.value,
                      onChanged: (value) {
                        controller.tanggalTxt.value = value ?? '';
                      },
                      errorText: controller.tanggalError,
                    ),
                    20.verticalSpace,
                    DropdownWidget(
                      hinText: 'Pilih Sumber Batok',
                      initialValue: controller.sumberBatokTxt.value,
                      listItem: controller.dropdownSumberBatok,
                      onChanged: (value) {
                        controller.sumberBatokTxt.value = value ?? '';
                      },
                      errorText: controller.sumberBatokError,
                    ),
                    20.verticalSpace,
                    TextFieldLabelWidget(
                      title: 'Batok Masuk',
                      unit: 'Kg',
                      initialValue: controller.batokMasukTxt.value,
                      onChanged: (value) {
                        controller.batokMasukTxt.value = value ?? '';
                      },
                      errorText: controller.batokMasukError,
                    ),
                    20.verticalSpace,
                    Text(
                      'Hasil',
                      style: blackTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 14.sp,
                        color: ColorStyle.black2,
                      ),
                    ),
                    20.verticalSpace,
                    TextFieldLabelWidget(
                      title: 'Pisau 0.2',
                      unit: 'Kg',
                      initialValue: controller.hasilPisau02Txt.value,
                      onChanged: (value) {
                        controller.hasilPisau02Txt.value = value ?? '';
                      },
                      errorText: controller.hasilPisau02Error,
                    ),
                    20.verticalSpace,
                    TextFieldLabelWidget(
                      title: 'Pisau 0.3',
                      unit: 'Kg',
                      initialValue: controller.hasilPisau03Txt.value,
                      onChanged: (value) {
                        controller.hasilPisau03Txt.value = value ?? '';
                      },
                      errorText: controller.hasilPisau03Error,
                    ),
                    20.verticalSpace,
                    TextFieldNoteWidget(
                      initialValue: controller.keteranganTxt.value,
                      onChanged: (value) {
                        controller.keteranganTxt.value = value ?? '';
                      },
                      errorText: controller.keteranganError,
                    ),
                    20.verticalSpace,
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.w),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: const Offset(0, -1),
                    blurRadius: 2,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: ButtonWidget(
                width: double.infinity,
                text: 'Simpan Data',
                color: ColorStyle.primary,
                textStyle: whiteTextStyle,
                onPressed: () {
                  controller.validateForm();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
