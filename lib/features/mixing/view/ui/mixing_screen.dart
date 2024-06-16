import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/mixing/argument/mixing_argument.dart';
import 'package:bas_app/features/mixing/controllers/mixing_controller.dart';
import 'package:bas_app/shared/styles/color_style.dart';
import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:bas_app/shared/widgets/custom_button/button_floating_widget.dart';
import 'package:bas_app/shared/widgets/custom_widget/card_widget.dart';
import 'package:bas_app/shared/widgets/custom_widget/list_widget.dart';
import 'package:bas_app/shared/widgets/custom_widget/tab_widget.dart';
import 'package:bas_app/shared/widgets/general/app_bar_custom.dart';
import 'package:bas_app/shared/widgets/general/main_dropdown_widget.dart';
import 'package:bas_app/shared/widgets/general/shimmer_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class MixingScreen extends StatelessWidget {
  const MixingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = MixingController.to;

    return Scaffold(
      appBar: const AppBarCustom(title: 'Mixing'),
      body: ListView(
        children: [
          //* TAB
          TabWidget(
            onTabChanged: (index, value) {
              controller.getMixing(filter: value);
            },
          ),

          const Divider(
            thickness: 5,
            color: ColorStyle.grey,
          ),

          //* FILTER
          Obx(
            () => controller.dropdownSumberBatok.isNotEmpty
                ? MainDropdownFilter(
                    onChanged: (value) {
                      if (value != 'Semua') {
                        controller.getMixing(filter: value);
                      } else {
                        controller.getMixing();
                      }
                    },
                    items: controller.dropdownSumberBatok,
                    dataLength: controller.totalData,
                  )
                : const SizedBox(),
          ),

          //* LIST DATA
          Obx(
            () {
              if (controller.isLoading.isFalse) {
                if (controller.mixingData.listMixing == null ||
                    controller.mixingData.listMixing!.isEmpty) {
                  return Container(
                    margin: EdgeInsets.only(top: 0.25.sh),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Data kosong',
                          style: blackTextStyle.copyWith(
                            fontWeight: semiBold,
                            fontSize: 14.sp,
                            color: ColorStyle.black2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                } else {
                  return ListWidget(
                    onRefresh: () => controller.getMixing(),
                    itemCount: controller.totalData,
                    itemBuilder: (value, index) {
                      var data = controller.mixingData.listMixing![index];

                      //* CARD DATA
                      return CardWidget(
                        title: data.sumberBatok ?? '',
                        terakhirDitambahkan: data.tanggal ?? '',
                        data: data.listData ?? [],
                        ukuranPisau: data.ukuranPisau.toString(),
                        onPressedEdit: (value) {
                          Get.toNamed(
                            AppRoute.mixingQueryRoute,
                            arguments: MixingArgument(
                              isEdit: true,
                              mixingData: controller.mixingData,
                              listMixing: data,
                            ),
                          );
                        },
                        onPressedDelete: (value) {
                          PanaraConfirmDialog.show(
                            context,
                            title: 'Hapus',
                            message:
                                'Apakah anda yakin ingin menghapus data ini ?',
                            confirmButtonText: 'Hapus',
                            cancelButtonText: 'Tidak',
                            onTapConfirm: () {
                              Get.back();
                              controller.deleteDiskmill(idMixing: data.id ?? 0);
                            },
                            onTapCancel: () => Get.back(),
                            panaraDialogType: PanaraDialogType.error,
                          );
                        },
                      );
                    },
                  );
                }
              } else {
                return const ShimmerListWidget();
              }
            },
          ),
        ],
      ),
      floatingActionButton: Obx(
        () => controller.isLoading.isTrue
            ? const SizedBox()
            : ButtonFloatingWidget(
                onPressedInputData: () {
                  Get.toNamed(
                    AppRoute.mixingQueryRoute,
                    arguments: MixingArgument(
                      isEdit: false,
                      mixingData: controller.mixingData,
                    ),
                  );
                },
                onPressedExportData: () {
                  controller.exportFile();
                },
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
