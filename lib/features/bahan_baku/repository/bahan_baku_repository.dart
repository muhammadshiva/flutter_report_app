import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_report_app/constants/api_production_constant.dart';
import 'package:flutter_report_app/features/bahan_baku/models/bahan_baku_model.dart';
import 'package:flutter_report_app/features/bahan_baku/models/bahan_baku_post_model.dart';
import 'package:flutter_report_app/utils/services/dio_service.dart';
import 'package:flutter_report_app/utils/services/hive_service.dart';

class BahanBakuRepository {
  BahanBakuRepository._();

  static final dio = DioService.dioCall(authorization: HiveService.box.get('token'));

  static Future<BahanBakuPostResponseModel> postBahanBaku({
    int? idBahanBaku,
    required String tanggal,
    required String sumberBatok,
    required String bahanBaku,
    required double jumlahMasuk,
    required double jumlahKeluar,
    required String keterangan,
  }) async {
    try {
      var formData = FormData.fromMap({
        "tanggal": tanggal,
        "sumber_batok": sumberBatok,
        "bahan_baku": bahanBaku,
        "jumlah_masuk": jumlahMasuk,
        "jumlah_keluar": jumlahKeluar,
        "keterangan": keterangan,
      });

      debugPrint('ID BAHAN BAKU POST : $idBahanBaku');

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

  static Future<BahanBakuResponseModel> getBahanBaku() async {
    try {
      var response = await dio.get(ApiProductionConstant.getBahanBaku());
      return BahanBakuResponseModel.fromJson(response.data);
    } catch (e) {
      if (e is DioException) {
        var errorResponse = e.response?.data;
        return BahanBakuResponseModel(
          status: errorResponse['status'],
          message: errorResponse['message'],
        );
      } else {
        return BahanBakuResponseModel(message: e.toString());
      }
    }
  }

  static Future<DeleteBahanBakuResponseModel> deleteBahanBaku({required int idBahanBaku}) async {
    try {
      var response = await dio.delete(ApiProductionConstant.deleteBahanBaku(idBahanBaku));
      return DeleteBahanBakuResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      var errorResponse = e.response?.data;
      return DeleteBahanBakuResponseModel(message: errorResponse);
    }
  }
}
