import 'dart:developer';

import 'package:bas_app/constants/api_production_constant.dart';
import 'package:bas_app/features/bahan_baku/models/bahan_baku_delete_model.dart';
import 'package:bas_app/features/bahan_baku/models/bahan_baku_fetch_model.dart';
import 'package:bas_app/features/bahan_baku/models/bahan_baku_post_model.dart';
import 'package:bas_app/utils/services/dio_service.dart';
import 'package:bas_app/utils/services/hive_service.dart';
import 'package:dio/dio.dart';

class BahanBakuRepository {
  BahanBakuRepository._();

  static final dio =
      DioService.dioCall(authorization: HiveService.box.get('token'));

  static Future<BahanBakuFetchResponseModel> getBahanBaku(String filter) async {
    try {
      var response = await dio.get(
        ApiProductionConstant.getBahanBaku(filter),
      );
      return BahanBakuFetchResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      var errorResponse = e.response?.data;
      return BahanBakuFetchResponseModel(
        status: errorResponse['status'],
        message: errorResponse['message'],
      );
    }
  }

//* SAMPEL DATA
//   {
//     "tanggal": "2024-06-03",
//     "jenis_masukan": "Penambahan",
//     "sumber_batok": "Kalimantan",
//     "bahan_baku": "Stok Arang",
//     "jumlah": 200.0,
//     "keterangan": "Tidak ada keterangan"
// }

  static Future<BahanBakuPostResponseModel> postBahanBaku({
    int? idBahanBaku,
    required String tanggal,
    required String jenisMasukan,
    required String sumberBatok,
    required String bahanBaku,
    required double jumlahBahanBaku,
    required String keterangan,
  }) async {
    try {
      var formData = FormData.fromMap({
        "tanggal": tanggal,
        "jenis_masukan": jenisMasukan,
        "sumber_batok": sumberBatok,
        "bahan_baku": bahanBaku,
        "jumlah": jumlahBahanBaku,
        "keterangan": keterangan,
      });

      print('ID BAHAN BAKU : $idBahanBaku');

      var response = await dio.post(
        idBahanBaku != null
            ? ApiProductionConstant.updateBahanBaku(idBahanBaku)
            : ApiProductionConstant.postBahanBaku(),
        data: formData,
      );

      return BahanBakuPostResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response!.statusCode! >= 500) {
        return BahanBakuPostResponseModel(
          status: 500,
          message: "Terjadi masalah pada server",
        );
      }

      var response = e.response?.data;

      if (e.response != null) {
        if (response['status'] == 401) {
          return BahanBakuPostResponseModel(
            status: response['status'],
            message: response["message"],
          );
        } else {
          return BahanBakuPostResponseModel(
            status: response['status'],
            message: "Terjadi masalah pada server",
          );
        }
      } else {
        return BahanBakuPostResponseModel(
          status: 500,
          message: "Koneksi device ini terputus, silahkan cek kembali koneksi!",
        );
      }
    }
  }

  static Future<BahanBakuDeleteResponseModel> deleteBahanBaku(
      {required int idBahanBaku}) async {
    try {
      var response =
          await dio.delete(ApiProductionConstant.deleteBahanBaku(idBahanBaku));
      return BahanBakuDeleteResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      var errorResponse = e.response?.data;
      return BahanBakuDeleteResponseModel(message: errorResponse);
    }
  }

  static Future<Response?> exportBahanBaku() async {
    try {
      var response = await dio.get(
        ApiProductionConstant.exportBahanBaku(),
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );

      return response;
    } on DioException catch (e) {
      var errorResponse = e.response?.data;
      log('ERROR EXPORT BAHAN BAKU : $errorResponse');
      return e.response;
    }
  }
}
