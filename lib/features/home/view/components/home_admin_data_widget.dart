import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/home/controller/home_controller.dart';
import 'package:bas_app/shared/styles/color_style.dart';
import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeAdminDataWidget extends StatelessWidget {
  const HomeAdminDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = HomeController.to;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Management Data',
            style: blackTextStyle.copyWith(
              fontSize: 15.sp,
              fontWeight: semiBold,
            ),
          ),
          20.verticalSpace,
          cardMenu(
            title: 'Management Data',
            subtitle: 'Atur dengan hapus atau edit data',
            controller: controller,
          ),
          cardMenu(
            title: 'Management Pengguna',
            subtitle: 'Atur dengan hapus atau edit data',
            controller: controller,
          ),
        ],
      ),
    );
  }

  Widget cardMenu({
    required String title,
    required String subtitle,
    required HomeController controller,
  }) {
    return GestureDetector(
      onTap: () {
        controller.selectedAdminMenu.value = title;

        if (controller.selectedAdminMenu.value == 'Management Pengguna') {
          Get.toNamed(AppRoute.userRoute);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.w),
        margin: EdgeInsets.only(bottom: 15.w),
        decoration: BoxDecoration(
          color: ColorStyle.white,
          borderRadius: BorderRadius.circular(5.r),
          boxShadow: [
            BoxShadow(
              color: ColorStyle.black.withOpacity(0.12),
              offset: const Offset(4, 4),
              blurRadius: 18,
              spreadRadius: -2,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 45.w,
              width: 45.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.r),
                color: title == 'Management Data'
                    ? const Color(0xffE7EDFF)
                    : const Color(0xffFFF5D9),
              ),
              child: Icon(
                title == 'Management Data' ? Icons.storage : Icons.person,
                color: title == 'Management Data'
                    ? ColorStyle.primary
                    : const Color(0xffFFBB38),
                size: 27.w,
              ),
            ),
            15.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: blackTextStyle.copyWith(
                    fontSize: 13.sp,
                    fontWeight: semiBold,
                    color: title == 'Management Data'
                        ? ColorStyle.primary
                        : const Color(0xffFFBB38),
                  ),
                ),
                4.verticalSpace,
                Text(
                  subtitle,
                  style: blackTextStyle.copyWith(
                    fontSize: 11.sp,
                    fontWeight: medium,
                    color: ColorStyle.grey2,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: ColorStyle.grey2,
              size: 17.w,
            ),
          ],
        ),
      ),
    );
  }
}
