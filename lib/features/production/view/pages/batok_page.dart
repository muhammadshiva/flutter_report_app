import 'package:flutter/material.dart';
import 'package:flutter_report_app/features/production/controllers/production_controller.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_report_app/shared/widgets/text_form_field_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BatokPage extends StatelessWidget {
  const BatokPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = ProductionController.to;

    return ListView(
      children: [
        TextFormFieldWidget(
          controller: controller.dateController,
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
        SizedBox(height: 25.h),
        SizedBox(
          height: 45.h,
          child: DropdownButtonFormField<String>(
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
            value: 'Pilih Sumber Batok',
            style: blackTextStyle.copyWith(
              color: ColorStyle.black2,
              fontSize: 13.sp,
            ),
            onChanged: (String? newValue) {},
            items: <String>['Pilih Sumber Batok', 'Sumatera', 'Sulawesi'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
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
              ),
            ),
          ],
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
              ),
            ),
          ],
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
        SizedBox(
          height: 325.h,
          width: double.infinity,
          child: TextFormFieldWidget(
            contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
            minLines: 5,
            maxLines: 5,
            keyboardType: TextInputType.multiline,
          ),
        ),
      ],
    );
  }
}
