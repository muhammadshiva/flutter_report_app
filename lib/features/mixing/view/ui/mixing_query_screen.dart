import 'package:bas_app/features/mixing/controllers/mixing_query_controller.dart';
import 'package:bas_app/shared/styles/color_style.dart';
import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:bas_app/shared/widgets/custom_button/button_widget.dart';
import 'package:bas_app/shared/widgets/custom_button/dropdown_widget.dart';
import 'package:bas_app/shared/widgets/custom_text_field/date_widget.dart';
import 'package:bas_app/shared/widgets/custom_text_field/text_field_labe_top_widget.dart';
import 'package:bas_app/shared/widgets/custom_text_field/text_field_label_widget.dart';
import 'package:bas_app/shared/widgets/custom_text_field/text_field_note_widget.dart';
import 'package:bas_app/shared/widgets/general/app_bar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MixingQueryScreen extends StatelessWidget {
  const MixingQueryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = MixingQueryController.to;

    return Scaffold(
      appBar: AppBarCustom(
        title: '${controller.isEdit.isTrue ? 'Edit' : 'Input'} Data Mixing',
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
                    // 20.verticalSpace,
                    // DropdownWidget(
                    //   hinText: 'Pilih Sumber Batok',
                    //   initialValue: controller.sumberBatokTxt.value,
                    //   listItem: controller.dropdownSumberBatok,
                    //   onChanged: (value) {
                    //     controller.sumberBatokTxt.value = value ?? '';
                    //   },
                    //   errorText: controller.sumberBatokError,
                    // ),
                    20.verticalSpace,
                    DropdownWidget(
                      hinText: 'Pilih Ukuran Pisau',
                      initialValue: controller.ukuranPisauTxt.value,
                      listItem: controller.dropdownUkuranPisau,
                      onChanged: (value) {
                        controller.ukuranPisauTxt.value = value ?? '';
                      },
                      errorText: controller.ukuranPisauError,
                    ),
                    20.verticalSpace,
                    Text(
                      'Bahan Dimasukkan',
                      style: blackTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 14.sp,
                        color: ColorStyle.black2,
                      ),
                    ),
                    20.verticalSpace,
                    TextFieldLabelWidget(
                      title: 'Aci',
                      unit: 'Kg',
                      initialValue: controller.jumlahAciTxt.value,
                      onChanged: (value) {
                        controller.jumlahAciTxt.value = value ?? '';
                      },
                      errorText: controller.jumlahAciError,
                    ),
                    20.verticalSpace,
                    TextFieldLabelWidget(
                      title: 'Cairan',
                      unit: 'Kg',
                      initialValue: controller.jumlahCairanTxt.value,
                      onChanged: (value) {
                        controller.jumlahCairanTxt.value = value ?? '';
                      },
                      errorText: controller.jumlahCairanError,
                    ),
                    20.verticalSpace,
                    Text(
                      'Arang Dimasukkan',
                      style: blackTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 14.sp,
                        color: ColorStyle.black2,
                      ),
                    ),
                    20.verticalSpace,
                    TextFieldLabelWidget(
                      title: 'Arang\nSulawesi',
                      unit: 'Kg',
                      initialValue: controller.jumlahArangSulawesiTxt.value,
                      onChanged: (value) {
                        controller.jumlahArangSulawesiTxt.value = value ?? '';
                      },
                      errorText: controller.jumlahArangSulawesiError,
                    ),
                    20.verticalSpace,
                    TextFieldLabelWidget(
                      title: 'Arang\nSumatera',
                      unit: 'Kg',
                      initialValue: controller.jumlahArangSumateraTxt.value,
                      onChanged: (value) {
                        controller.jumlahArangSumateraTxt.value = value ?? '';
                      },
                      errorText: controller.jumlahArangSumateraError,
                    ),
                    20.verticalSpace,
                    TextFieldLabelWidget(
                      title: 'Arang Kayu',
                      unit: 'Kg',
                      initialValue: controller.jumlahArangKayuTxt.value,
                      onChanged: (value) {
                        controller.jumlahArangKayuTxt.value = value ?? '';
                      },
                      errorText: controller.jumlahArangKayuError,
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
