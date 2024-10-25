import 'package:bas_app/constants/global_asset_constant.dart';
import 'package:bas_app/features/home/controller/home_controller.dart';
import 'package:bas_app/features/home/view/components/home_admin_data_widget.dart';
import 'package:bas_app/features/home/view/components/home_admin_user_widget.dart';
import 'package:bas_app/features/home/view/components/home_data_list_widget.dart';
import 'package:bas_app/features/home/view/components/home_tab_widget.dart';
import 'package:bas_app/shared/styles/color_style.dart';
import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:bas_app/utils/services/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = HomeController.to;
    var role = HiveService.box.get('position');

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,

          //* BACKUP
          title: Text(
            'Management Data',
            style: blackTextStyle.copyWith(
              fontSize: 17.sp,
              fontWeight: semiBold,
            ),
          ),
          leading: role == 'Admin'
              ? GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(Icons.arrow_back_ios),
                )
              : Container()

          //* BACKUP
          // actions: [
          //   InkWell(
          //     onTap: () {
          //       PanaraConfirmDialog.show(
          //         context,
          //         title: 'Logout',
          //         noImage: true,
          //         message: "Apakah anda ingin logout ? ",
          //         confirmButtonText: 'Ya',
          //         cancelButtonText: 'Tidak',
          //         onTapConfirm: () {
          //           controller.logout();
          //         },
          //         onTapCancel: () {
          //           Get.back();
          //         },
          //         color: Colors.red,
          //         panaraDialogType: PanaraDialogType.custom,
          //       );
          //     },
          //     child: Container(
          //       height: 30.w,
          //       margin: EdgeInsets.only(right: 12.w),
          //       child: const Icon(
          //         Icons.logout,
          //         color: Colors.red,
          //       ),
          //     ),
          //   ),
          // ],
          ),
      body: ListView(
        children: const [
          HomeTabWidget(),
          HomeDataListWidget(),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          controller.logout();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorStyle.r5,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.logout,
              color: ColorStyle.white,
            ),
            5.horizontalSpace,
            Text(
              'Logout',
              style: blackTextStyle.copyWith(
                color: ColorStyle.white,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
