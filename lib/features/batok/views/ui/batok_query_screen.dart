import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_report_app/features/batok/controllers/batok_controller.dart';
import 'package:flutter_report_app/features/batok/models/batok_model.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_report_app/shared/widgets/elevated_button_widget.dart';
import 'package:flutter_report_app/shared/widgets/text_form_field_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BatokQueryScreen extends StatelessWidget {
  const BatokQueryScreen({super.key, this.data, required this.isEdit});

  final ListBatok? data;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    var controller = BatokController.to;
    final ScrollController scrollController = ScrollController();
    final FocusNode keteranganFocusNode = FocusNode();

    if (isEdit == true) {
      controller.idBatok.value = data?.id ?? 0;
      controller.sumberBatok.value = data?.sumberBatok ?? '';
      controller.tanggal.text = controller.formatDate(date: data?.tanggal ?? '-');
      controller.postTanggal.value = controller.formatPostDate(date: data?.tanggal ?? '-');
      controller.barangKeluar.text = data?.barangKeluar.toString() ?? '';
      controller.barangMasuk.text = data?.barangMasuk.toString() ?? '';
      controller.stokAwal.text = data?.stokAwal.toString() ?? '';
      controller.stokAkhir.text = data?.stokAkhir.toString() ?? '';
      controller.keterangan.text = data?.keterangan ?? 'Tidak ada keterangan';

      debugPrint('ID BATOK : ${data?.id ?? 0}');
    } else {
      controller.idBatok.value = 0;
      controller.sumberBatok.value = '';
      controller.tanggal.text = '';
      controller.postTanggal.value = '';
      controller.barangKeluar.text = '';
      controller.barangMasuk.text = '';
      controller.stokAwal.text = '';
      controller.stokAkhir.text = '';
      controller.keterangan.text = '';
    }

    keteranganFocusNode.addListener(() {
      if (!keteranganFocusNode.hasFocus) {
        controller.isScroll.value = false;
        scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          isEdit ? 'Edit Data' : 'Input Data',
          style: blackTextStyle.copyWith(
            fontSize: 17.sp,
            fontWeight: semiBold,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 25.w,
          vertical: 30.h,
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormFieldWidget(
                key: const Key('tanggal'),
                controller: controller.tanggal,
                hint: 'Pilih Tanggal',
                readOnly: true,
                keyboardType: TextInputType.datetime,
                contentPadding: EdgeInsets.symmetric(vertical: 5.h),
                borderColor: const Color(0xffBBBDC7),
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: const Icon(
                    Icons.calendar_month_outlined,
                    color: Color(0xffBBBDC7),
                  ),
                ),
                onTap: () {
                  controller.selectDate(context);
                },
              ),
              Obx(
                () => Visibility(
                  visible: controller.tanggalErrorText.isEmpty ? false : true,
                  child: Container(
                    margin: EdgeInsets.only(top: 10.w),
                    child: Text(
                      controller.tanggalErrorText.value,
                      style: redTextStyle.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              SizedBox(
                height: 45.h,
                child: Obx(
                  () => DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(
                          color: Color(0xffC5C6CC),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
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
                        fontSize: 14.sp,
                        fontWeight: semiBold,
                        color: ColorStyle.black2,
                      ),
                    ),
                    value: controller.sumberBatok.isNotEmpty
                        ? controller.listSumberBatok.firstWhere(
                            (element) => element == controller.sumberBatok.value,
                          )
                        : null,
                    style: blackTextStyle.copyWith(
                      color: ColorStyle.black2,
                      fontSize: 13.sp,
                    ),
                    onChanged: (String? value) {
                      controller.sumberBatok.value = value ?? '';
                      controller.sumberBatokErrorText.value = '';
                    },
                    items: controller.listSumberBatok.map<DropdownMenuItem<String>>(
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
                ),
              ),
              Obx(
                () => Visibility(
                  visible: controller.sumberBatokErrorText.isEmpty ? false : true,
                  child: Container(
                    margin: EdgeInsets.only(top: 10.w),
                    child: Text(
                      controller.sumberBatokErrorText.value,
                      style: redTextStyle.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              Text(
                'Barang',
                style: blackTextStyle.copyWith(
                  fontSize: 14.sp,
                  fontWeight: semiBold,
                  color: ColorStyle.black2,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Text(
                    'Keluar',
                    style: blackTextStyle.copyWith(
                      fontSize: 12.sp,
                      fontWeight: semiBold,
                      color: const Color(0xffA3A3A3),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 90.w,
                    child: TextFormFieldWidget(
                      key: const Key('barangKeluar'),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: controller.barangMasuk,
                      keyboardType: TextInputType.number,
                      contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
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
                      onChange: (value) {
                        if (value.isNotEmpty) {
                          controller.barangKeluarErrorText.value = '';
                        } else {
                          controller.barangKeluarErrorText.value = 'Tidak boleh kosong';
                        }
                      },
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Masuk',
                    style: blackTextStyle.copyWith(
                      fontSize: 12.sp,
                      fontWeight: semiBold,
                      color: const Color(0xffA3A3A3),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 90.w,
                    child: TextFormFieldWidget(
                      key: const Key('barangMasuk'),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: controller.barangKeluar,
                      keyboardType: TextInputType.number,
                      contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
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
                      onChange: (value) {
                        if (value.isNotEmpty) {
                          controller.barangMasukErrorText.value = '';
                        } else {
                          controller.barangMasukErrorText.value = 'Tidak boleh kosong';
                        }
                      },
                    ),
                  ),
                ],
              ),
              Obx(
                () => Visibility(
                  visible: controller.barangKeluarErrorText.isEmpty &&
                          controller.barangMasukErrorText.isEmpty
                      ? false
                      : true,
                  child: Container(
                    margin: EdgeInsets.only(top: 10.w),
                    child: Text(
                      'Tidak boleh kosong',
                      style: redTextStyle.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              Text(
                'Stok',
                style: blackTextStyle.copyWith(
                  fontSize: 14.sp,
                  fontWeight: semiBold,
                  color: ColorStyle.black2,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Text(
                    'Awal',
                    style: blackTextStyle.copyWith(
                      fontSize: 12.sp,
                      fontWeight: semiBold,
                      color: const Color(0xffA3A3A3),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 90.w,
                    child: TextFormFieldWidget(
                      key: const Key('stokAwal'),
                      controller: controller.stokAwal,
                      keyboardType: TextInputType.number,
                      contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
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
                      onChange: (value) {
                        if (value.isNotEmpty) {
                          controller.stokAwalErrorText.value = '';
                        } else {
                          controller.stokAwalErrorText.value = 'Tidak boleh kosong';
                        }
                      },
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Akhir',
                    style: blackTextStyle.copyWith(
                      fontSize: 12.sp,
                      fontWeight: semiBold,
                      color: const Color(0xffA3A3A3),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 90.w,
                    child: TextFormFieldWidget(
                      key: const Key('stokAkhir'),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: controller.stokAkhir,
                      keyboardType: TextInputType.number,
                      contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
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
                      onChange: (value) {
                        if (value.isNotEmpty) {
                          controller.stokAkhirErrorText.value = '';
                        } else {
                          controller.stokAkhirErrorText.value = 'Tidak boleh kosong';
                        }
                      },
                    ),
                  ),
                ],
              ),
              Obx(
                () => Visibility(
                  visible:
                      controller.stokAwalErrorText.isEmpty && controller.stokAkhirErrorText.isEmpty
                          ? false
                          : true,
                  child: Container(
                    margin: EdgeInsets.only(top: 10.w),
                    child: Text(
                      'Tidak boleh kosong',
                      style: redTextStyle.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              Text(
                'Keterangan',
                style: blackTextStyle.copyWith(
                  fontSize: 14.sp,
                  fontWeight: semiBold,
                  color: ColorStyle.black2,
                ),
              ),
              SizedBox(height: 10.h),
              TextField(
                key: const Key('keterangan'),
                controller: controller.keterangan,
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
                focusNode: keteranganFocusNode,
                onEditingComplete: () {},
                onTap: () {
                  controller.isScroll.value = true;

                  scrollController.animateTo(
                    // scrollController.position.maxScrollExtent,
                    10 * 100,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    controller.keteranganErrorText.value = '';
                  } else {
                    controller.keteranganErrorText.value = 'Tidak boleh kosong';
                  }
                },
              ),
              Obx(
                () => Visibility(
                  visible: controller.keteranganErrorText.isEmpty ? false : true,
                  child: Container(
                    margin: EdgeInsets.only(top: 10.w),
                    child: Text(
                      controller.keteranganErrorText.value,
                      style: redTextStyle.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
              ),
              Obx(() => SizedBox(height: controller.isScroll.isTrue ? 350.w : 0.w)),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          color: ColorStyle.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x40000000),
              offset: Offset(0, -1),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
        child: ElevatedButtonWidget(
          width: double.infinity,
          text: 'Simpan Data',
          color: ColorStyle.primary,
          textStyle: whiteTextStyle.copyWith(fontSize: 14.sp),
          onPressed: () {
            controller.postBatok();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
