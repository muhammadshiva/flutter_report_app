import 'package:flutter/material.dart';
import 'package:flutter_report_app/features/bahan_baku/controllers/bahan_baku_controller.dart';
import 'package:flutter_report_app/features/bahan_baku/models/bahan_baku_model.dart';
import 'package:flutter_report_app/features/bahan_baku/views/components/bahan_baku_data_item_widget.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BahanBakuListDataScreen extends StatelessWidget {
  const BahanBakuListDataScreen({super.key, required this.bahanBakuData});

  final BahanBakuData bahanBakuData;

  @override
  Widget build(BuildContext context) {
    var controller = BahanBakuController.to;

    // / Group the data by date
    Map<String, List<ListBahanBaku>> groupedData = {};
    for (var data in bahanBakuData.listBahanBaku!) {
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
          'Data Bahan Baku',
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
              onRefresh: () async {
                controller.getBahanBaku();
              },
              child: Scrollbar(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: dates.length,
                  itemBuilder: (context, index) {
                    String date = dates[index];
                    List<ListBahanBaku> items = groupedData[date]!;

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
                              (data) => BahanBakuDataItem(
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
