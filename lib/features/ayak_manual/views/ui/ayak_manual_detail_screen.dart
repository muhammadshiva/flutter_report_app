import 'package:flutter/material.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_report_app/shared/styles/google_text_style.dart';
import 'package:flutter_report_app/shared/widgets/general/app_bar_widget_custom.dart';
import 'package:flutter_report_app/shared/widgets/regional/detail/detail_regional_list_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AyakManualDetailScreen extends StatelessWidget {
  const AyakManualDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgetCustom(
        title: 'Data Wilayah',
        actions: [],
      ),
      body: DetailRegionalListWidget(),
    );
  }
}
