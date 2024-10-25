import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DialogService {
  static Future<dynamic> showGeneralDrawer({
    bool isDismissable = true,
    double radius = 12,
    bool withStrip = true,
    Color? color,
    Widget? content,
    EdgeInsets padding =
        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  }) async {
    await Get.bottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        ),
      ),
      SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              topRight: Radius.circular(radius),
            ),
          ),
          padding: padding,
          child: Column(
            children: [
              Container(
                width: 65.w,
                height: 5.h,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(2.5)),
                    color: withStrip ? Colors.grey : Colors.transparent),
              ),
              SizedBox(
                height: 24.h,
              ),
              content ?? const SizedBox(),
            ],
          ),
        ),
      ),
      // context: Get.context!,
      isDismissible: isDismissable,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      // builder: (context) {
      //   return
      // },
    );
  }
}
