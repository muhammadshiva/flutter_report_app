import 'package:bas_app/features/home/controller/home_controller.dart';
import 'package:bas_app/shared/styles/color_style.dart';
import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAdminUserWidget extends StatelessWidget {
  const HomeAdminUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = HomeController.to;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'List Akses',
            style: blackTextStyle.copyWith(
              fontSize: 15.sp,
              fontWeight: semiBold,
            ),
          ),
          20.verticalSpace,
          cardMenu(
            title: 'Kepala Produksi',
            subtitle: 'Password: *****',
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
        print('Selected Admin Menu : ${controller.selectedAdminMenu.value}');
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
              decoration: const BoxDecoration(
                color: Color(0xffE7EDFF),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                color: ColorStyle.primary,
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
                      color: ColorStyle.primary),
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
            // PopupMenuButton untuk Edit dan Delete
            PopupMenuButton<int>(
              color: ColorStyle.white,
              onSelected: (value) {
                if (value == 1) {
                  // Implement Edit action here
                } else if (value == 2) {
                  // Implement Delete action here
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      const Icon(Icons.edit, color: Colors.grey),
                      10.horizontalSpace,
                      Text(
                        'Edit',
                        style: blackTextStyle.copyWith(
                          fontSize: 11.sp,
                          fontWeight: semiBold,
                          color: ColorStyle.grey2,
                        ),
                      ),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: [
                      const Icon(Icons.delete, color: Colors.grey),
                      10.horizontalSpace,
                      Text(
                        'Delete',
                        style: blackTextStyle.copyWith(
                          fontSize: 11.sp,
                          fontWeight: semiBold,
                          color: ColorStyle.grey2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              icon: const Icon(Icons.more_horiz),
            ),
          ],
        ),
      ),
    );
  }
}
