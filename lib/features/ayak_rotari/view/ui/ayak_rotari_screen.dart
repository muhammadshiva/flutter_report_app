import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/ayak_rotari/argument/ayak_rotari_argument.dart';
import 'package:bas_app/features/ayak_rotari/controllers/ayak_rotari_controller.dart';
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

class AyakRotariScreen extends StatelessWidget {
  const AyakRotariScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = AyakRotariController.to;

    return Scaffold(
      appBar: const AppBarCustom(title: 'Ayak Rotari'),
      body: ListView(
        children: [
          //* TAB
          TabWidget(
            onTabChanged: (index, value) {
              controller.getAyakRotari(filter: value);
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
                        controller.getAyakRotari(filter: value);
                      } else {
                        controller.getAyakRotari();
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
                if (controller.ayakRotariData.listAyakRotari == null ||
                    controller.ayakRotariData.listAyakRotari!.isEmpty) {
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
                    onRefresh: () => controller.getAyakRotari(),
                    itemCount: controller.totalData,
                    itemBuilder: (value, index) {
                      var data =
                          controller.ayakRotariData.listAyakRotari![index];

                      //* CARD DATA
                      return CardWidget(
                        title: data.sumberBatok ?? '',
                        terakhirDitambahkan: data.tanggal ?? '',
                        data: data.listData ?? [],
                        onPressedEdit: (value) {
                          Get.toNamed(
                            AppRoute.ayakRotariQueryRoute,
                            arguments: AyakRotariArgument(
                              isEdit: true,
                              ayakRotariData: controller.ayakRotariData,
                              listAyakRotari: data,
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
                              controller.deleteAyakRotari(
                                  idAyakRotari: data.id ?? 0);
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
                    AppRoute.ayakRotariQueryRoute,
                    arguments: AyakRotariArgument(
                      isEdit: false,
                      ayakRotariData: controller.ayakRotariData,
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
