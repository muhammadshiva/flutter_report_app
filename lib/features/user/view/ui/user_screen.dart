import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/user/controllers/user_controller.dart';
import 'package:bas_app/features/user/models/user_fetch_model.dart';
import 'package:bas_app/features/user_query/argument/user_query_argument.dart';
import 'package:bas_app/shared/styles/color_style.dart';
import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = UserController.to;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Management Pengguna',
          style: blackTextStyle.copyWith(
            fontSize: 17.sp,
            fontWeight: semiBold,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios, size: 18.w),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.w),
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
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.74,
              child: Obx(
                () => RefreshIndicator(
                  onRefresh: () async {
                    await controller.getAllUser();
                  },
                  child: ListView.builder(
                    itemCount: controller.userDataList.length,
                    itemBuilder: (context, index) {
                      var data = controller.userDataList[index];

                      return cardMenu(
                        title: data.name ?? '-',
                        subtitle: data.position ?? '-',
                        userData: data,
                        controller: controller,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Get.toNamed(
            AppRoute.userQueryRoute,
            arguments: UserQueryArgument(isEdit: false),
          );
          controller.isEdit.value = false;
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorStyle.primary,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add, color: ColorStyle.white),
            Text(
              'Tambah Pengguna',
              style: blackTextStyle.copyWith(
                color: ColorStyle.white,
                fontWeight: semiBold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardMenu({
    required String title,
    required String subtitle,
    required UserData userData,
    required UserController controller,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      margin: EdgeInsets.only(bottom: 15.w, left: 2.w, right: 2.w),
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
                Get.toNamed(
                  AppRoute.userQueryRoute,
                  arguments: UserQueryArgument(
                    isEdit: true,
                    userData: userData,
                  ),
                );
                controller.isEdit.value = true;
              } else if (value == 2) {
                controller.deleteUser(id: userData.id ?? 0);
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
                    const Icon(Icons.delete, color: ColorStyle.r4),
                    10.horizontalSpace,
                    Text(
                      'Delete',
                      style: blackTextStyle.copyWith(
                        fontSize: 11.sp,
                        fontWeight: semiBold,
                        color: ColorStyle.r4,
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
    );
  }
}
