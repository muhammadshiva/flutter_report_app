import 'package:flutter/material.dart';
import 'package:flutter_report_app/configs/routes/route.dart';
import 'package:flutter_report_app/features/ayak_manual/controllers/ayak_maual_controller.dart';
import 'package:flutter_report_app/shared/widgets/general/app_bar_widget_custom.dart';
import 'package:flutter_report_app/shared/widgets/regional/main/main_regional_card_widget.dart';
import 'package:flutter_report_app/shared/widgets/regional/main/main_regional_list_widget.dart';
import 'package:flutter_report_app/shared/widgets/regional/main/main_regional_persentase_widget.dart';
import 'package:flutter_report_app/shared/widgets/regional/main/main_regional_tab_widget.dart';
import 'package:get/get.dart';

class AyakManualScreen extends StatelessWidget {
  const AyakManualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = AyakManualController.to;

    return Scaffold(
      appBar: const AppBarWidgetCustom(
        title: 'Ayak Manual',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainRegionalTabWidget(
              onTabChanged: (tabIndex, filterBy) {
                controller.tabIndex.value = tabIndex;
                controller.filterBy.value = filterBy;
              },
            ),
            MainRegionalPersentaseWidget(
              filterBy: controller.filterBy,
            ),
            MainRegionalListWidget(
              isLoading: false.obs,
              itemCount: 10,
              itemBuilder: (context, index) {
                return MainRegionalCardWidget(
                  onTap: () {
                    Get.toNamed(Routes.ayakManualDetailRoute);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
