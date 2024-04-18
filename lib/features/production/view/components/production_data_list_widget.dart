import 'package:flutter/material.dart';
import 'package:flutter_report_app/features/production/controllers/production_controller.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProductionDataListWidget extends StatelessWidget {
  const ProductionDataListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = ProductionController.to;

    return Container(
      margin: EdgeInsets.only(top: 14.h),
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Scrollbar(
        child: Container(
            height: MediaQuery.sizeOf(context).height * (controller.titleMenu.value == 'Keluar / Masuk Batok' ? 0.5 : 0.39),
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: ListView(
              children: [
                itemDataWidget(),
                itemDataWidget(),
                itemDataWidget(),
                itemDataWidget(),
                itemDataWidget(),
                itemDataWidget(),
                itemDataWidget(),
              ],
            )),
      ),
    );
  }

  void slideableAction(BuildContext context) {}

  Widget itemDataWidget() {
    return Container(
      height: 75.h,
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color(0xffA3A3A3),
            width: 1.w,
          ),
        ),
      ),
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.5,
          children: [
            SlidableAction(
              onPressed: slideableAction,
              backgroundColor: ColorStyle.b3,
              foregroundColor: Colors.white,
              icon: Icons.edit_document,
              label: 'Edit',
            ),
            SlidableAction(
              onPressed: slideableAction,
              backgroundColor: ColorStyle.r4,
              foregroundColor: Colors.white,
              icon: Icons.save,
              label: 'Delete',
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sumatera',
              style: blackTextStyle.copyWith(
                color: ColorStyle.black2,
                fontWeight: semiBold,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Barang ',
                        style: blackTextStyle.copyWith(
                          color: ColorStyle.black2,
                          fontSize: 10.sp,
                        ),
                      ),
                      TextSpan(
                        text: ' 35%',
                        style: TextStyle(
                          color: ColorStyle.bb3,
                          fontWeight: medium,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Stok ',
                        style: blackTextStyle.copyWith(
                          color: ColorStyle.black2,
                          fontSize: 10.sp,
                        ),
                      ),
                      TextSpan(
                        text: ' 40%',
                        style: TextStyle(
                          color: ColorStyle.bb3,
                          fontWeight: medium,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              'Ditambahkan pada 26 Maret, 2024',
              style: blackTextStyle.copyWith(
                color: const Color(0xffA3A3A3),
                fontSize: 10.sp,
                fontWeight: medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
