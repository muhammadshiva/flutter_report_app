import 'dart:developer';

import 'package:bas_app/constants/api_production_constant.dart';
import 'package:bas_app/features/mixing/constants/mixing_api_constant.dart';
import 'package:bas_app/features/mixing/models/mixing_delete_model.dart';
import 'package:bas_app/features/mixing/models/mixing_fetch_model.dart';
import 'package:bas_app/features/mixing/models/mixing_post_model.dart';
import 'package:bas_app/utils/services/dio_service.dart';
import 'package:bas_app/utils/services/hive_service.dart';
import 'package:dio/dio.dart';

class MixingRepository {
  MixingRepository._();

  static final dio = DioService.dioCall(
    authorization: HiveService.box.get('token'),
  );

  static Future<MixingFetchResponseModel> getMixing(String filter) async {
    try {
      var response = await dio.get(
        MixingApiConstant.getMixing(filter),
      );
      return MixingFetchResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      var errorResponse = e.response?.data;
      return MixingFetchResponseModel(
        status: errorResponse['status'],
        message: errorResponse['message'],
      );
    }
  }

// * SAMPEL DATA
//   {
//     "tanggal" : "2024-06-03",
//     "sumber_batok": "Kalimantan",
//     "ukuran_pisau" : 0.2,
//     "jumlah_arang" :500.0,
//     "jumlah_aci" : 300.0,
//     "jumlah_cairan" : 220.0,
//     "keterangan" : "Tidak ada"
// }

  static Future<MixingPostResponseModel> postMixing({
    int? idMixing,
    required String tanggal,
    required String sumberBatok,
    required String ukuranPisau,
    required double jumlahArang,
    required double jumlahAci,
    required double jumlahCairan,
    required String keterangan,
  }) async {
    try {
      var formData = FormData.fromMap({
        "tanggal": tanggal,
        "sumber_batok": sumberBatok,
        "ukuran_pisau": ukuranPisau,
        "jumlah_arang": jumlahArang,
        "jumlah_aci": jumlahAci,
        "jumlah_cairan": jumlahCairan,
        "keterangan": keterangan,
      });

      print('ID BAHAN BAKU : $idMixing');

      var response = await dio.post(
        idMixing != null
            ? MixingApiConstant.updateMixing(idMixing)
            : MixingApiConstant.postMixing(),
        data: formData,
      );

      return MixingPostResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response!.statusCode! >= 500) {
        return MixingPostResponseModel(
          status: 500,
          message: "Terjadi masalah pada server",
        );
      }

      var response = e.response?.data;

      if (e.response != null) {
        if (response['status'] == 401) {
          return MixingPostResponseModel(
            status: response['status'],
            message: response["message"],
          );
        } else {
          return MixingPostResponseModel(
            status: response['status'],
            message: "Terjadi masalah pada server",
          );
        }
      } else {
        return MixingPostResponseModel(
          status: 500,
          message: "Koneksi device ini terputus, silahkan cek kembali koneksi!",
        );
      }
    }
  }

  static Future<MixingDeleteResponseModel> deleteMixing(
      {required int idMixing}) async {
    try {
      var response = await dio.delete(
        MixingApiConstant.deleteMixing(idMixing),
      );
      return MixingDeleteResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      var errorResponse = e.response?.data;
      return MixingDeleteResponseModel(message: errorResponse);
    }
  }

  static Future<Response?> exportMixing() async {
    try {
      var response = await dio.get(
        ApiProductionConstant.exportMixing(),
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );

      return response;
    } on DioException catch (e) {
      var errorResponse = e.response?.data;
      log('ERROR EXPORT MIXING : $errorResponse');
      return e.response;
    }
  }
}
