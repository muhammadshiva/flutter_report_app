import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/batok/argument/batok_argument.dart';
import 'package:bas_app/features/batok/controllers/batok_controller.dart';
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

class BatokScreen extends StatelessWidget {
  const BatokScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = BatokController.to;

    return Scaffold(
      appBar: const AppBarCustom(title: 'Batok'),
      body: ListView(
        children: [
          //* TAB
          TabWidget(
            onTabChanged: (index, value) {
              controller.getBatok(filter: value);
            },
          ),

          //* PERSENTASE
          Obx(
            () => controller.isLoading.isFalse
                ? PersentaseWidget(
                    data: controller.batokData.listPersentase ?? [],
                  )
                : const ShimmerPersentaseWidget(),
          ),

          //* FILTER
          Obx(
            () => controller.dropdownSumberBatok.isNotEmpty
                ? MainDropdownFilter(
                    onChanged: (value) {
                      if (value != 'Semua') {
                        controller.getBatok(filter: value);
                      } else {
                        controller.getBatok();
                      }
                    },
                    items: controller.dropdownSumberBatok,
                    dataLength: controller.batokData.totalData ?? 0,
                  )
                : const SizedBox(),
          ),

          //* LIST DATA
          Obx(
            () {
              if (controller.isLoading.isFalse) {
                if (controller.batokData.listBatok == null ||
                    controller.batokData.listBatok!.isEmpty) {
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
                    onRefresh: () => controller.getBatok(),
                    itemCount: controller.batokData.listBatok?.length ?? 0,
                    itemBuilder: (value, index) {
                      var data = controller.batokData.listBatok![index];

                      //* CARD DATA
                      return CardWidget(
                        title: data.sumberBatok ?? '',
                        jenisMasukan: data.jenisMasukan ?? '',
                        data: data.listData ?? [],
                        onPressedEdit: (value) {
                          Get.toNamed(
                            AppRoute.batokQueryRoute,
                            arguments: BatokArgument(
                              isEdit: true,
                              batokData: controller.batokData,
                              listBatokData: data,
                            ),
                          );
                        },
                        onPressedDelete: (value) {
                          PanaraConfirmDialog.show(
                            context,
                            title: 'Hapus',
                            message: 'Apakah anda yakin ingin menghapus data ini ?',
                            confirmButtonText: 'Hapus',
                            cancelButtonText: 'Tidak',
                            onTapConfirm: () {
                              Get.back();
                              controller.deleteBatok(idBatok: data.id ?? 0);
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
          )
        ],
      ),
      floatingActionButton: Obx(
        () => controller.isLoading.isTrue
            ? const SizedBox()
            : ButtonFloatingWidget(
                onPressedInputData: () {
                  Get.toNamed(
                    AppRoute.batokQueryRoute,
                    arguments: BatokArgument(
                      isEdit: false,
                      batokData: controller.batokData,
                    ),
                  );
                },
                onPressedExportData: () {},
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
