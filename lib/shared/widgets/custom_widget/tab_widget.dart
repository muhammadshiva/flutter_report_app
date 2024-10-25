import 'package:bas_app/shared/styles/color_style.dart';
import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabWidget extends StatefulWidget {
  const TabWidget({
    super.key,
    required this.onTabChanged,
    this.showPercentage = true,
  });

  final Function(int, String) onTabChanged;
  final bool? showPercentage;

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  List<Map<String, dynamic>> tabData = [
    {"id": 1, "tabName": "Mingguan"},
    {"id": 2, "tabName": "Bulanan"},
    {"id": 3, "tabName": "Tahunan"}
  ];

  int tabIndex = 1;
  String filterBy = 'Mingguan';
  String showFilter = 'Mingguan';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
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
                      setState(
                        () {
                          tabIndex = e['id'];
                          showFilter = e['tabName'];

                          if (e['tabName'] == 'Mingguan') {
                            filterBy = 'week';
                          } else if (e['tabName'] == 'Bulanan') {
                            filterBy = 'month';
                          } else if (e['tabName'] == 'Tahunan') {
                            filterBy = 'year';
                          }
                        },
                      );
                      widget.onTabChanged(tabIndex, filterBy);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 32.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: tabIndex == e['id']
                            ? ColorStyle.primary
                            : ColorStyle.white,
                        border: Border.all(
                          color: ColorStyle.primary,
                        ),
                      ),
                      child: Text(
                        e['tabName'],
                        style: whiteTextStyle.copyWith(
                          fontSize: 10.sp,
                          fontWeight: semiBold,
                          color: tabIndex == e['id']
                              ? ColorStyle.white
                              : ColorStyle.primary,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          widget.showPercentage == true ? 20.verticalSpace : 0.verticalSpace,
          widget.showPercentage == true
              ? Text(
                  'Total Akumulasi',
                  style: blackTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14.sp,
                  ),
                )
              : Container(),
          widget.showPercentage == true
              ? Text(
                  showFilter,
                  style: greyTextStyle.copyWith(
                    fontSize: 12.sp,
                    fontWeight: medium,
                    color: ColorStyle.grey2,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
