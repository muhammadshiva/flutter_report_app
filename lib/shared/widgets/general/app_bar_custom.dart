import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Function()? onBack;

  const AppBarCustom({
    Key? key,
    required this.title,
    this.actions,
    this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      centerTitle: true,
      title: Text(
        title,
        style: blackTextStyle.copyWith(
          fontSize: 17.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: InkWell(
        onTap: onBack ?? () => Get.back(),
        child: const Icon(
          Icons.arrow_back,
        ),
      ),
      actions: actions ?? [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
