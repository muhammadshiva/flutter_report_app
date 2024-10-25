// ignore_for_file: must_be_immutable

import 'package:bas_app/shared/controllers/global_controller.dart';
import 'package:bas_app/shared/model/list_data_model.dart';
import 'package:bas_app/shared/styles/color_style.dart';
import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CardWidget extends StatelessWidget {
  CardWidget({
    super.key,
    required this.title,
    this.jenisMasukan = '',
    this.grade,
    required this.terakhirDitambahkan,
    required this.data,
    required this.onPressedEdit,
    required this.onPressedDelete,
    this.ukuranPisau = '',
  });

  final String title;
  final String jenisMasukan;
  final String terakhirDitambahkan;
  final String ukuranPisau;
  final String? grade;
  final List<ListData> data;
  void Function(BuildContext)? onPressedEdit;
  void Function(BuildContext)? onPressedDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Color(0xffD9D9D9),
          ),
        ),
      ),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: onPressedEdit,
              backgroundColor: ColorStyle.b3,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
            SlidableAction(
              onPressed: onPressedDelete,
              backgroundColor: ColorStyle.r4,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: blackTextStyle.copyWith(
                          color: ColorStyle.black2,
                          fontWeight: semiBold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  5.verticalSpace,
                  SizedBox(
                    width: jenisMasukan.isEmpty && ukuranPisau.isEmpty
                        ? 300.w
                        : ukuranPisau.isNotEmpty
                            ? 240.w
                            : 220.w,
                    child: Wrap(
                      spacing: 15.w,
                      children: data
                          .map(
                            (e) => RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${e.jenisData} ',
                                    style: blackTextStyle.copyWith(
                                      color: ColorStyle.black2,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' ${e.jumlah?.toDouble() ?? 0} Kg',
                                    style: TextStyle(
                                      color: ColorStyle.bb3,
                                      fontWeight: medium,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  5.verticalSpace,
                  Text(
                    'Terakhir ditambahkan pada \n${GlobalController.to.formatDate(terakhirDitambahkan)}',
                    style: blackTextStyle.copyWith(
                      color: const Color(0xffA3A3A3),
                      fontSize: 10.sp,
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),

              ukuranPisau.isEmpty
                  ? const SizedBox()
                  : Container(
                      margin: EdgeInsets.only(right: 7.w),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.r),
                        color: ColorStyle.primary,
                      ),
                      child: Text(
                        'Pisau $ukuranPisau',
                        style: whiteTextStyle.copyWith(
                          fontWeight: semiBold,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),

              //* LABEL
              jenisMasukan.isEmpty
                  ? const SizedBox()
                  : Container(
                      height: 50.w,
                      margin: EdgeInsets.only(right: 7.w),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 3.w),
                            decoration: BoxDecoration(
                              color: jenisMasukan == 'Penambahan'
                                  ? ColorStyle.green
                                  : ColorStyle.r5,
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                            child: Text(
                              jenisMasukan,
                              style: whiteTextStyle.copyWith(
                                fontWeight: semiBold,
                                fontSize: 9.sp,
                              ),
                            ),
                          ),
                          if (grade != null) ...[
                            Container(
                              margin: EdgeInsets.only(top: 7.w),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 4.w),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xff1924F2),
                                ),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Text('A', style: blueTextStyle),
                            ),
                          ]
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
