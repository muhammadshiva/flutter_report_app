import 'dart:developer';

import 'package:bas_app/constants/api_production_constant.dart';
import 'package:bas_app/features/diskmill/constants/diskmill_api_constant.dart';
import 'package:bas_app/features/diskmill/models/diskmill_delete_model.dart';
import 'package:bas_app/features/diskmill/models/diskmill_fetch_model.dart';
import 'package:bas_app/features/diskmill/models/diskmill_post_model.dart';
import 'package:bas_app/utils/services/dio_service.dart';
import 'package:bas_app/utils/services/hive_service.dart';
import 'package:dio/dio.dart';

class DiskmillRepository {
  DiskmillRepository._();

  static final dio =
      DioService.dioCall(authorization: HiveService.box.get('token'));

  static Future<DiskmillFetchResponseModel> getDiskmill(String filter) async {
    try {
      var response = await dio.get(
        DiskmillApiConstant.getDiskmill(filter),
      );
      return DiskmillFetchResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      var errorResponse = e.response?.data;
      return DiskmillFetchResponseModel(
        status: errorResponse['status'],
        message: errorResponse['message'],
      );
    }
  }

//* DATA SAMPEL
//   {
//     "tanggal":"2024-05-09",
//     "sumber_batok": "Kalimantan",
//     "batok_masuk": 1200.00,
//     "hasil_pisau_02": 600.00,
//     "hasil_pisau_03": 600.00,
//     "keterangan": "Tidak ada"
// }

  static Future<DiskmillPostResponseModel> postDiskmill({
    int? idDiskmill,
    required String tanggal,
    required String sumberBatok,
    required double batokMasuk,
    required double hasilPisau02,
    required double hasilPisau03,
    required String keterangan,
  }) async {
    try {
      var formData = FormData.fromMap({
        "tanggal": tanggal,
        "sumber_batok": sumberBatok,
        "batok_masuk": batokMasuk,
        "hasil_pisau_02": hasilPisau02,
        "hasil_pisau_03": hasilPisau03,
        "keterangan": keterangan,
      });

      print('ID BAHAN BAKU : $idDiskmill');

      var response = await dio.post(
        idDiskmill != null
            ? DiskmillApiConstant.updateDiskmill(idDiskmill)
            : DiskmillApiConstant.postDiskmill(),
        data: formData,
      );

      return DiskmillPostResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response!.statusCode! >= 500) {
        return DiskmillPostResponseModel(
          status: 500,
          message: "Terjadi masalah pada server",
        );
      }

      var response = e.response?.data;

      if (e.response != null) {
        if (response['status'] == 401) {
          return DiskmillPostResponseModel(
            status: response['status'],
            message: response["message"],
          );
        } else {
          return DiskmillPostResponseModel(
            status: response['status'],
            message: "Terjadi masalah pada server",
          );
        }
      } else {
        return DiskmillPostResponseModel(
          status: 500,
          message: "Koneksi device ini terputus, silahkan cek kembali koneksi!",
        );
      }
    }
  }

  static Future<DiskmillDeleteResponseModel> deleteDiskmill(
      {required int idDiskmill}) async {
    try {
      var response =
          await dio.delete(DiskmillApiConstant.deleteDiskmill(idDiskmill));
      return DiskmillDeleteResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      var errorResponse = e.response?.data;
      return DiskmillDeleteResponseModel(message: errorResponse);
    }
  }

  static Future<Response?> exportDiskmill() async {
    try {
      var response = await dio.get(
        ApiProductionConstant.exportDiskmill(),
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );

      return response;
    } on DioException catch (e) {
      var errorResponse = e.response?.data;
      log('ERROR EXPORT DISKMILL : $errorResponse');
      return e.response;
    }
  }
}
