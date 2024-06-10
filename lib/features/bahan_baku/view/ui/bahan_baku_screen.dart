import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/features/bahan_baku/argument/bahan_baku_argument.dart';
import 'package:bas_app/features/bahan_baku/controllers/bahan_baku_controller.dart';
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

class BahanBakuScreen extends StatelessWidget {
  const BahanBakuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = BahanBakuController.to;

    return Scaffold(
      appBar: const AppBarCustom(title: 'Bahan Baku'),
      body: ListView(
        children: [
          //* TAB
          TabWidget(
            onTabChanged: (index, value) {
              controller.getBahanBaku(filter: value);
            },
          ),

          //* PERSENTASE
          Obx(
            () => controller.isLoading.isFalse
                ? PersentaseWidget(
                    data: controller.bahanBakuData.listPersentase ?? [],
                  )
                : const ShimmerPersentaseWidget(),
          ),

          //* FILTER
          Obx(
            () => controller.dropdownBahanBaku.isNotEmpty
                ? MainDropdownFilter(
                    onChanged: (value) {
                      if (value != 'Semua') {
                        controller.getBahanBaku(filter: value);
                      } else {
                        controller.getBahanBaku();
                      }
                    },
                    items: controller.dropdownBahanBaku,
                    dataLength: controller.bahanBakuData.totalData ?? 0,
                  )
                : const SizedBox(),
          ),

          //* LIST DATA
          Obx(
            () {
              if (controller.isLoading.isFalse) {
                if (controller.bahanBakuData.listBahanBaku == null ||
                    controller.bahanBakuData.listBahanBaku!.isEmpty) {
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
                    onRefresh: () => controller.getBahanBaku(),
                    itemCount: controller.bahanBakuData.listBahanBaku?.length ?? 0,
                    itemBuilder: (value, index) {
                      var data = controller.bahanBakuData.listBahanBaku![index];

                      //* CARD DATA
                      return CardWidget(
                        title: data.bahanBaku ?? '',
                        jenisMasukan: data.jenisMasukan ?? '',
                        terakhirDitambahkan: data.tanggal ?? '',
                        data: data.listData ?? [],
                        onPressedEdit: (value) {
                          Get.toNamed(
                            AppRoute.bahanBakuQueryRoute,
                            arguments: BahanBakuArgument(
                              isEdit: true,
                              bahanBakuData: controller.bahanBakuData,
                              listBahanBaku: data,
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
                              controller.deleteBahanBaku(idBahanBaku: data.id ?? 0);
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
                    AppRoute.bahanBakuQueryRoute,
                    arguments: BahanBakuArgument(
                      isEdit: false,
                      bahanBakuData: controller.bahanBakuData,
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
