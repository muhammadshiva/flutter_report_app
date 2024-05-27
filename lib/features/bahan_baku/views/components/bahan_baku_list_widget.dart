import 'package:flutter/material.dart';
import 'package:flutter_report_app/features/bahan_baku/controllers/bahan_baku_controller.dart';
import 'package:flutter_report_app/features/bahan_baku/models/bahan_baku_model.dart';
import 'package:flutter_report_app/features/bahan_baku/views/ui/bahan_baku_list_data_screen.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BahanBakuList extends StatelessWidget {
  const BahanBakuList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var controller = BahanBakuController.to;

    return Container(
      margin: EdgeInsets.only(top: 14.h),
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Scrollbar(
        child: Container(
          height: MediaQuery.sizeOf(context).height *
              (controller.titleMenu.value == 'Keluar / Masuk Batok' ? 0.5 : 0.39),
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Obx(
            () {
              if (controller.isLoading.isFalse && controller.listBahanBakuData.isEmpty) {
                return Center(
                  child: Text(
                    'Data kosong',
                    style: GoogleFonts.poppins(),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  await controller.getBahanBaku();
                },
                child: ListView.builder(
                  itemCount: controller.listBahanBakuData.length,
                  itemBuilder: (context, index) {
                    var data = controller.listBahanBakuData[index];

                    return InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        Get.to(
                          () => BahanBakuListDataScreen(bahanBakuData: data),
                          fullscreenDialog: true,
                        );
                      },
                      child: itemDataWidget(
                        controller: controller,
                        data: data,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget itemDataWidget({required BahanBakuController controller, required BahanBakuData data}) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(5.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.sumberBatok ?? '-',
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
                      text: 'Stok ',
                      style: blackTextStyle.copyWith(
                        color: ColorStyle.black2,
                        fontSize: 10.sp,
                      ),
                    ),
                    TextSpan(
                      text: ' ${data.persentaseBahanBaku!.round()}%',
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
            'Terakhir ditambahkan pada ${controller.formatDate(date: data.tanggal ?? '')}',
            style: blackTextStyle.copyWith(
              color: const Color(0xffA3A3A3),
              fontSize: 10.sp,
              fontWeight: medium,
            ),
          ),
        ],
      ),
    );
  }
}
