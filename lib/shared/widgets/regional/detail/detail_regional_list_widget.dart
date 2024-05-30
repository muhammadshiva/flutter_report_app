import 'package:flutter/material.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_report_app/shared/widgets/regional/detail/detail_regional_card_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailRegionalListWidget extends StatelessWidget {
  const DetailRegionalListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.only(top: 15.h),
          height: MediaQuery.sizeOf(context).height * 0.85,
          child: RefreshIndicator(
            onRefresh: () async {
              // controller.getBahanBaku();
            },
            child: Scrollbar(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: 2,
                itemBuilder: (context, index) {
                  // String date = dates[index];
                  // List<ListBahanBaku> items = groupedData[date]!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '29 Mei 2024',
                        style: blackTextStyle.copyWith(
                          color: ColorStyle.black2,
                          fontWeight: semiBold,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 10.w),
                      DetailRegionalCardWidget(),
                      // ...items
                      //     .map(
                      //       (data) => DetailRegionalCardWidget(
                      //         controller: controller,
                      //         data: data,
                      //       ),
                      //     )
                      //     .toList(),
                      SizedBox(height: 10.w),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
