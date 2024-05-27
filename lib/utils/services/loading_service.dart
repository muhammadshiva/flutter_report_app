import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_report_app/shared/styles/color_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoadingService {
  LoadingService._();

  static Future<void> show({bool dismissOnTap = false}) async {
    await Get.dialog(
      LoadingServiceDialogWidget(dismissOnTap: dismissOnTap),
      transitionDuration: const Duration(milliseconds: 100),
      barrierDismissible: dismissOnTap,
      useSafeArea: true,
    );
  }

  static void dismiss() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}

class LoadingServiceDialogWidget extends StatefulWidget {
  const LoadingServiceDialogWidget({
    super.key,
    required this.dismissOnTap,
  });

  final bool dismissOnTap;

  @override
  State<LoadingServiceDialogWidget> createState() => _LoadingServiceDialogWidgetState();
}

class _LoadingServiceDialogWidgetState extends State<LoadingServiceDialogWidget> {
  int loadingTime = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    // Start the timer
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        loadingTime = t.tick;
      });

      // Check if the loading time has exceeded 30 seconds and dismiss the dialog
      if (loadingTime >= 30) {
        timer.cancel();
        Get.back();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => widget.dismissOnTap,
      child: Center(
        child: Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: const Center(
            child: CircularProgressIndicator(
              color: ColorStyle.primary,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
