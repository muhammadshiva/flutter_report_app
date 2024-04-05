import 'package:flutter/material.dart';
import 'package:flutter_report_app/constants/global_asset_constant.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  var tabIndex = 1.obs;

  List<Map<String, dynamic>> tabData = [
    {"id": 1, "tabName": "Pra-Produksi"},
    {"id": 2, "tabName": "Produksi"},
    {"id": 3, "tabName": "Pasca-Produksi"}
  ];

  List<Map<String, dynamic>> praProduksiData = [
    {
      "id": 1,
      "title": "Keluar / Masuk Batok",
      "image": const AssetImage(GlobalAssetConstant.imgBatokKelapa),
    },
    {
      "id": 2,
      "title": "Keluar / Masuk Bahan Baku",
      "image": const AssetImage(GlobalAssetConstant.imgBahanBaku),
    },
  ];

  List<Map<String, dynamic>> produksiData = [
    {
      "id": 1,
      "title": "Ayak Manual",
      "image": const AssetImage(GlobalAssetConstant.imgAyakManual),
    },
    {
      "id": 2,
      "title": "Ayak Rotari",
      "image": const AssetImage(GlobalAssetConstant.imgAyakRotari),
    },
    {
      "id": 2,
      "title": "Proses Diskmill",
      "image": const AssetImage(GlobalAssetConstant.imgDiskmill),
    },
    {
      "id": 2,
      "title": "Proses Mixing",
      "image": const AssetImage(GlobalAssetConstant.imgDiskmill),
    },
    {
      "id": 2,
      "title": "Proses Sortir",
      "image": const AssetImage(GlobalAssetConstant.imgSortir),
    },
    {
      "id": 2,
      "title": "Proses Pengovenan",
      "image": const AssetImage(GlobalAssetConstant.imgSortir),
    },
  ];

  List<Map<String, dynamic>> pascaProduksiData = [
    {
      "id": 1,
      "title": "Stok Briket",
      "image": const AssetImage(GlobalAssetConstant.imgStokBriket),
    },
  ];
}
