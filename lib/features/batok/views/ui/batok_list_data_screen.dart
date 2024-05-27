import 'package:flutter/material.dart';
import 'package:flutter_report_app/features/batok/controllers/batok_controller.dart';
import 'package:flutter_report_app/features/batok/models/batok_model.dart';
import 'package:flutter_report_app/features/batok/views/components/batok_data_item_widget.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BatokListDataScreen extends StatelessWidget {
  const BatokListDataScreen({super.key, required this.batokData});

  final BatokData batokData;

  @override
  Widget build(BuildContext context) {
    var controller = BatokController.to;

    // / Group the data by date
    Map<String, List<ListBatok>> groupedData = {};
    for (var data in batokData.listBatok!) {
      String date = controller.formatDate(date: data.tanggal ?? '');
      if (!groupedData.containsKey(date)) {
        groupedData[date] = [];
      }
      groupedData[date]!.add(data);
    }

    // Convert the map to a list of keys (dates) for iteration
    List<String> dates = groupedData.keys.toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Data Batok ${batokData.sumberBatok}',
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
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15.h),
            height: MediaQuery.sizeOf(context).height * 0.85,
            child: RefreshIndicator(
              onRefresh: () async {},
              child: Scrollbar(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: dates.length,
                  itemBuilder: (context, index) {
                    String date = dates[index];
                    List<ListBatok> items = groupedData[date]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          date,
                          style: blackTextStyle.copyWith(
                            color: ColorStyle.black2,
                            fontWeight: semiBold,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 10.w),
                        ...items
                            .map(
                              (data) => BatokDataItem(
                                controller: controller,
                                data: data,
                              ),
                            )
                            .toList(),
                        SizedBox(height: 10.w),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
