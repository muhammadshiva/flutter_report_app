import 'dart:developer';

import 'package:bas_app/constants/api_production_constant.dart';
import 'package:bas_app/features/ayak_manual/constants/ayak_manual_api_constant.dart';
import 'package:bas_app/features/ayak_manual/models/ayak_manual_delete_model.dart';
import 'package:bas_app/features/ayak_manual/models/ayak_manual_fetch_model.dart';
import 'package:bas_app/features/ayak_manual/models/ayak_manual_post_model.dart';
import 'package:bas_app/utils/services/dio_service.dart';
import 'package:bas_app/utils/services/hive_service.dart';
import 'package:dio/dio.dart';

class AyakManualRepository {
  AyakManualRepository._();

  static final dio =
      DioService.dioCall(authorization: HiveService.box.get('token'));

  static Future<AyakManualFetchResponseModel> getAyakManual(
      String filter) async {
    try {
      var response = await dio.get(
        AyakManualApiConstant.getAyakManual(filter),
      );
      return AyakManualFetchResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      var errorResponse = e.response?.data;
      return AyakManualFetchResponseModel(
        status: errorResponse['status'],
        message: errorResponse['message'],
      );
    }
  }

  static Future<AyakManualPostResponseModel> postAyakManual({
    int? idAyakManual,
    required String tanggal,
    required String sumberBatok,
    required double jumlahBatok,
    required double jumlahBatokMentah,
    required double jumlahGranul,
    required String keterangan,
  }) async {
    try {
      var formData = FormData.fromMap({
        "tanggal": tanggal,
        "sumber_batok": sumberBatok,
        "jumlah_batok": jumlahBatok,
        "jumlah_batok_mentah": jumlahBatokMentah,
        "jumlah_granul": jumlahGranul,
        "keterangan": keterangan,
      });

      print('ID BAHAN BAKU : $idAyakManual');

      var response = await dio.post(
        idAyakManual != null
            ? AyakManualApiConstant.updateAyakManual(idAyakManual)
            : AyakManualApiConstant.postAyakManual(),
        data: formData,
      );

      return AyakManualPostResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response!.statusCode! >= 500) {
        return AyakManualPostResponseModel(
          status: 500,
          message: "Terjadi masalah pada server",
        );
      }

      var response = e.response?.data;

      if (e.response != null) {
        if (response['status'] == 401) {
          return AyakManualPostResponseModel(
            status: response['status'],
            message: response["message"],
          );
        } else {
          return AyakManualPostResponseModel(
            status: response['status'],
            message: "Terjadi masalah pada server",
          );
        }
      } else {
        return AyakManualPostResponseModel(
          status: 500,
          message: "Koneksi device ini terputus, silahkan cek kembali koneksi!",
        );
      }
    }
  }

  static Future<AyakManualDeleteResponseModel> deleteAyakManual(
      {required int idAyakManual}) async {
    try {
      var response = await dio
          .delete(AyakManualApiConstant.deleteAyakManual(idAyakManual));
      return AyakManualDeleteResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      var errorResponse = e.response?.data;
      return AyakManualDeleteResponseModel(message: errorResponse);
    }
  }

  static Future<Response?> exportAyakManual() async {
    try {
      var response = await dio.get(
        ApiProductionConstant.exportAyakManual(),
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );

      return response;
    } on DioException catch (e) {
      var errorResponse = e.response?.data;
      log('ERROR EXPORT AYAK MANUAL : $errorResponse');
      return e.response;
    }
  }
}
