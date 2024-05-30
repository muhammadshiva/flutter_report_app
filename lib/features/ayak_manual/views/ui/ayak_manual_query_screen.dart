import 'package:flutter/material.dart';
import 'package:flutter_report_app/shared/widgets/button/dropdown_button_form_field_custom.dart';
import 'package:flutter_report_app/shared/widgets/general/app_bar_widget_custom.dart';
import 'package:flutter_report_app/shared/widgets/text_field/text_field_date_widget_custom.dart';
import 'package:flutter_report_app/shared/widgets/text_field/text_field_label_widget_custom.dart';
import 'package:flutter_report_app/shared/widgets/text_field/text_field_note_widget_custom.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AyakManualQueryScreen extends StatelessWidget {
  const AyakManualQueryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    TextEditingController tanggalController = TextEditingController();
    TextEditingController batokController = TextEditingController();
    TextEditingController keteranganController = TextEditingController();

    return Scaffold(
      appBar: const AppBarWidgetCustom(
        title: 'Input Ayak Manual',
        actions: [],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 25.w,
          vertical: 30.h,
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldDateWidgetCustom(
                controller: tanggalController,
                errorText: 'Test Error'.obs,
              ),
              DropDownFormFieldCustom(
                errorText: 'Test Error'.obs,
              ),
              TextFieldLabelWidgetCustom(
                title: 'Batok',
                controller: batokController,
                errorText: 'Test Error'.obs,
              ),
              TextFieldNoteWidgetCustom(
                controller: keteranganController,
                errorText: 'Test Error'.obs,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
