import 'package:bas_app/constants/global_asset_constant.dart';
import 'package:bas_app/features/home/controller/home_controller.dart';
import 'package:bas_app/features/home/view/components/home_data_list_widget.dart';
import 'package:bas_app/features/home/view/components/home_tab_widget.dart';
import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:bas_app/utils/services/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:restart_app/restart_app.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = HomeController.to;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 20.w,
                child: Image.asset(
                  GlobalAssetConstant.imgLogoBas,
                ),
              ),
              const Spacer(),
              Text(
                'Proses Produksi',
                style: blackTextStyle.copyWith(
                  fontSize: 17.sp,
                  fontWeight: semiBold,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              PanaraConfirmDialog.show(
                context,
                title: 'Logout',
                noImage: true,
                message: "Apakah anda ingin logout ? ",
                confirmButtonText: 'Ya',
                cancelButtonText: 'Tidak',
                onTapConfirm: () {
                  controller.logout();
                },
                onTapCancel: () {
                  Get.back();
                },
                color: Colors.red,
                panaraDialogType: PanaraDialogType.custom,
              );
            },
            child: Container(
              height: 30.w,
              margin: EdgeInsets.only(right: 12.w),
              child: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: const [
          HomeTabWidget(),
          HomeDataListWidget(),
        ],
      ),
    );
  }
}
