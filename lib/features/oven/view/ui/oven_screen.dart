import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/oven/argument/oven_argument.dart';
import 'package:bas_app/features/oven/controllers/oven_controller.dart';
import 'package:bas_app/shared/styles/color_style.dart';
import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:bas_app/shared/widgets/custom_button/button_floating_widget.dart';
import 'package:bas_app/shared/widgets/custom_widget/card_widget.dart';
import 'package:bas_app/shared/widgets/custom_widget/list_widget.dart';
import 'package:bas_app/shared/widgets/custom_widget/persentase_widget.dart';
import 'package:bas_app/shared/widgets/custom_widget/tab_widget.dart';
import 'package:bas_app/shared/widgets/general/app_bar_custom.dart';
import 'package:bas_app/shared/widgets/general/main_dropdown_widget.dart';
import 'package:bas_app/shared/widgets/general/shimmer_list_widget.dart';
import 'package:bas_app/shared/widgets/general/shimmer_persentase_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class OvenScreen extends StatelessWidget {
  const OvenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = OvenController.to;

    return Scaffold(
      appBar: const AppBarCustom(title: 'Oven'),
      body: ListView(
        children: [
          //* TAB
          TabWidget(
            onTabChanged: (index, value) {
              controller.getOven(filter: value);
            },
          ),

          //* PERSENTASE
          Obx(
            () => controller.isLoading.isFalse
                ? PersentaseWidget(
                    data: controller.ovenData.listPersentase ?? [],
                  )
                : const ShimmerPersentaseWidget(),
          ),

          //* FILTER
          Obx(
            () => controller.dropdownSumberBatok.isNotEmpty
                ? MainDropdownFilter(
                    onChanged: (value) {
                      if (value != 'Semua') {
                        controller.getOven(filter: value);
                      } else {
                        controller.getOven();
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
                if (controller.ovenData.listOven == null ||
                    controller.ovenData.listOven!.isEmpty) {
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
                    onRefresh: () => controller.getOven(),
                    itemCount: controller.totalData,
                    itemBuilder: (value, index) {
                      var data = controller.ovenData.listOven![index];

                      //* CARD DATA
                      return CardWidget(
                        title: data.sumberBatok ?? '',
                        jenisMasukan: data.jenisMasukan ?? '',
                        terakhirDitambahkan: data.tanggal ?? '',
                        data: data.listData ?? [],
                        onPressedEdit: (value) {
                          Get.toNamed(
                            AppRoute.ovenQueryRoute,
                            arguments: OvenArgument(
                              isEdit: true,
                              ovenData: controller.ovenData,
                              listOven: data,
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
                              controller.deleteOven(idOven: data.id ?? 0);
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
                    AppRoute.ovenQueryRoute,
                    arguments: OvenArgument(
                      isEdit: false,
                      ovenData: controller.ovenData,
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
