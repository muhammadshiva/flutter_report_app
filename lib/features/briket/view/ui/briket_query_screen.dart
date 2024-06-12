import 'package:bas_app/features/briket/controllers/briket_query_controller.dart';
import 'package:bas_app/shared/styles/color_style.dart';
import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:bas_app/shared/widgets/custom_button/button_widget.dart';
import 'package:bas_app/shared/widgets/custom_button/dropdown_widget.dart';
import 'package:bas_app/shared/widgets/custom_text_field/date_widget.dart';
import 'package:bas_app/shared/widgets/custom_text_field/text_field_label_widget.dart';
import 'package:bas_app/shared/widgets/custom_text_field/text_field_note_widget.dart';
import 'package:bas_app/shared/widgets/general/app_bar_custom.dart';
import 'package:bas_app/shared/widgets/general/input_type_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BriketQueryScreen extends StatelessWidget {
  const BriketQueryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = BriketQueryController.to;

    return PopScope(
      onPopInvoked: (didPop) {},
      child: Scaffold(
        appBar: AppBarCustom(
          title: '${controller.isEdit.isTrue ? 'Edit' : 'Input'} Data Oven',
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
                      InputTypeWidget(
                        onChanged: (value) {
                          controller.jenisMasukanTxt.value = value ?? '';
                        },
                        errorText: controller.jenisMasukanError,
                        initialValue: controller.jenisMasukanTxt.value,
                      ),
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
                      Text(
                        'Jenis Briket',
                        style: blackTextStyle.copyWith(
                          fontWeight: semiBold,
                          fontSize: 14.sp,
                          color: ColorStyle.black2,
                        ),
                      ),
                      15.verticalSpace,
                      Obx(
                        () => Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: controller.grades
                              .map(
                                (element) => GestureDetector(
                                  onTap: () {
                                    controller.selectedInputType.value =
                                        element;
                                    controller.jenisBriketTxt.value = element;
                                    if (controller.jenisBriketTxt.isNotEmpty) {
                                      controller.jenisBriketError.value = '';
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 27.w,
                                      vertical: 10.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          controller.selectedInputType.value !=
                                                  element
                                              ? Colors.transparent
                                              : ColorStyle.primary,
                                      border: Border.all(
                                        color: controller
                                                    .selectedInputType.value !=
                                                element
                                            ? ColorStyle.primary
                                            : ColorStyle.primary,
                                      ),
                                      borderRadius: BorderRadius.circular(41.w),
                                    ),
                                    child: Text(
                                      element,
                                      style: blackTextStyle.copyWith(
                                        fontWeight: semiBold,
                                        fontSize: 10.sp,
                                        color: controller
                                                    .selectedInputType.value !=
                                                element
                                            ? ColorStyle.primary
                                            : ColorStyle.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      5.verticalSpace,
                      Obx(
                        () => Visibility(
                          visible: controller.jenisBriketError.isNotEmpty,
                          child: Text(
                            controller.jenisBriketError.value,
                            style: redTextStyle.copyWith(
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                      20.verticalSpace,
                      TextFieldLabelWidget(
                        title: 'Stok',
                        initialValue: controller.stokTxt.value,
                        onChanged: (value) {
                          controller.stokTxt.value = value ?? '';
                        },
                        errorText: controller.stokError,
                        unit: 'Kg',
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
      ),
    );
  }
}
