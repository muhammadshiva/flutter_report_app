import 'package:flutter/material.dart';
import 'package:flutter_report_app/features/batok/controllers/batok_controller.dart';
import 'package:flutter_report_app/features/batok/models/batok_model.dart';
import 'package:flutter_report_app/features/batok/views/ui/batok_list_data_screen.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BatokList extends StatelessWidget {
  const BatokList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var controller = BatokController.to;

    return Container(
      margin: EdgeInsets.only(top: 14.h),
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Scrollbar(
        child: Container(
          height: MediaQuery.sizeOf(context).height * 0.5,
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Obx(
            () {
              if (controller.isLoading.isFalse && controller.listBatokData.isEmpty) {
                return Center(
                  child: Text(
                    'Data kosong',
                    style: GoogleFonts.poppins(),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  await controller.getBatok();
                },
                child: ListView.builder(
                  itemCount: controller.listBatokData.length,
                  itemBuilder: (context, index) {
                    var data = controller.listBatokData[index];

                    return InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        Get.to(
                          () => BatokListDataScreen(batokData: data),
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

  void slideableAction(BuildContext context) {}

  Widget itemDataWidget({required BatokController controller, required BatokData data}) {
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
                      text: 'Barang ',
                      style: blackTextStyle.copyWith(
                        color: ColorStyle.black2,
                        fontSize: 10.sp,
                      ),
                    ),
                    TextSpan(
                      text: ' ${data.persentaseBarang!.round()}%',
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
                      text: ' ${data.persentaseStok!.round()}%',
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
            'Ditambahkan pada ${controller.formatDate(date: data.tanggal ?? '')}',
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
