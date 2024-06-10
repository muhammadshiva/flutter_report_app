import 'package:bas_app/configs/routes/app_route.dart';
import 'package:bas_app/constants/global_asset_constant.dart';
import 'package:bas_app/features/home/repositories/home_repository.dart';
import 'package:bas_app/utils/services/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  var tabIndex = 1.obs;

  List<Map<String, dynamic>> tabData = [
    {"id": 1, "tabName": "Pra-Produksi"},
    {"id": 2, "tabName": "Produksi"},
    {"id": 3, "tabName": "Pasca-Produksi"}
  ];

  List<Map<String, dynamic>> productionData = [
    {
      "id": 1,
      "title": "Keluar / Masuk Batok",
      "image": const AssetImage(GlobalAssetConstant.imgBatokKelapa),
      "persentase": [
        {"title": "Barang Keluar & Masuk", "subtitle": 65},
        {"title": "Stok Awal & Akhir", "subtitle": 40},
      ]
    },
    {
      "id": 2,
      "title": "Keluar / Masuk Bahan Baku",
      "image": const AssetImage(GlobalAssetConstant.imgBahanBaku),
      "persentase": [
        {"title": "Stok Aci", "subtitle": 65},
        {"title": "Stok Arang", "subtitle": 40},
        {"title": "Stok Cairan", "subtitle": 40},
      ]
    },
    {
      "id": 3,
      "title": "Ayak Manual",
      "image": const AssetImage(GlobalAssetConstant.imgAyakManual),
      "persentase": [
        {"title": "Batok", "subtitle": 65},
        {"title": "Batok Mentah", "subtitle": 40},
        {"title": "Granul", "subtitle": 40},
      ]
    },
    {
      "id": 4,
      "title": "Ayak Rotari",
      "image": const AssetImage(GlobalAssetConstant.imgAyakRotari),
      "persentase": [
        {"title": "Batok", "subtitle": 65},
        {"title": "Abu", "subtitle": 40},
      ]
    },
    {
      "id": 5,
      "title": "Proses Diskmill",
      "image": const AssetImage(GlobalAssetConstant.imgDiskmill),
      "persentase": [
        {"title": "Pisau 0.2", "subtitle": 65},
        {"title": "Pisau 0.3", "subtitle": 40},
      ]
    },
    {
      "id": 6,
      "title": "Proses Mixing",
      "image": const AssetImage(GlobalAssetConstant.imgDiskmill),
      "persentase": [
        {"title": "Aci", "subtitle": 65},
        {"title": "Arang", "subtitle": 40},
        {"title": "Cairan", "subtitle": 40},
      ]
    },
    {
      "id": 7,
      "title": "Proses Sortir",
      "image": const AssetImage(GlobalAssetConstant.imgSortir),
      "persentase": [
        {"title": "Barang Keluar & Masuk", "subtitle": 65},
        {"title": "Stok Awal & Akhir", "subtitle": 40},
      ]
    },
    {
      "id": 8,
      "title": "Proses Pengovenan",
      "image": const AssetImage(GlobalAssetConstant.imgSortir),
      "persentase": [
        {"title": "Pengovenan", "subtitle": 65},
        {"title": "Pendinginan", "subtitle": 40},
      ]
    },
    {
      "id": 9,
      "title": "Stok Briket",
      "image": const AssetImage(GlobalAssetConstant.imgStokBriket),
      "persentase": [
        {"title": "Stok Briket", "subtitle": 65},
      ]
    },
  ];

  void logout() async {
    HomeRepository.logout();
    await HiveService.deleteAuth();
    Get.offAllNamed(AppRoute.signInRoute);
  }
}
