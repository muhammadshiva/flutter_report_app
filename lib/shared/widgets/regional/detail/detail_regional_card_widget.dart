import 'package:flutter/material.dart';
import 'package:flutter_report_app/configs/routes/route.dart';
import 'package:flutter_report_app/features/bahan_baku/controllers/bahan_baku_controller.dart';
import 'package:flutter_report_app/features/bahan_baku/models/bahan_baku_model.dart';
import 'package:flutter_report_app/features/bahan_baku/views/ui/bahan_baku_query_screen.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class DetailRegionalCardWidget extends StatelessWidget {
  const DetailRegionalCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 15.w),
      padding: EdgeInsets.fromLTRB(10.w, 10.w, 0.w, 10.w),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(data.bahanBaku ?? '-'),
              Text('Bahan Baku'),
              SizedBox(height: 5.w),
              SizedBox(
                width: 245.w,
                child: Wrap(
                  spacing: 10.w,
                  runSpacing: 5.w,
                  children: [
                    richText(
                      title: 'Masuk',
                      subtitle: '${20}',
                      units: 'Ton',
                    ),
                    richText(
                      title: 'Keluar',
                      subtitle: '${20}',
                      units: 'Ton',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.w),
              Text(
                'Tidak ada keterangan',
                style: blackTextStyle.copyWith(
                  color: const Color(0xffA3A3A3),
                  fontSize: 10.sp,
                  fontWeight: medium,
                ),
              ),
            ],
          ),
          PopupMenuButton<String>(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            icon: const Icon(
              Icons.more_horiz,
              color: Color(0xffA3A3A3),
            ),
            onSelected: (value) {
              if (value == 'edit') {
                Get.toNamed(Routes.ayakManualQueryRoute);

                // Get.to(
                //   () => BahanBakuQueryScreen(
                //     data: data,
                //     isEdit: true,
                //   ),
                //   fullscreenDialog: true,
                // );
              } else if (value == 'delete') {
                PanaraConfirmDialog.show(
                  context,
                  title: 'Hapus',
                  message: 'Apakah anda yakin ingin menghapus data ini ?',
                  confirmButtonText: 'Hapus',
                  cancelButtonText: 'Tidak',
                  onTapConfirm: () {
                    Get.back();
                    // controller.deleteBahanBaku(idBahanBaku: data.id ?? 0);
                  },
                  onTapCancel: () => Get.back(),
                  panaraDialogType: PanaraDialogType.error,
                );
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'edit',
                child: ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit'),
                ),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                child: ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: Text(
                    'Delete',
                    style: GoogleFonts.roboto().copyWith(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget richText({
    required String title,
    required String subtitle,
    required String units,
  }) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$title ',
            style: blackTextStyle.copyWith(
              color: ColorStyle.black2,
              fontSize: 10.sp,
            ),
          ),
          TextSpan(
            text: ' $subtitle $units',
            style: TextStyle(
              color: ColorStyle.bb3,
              fontWeight: medium,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
