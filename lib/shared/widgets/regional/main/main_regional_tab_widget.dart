import 'package:flutter/material.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainRegionalTabWidget extends StatefulWidget {
  const MainRegionalTabWidget({
    super.key,
    required this.onTabChanged,
  });

  final Function(int, String) onTabChanged;

  @override
  State<MainRegionalTabWidget> createState() => _MainRegionalTabWidgetState();
}

class _MainRegionalTabWidgetState extends State<MainRegionalTabWidget> {
  List<Map<String, dynamic>> tabData = [
    {"id": 1, "tabName": "Mingguan"},
    {"id": 2, "tabName": "Bulanan"},
    {"id": 3, "tabName": "Tahunan"}
  ];

  int tabIndex = 1;
  String filterBy = 'Mingguan';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.h, bottom: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: tabData
                .map(
                  (e) => InkWell(
                    onTap: () {
                      setState(() {
                        tabIndex = e['id'];
                        filterBy = e['tabName'];
                      });
                      widget.onTabChanged(tabIndex, filterBy);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 32.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: tabIndex == e['id'] ? ColorStyle.primary : ColorStyle.white,
                        border: Border.all(
                          color: ColorStyle.primary,
                        ),
                      ),
                      child: Text(
                        e['tabName'],
                        style: whiteTextStyle.copyWith(
                          fontSize: 10.sp,
                          fontWeight: semiBold,
                          color: tabIndex == e['id'] ? ColorStyle.white : ColorStyle.primary,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          // 30.verticalSpace,
          // Text(
          //   'Persentase Perbandingan Sisa',
          //   style: blackTextStyle.copyWith(
          //     fontWeight: medium,
          //     fontSize: 14.sp,
          //   ),
          // ),
          // Text(
          //   filterBy,
          //   style: greyTextStyle.copyWith(
          //     fontSize: 12.sp,
          //     fontWeight: medium,
          //     color: ColorStyle.grey2,
          //   ),
          // ),
        ],
      ),
    );
  }
}
