import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/ayak_manual/argument/ayak_manual_argument.dart';
import 'package:bas_app/features/ayak_manual/controllers/ayak_manual_controller.dart';
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

class AyakManualScreen extends StatelessWidget {
  const AyakManualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = AyakManualController.to;

    return Scaffold(
      appBar: const AppBarCustom(title: 'Ayak Manual'),
      body: ListView(
        children: [
          //* TAB
          TabWidget(
            onTabChanged: (index, value) {
              controller.getAyakManual(filter: value);
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
                        controller.getAyakManual(filter: value);
                      } else {
                        controller.getAyakManual();
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
                if (controller.ayakManualData.listAyakManual == null ||
                    controller.ayakManualData.listAyakManual!.isEmpty) {
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
                    onRefresh: () => controller.getAyakManual(),
                    itemCount: controller.totalData,
                    itemBuilder: (value, index) {
                      var data =
                          controller.ayakManualData.listAyakManual![index];

                      //* CARD DATA
                      return CardWidget(
                        title: data.sumberBatok ?? '',
                        terakhirDitambahkan: data.tanggal ?? '',
                        data: data.listData ?? [],
                        onPressedEdit: (value) {
                          Get.toNamed(
                            AppRoute.ayakManualQueryRoute,
                            arguments: AyakManualArgument(
                              isEdit: true,
                              ayakManualData: controller.ayakManualData,
                              listAyakManual: data,
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
                              controller.deleteAyakManual(
                                  idAyakManual: data.id ?? 0);
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
                    AppRoute.ayakManualQueryRoute,
                    arguments: AyakManualArgument(
                      isEdit: false,
                      ayakManualData: controller.ayakManualData,
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
