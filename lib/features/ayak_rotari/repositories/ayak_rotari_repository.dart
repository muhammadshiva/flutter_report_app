import 'dart:developer';

import 'package:bas_app/constants/api_production_constant.dart';
import 'package:bas_app/features/ayak_rotari/constants/ayak_rotari_api_constant.dart';
import 'package:bas_app/features/ayak_rotari/models/ayak_rotari_delete_model.dart';
import 'package:bas_app/features/ayak_rotari/models/ayak_rotari_fetch_model.dart';
import 'package:bas_app/features/ayak_rotari/models/ayak_rotari_post_model.dart';
import 'package:bas_app/utils/services/dio_service.dart';
import 'package:bas_app/utils/services/hive_service.dart';
import 'package:dio/dio.dart';

class AyakRotariRepository {
  AyakRotariRepository._();

  static final dio =
      DioService.dioCall(authorization: HiveService.box.get('token'));

  static Future<AyakRotariFetchResponseModel> getAyakRotari(
      String filter) async {
    try {
      var response = await dio.get(
        AyakRotariApiConstant.getAyakRotari(filter),
      );
      return AyakRotariFetchResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      var errorResponse = e.response?.data;
      return AyakRotariFetchResponseModel(
        status: errorResponse['status'],
        message: errorResponse['message'],
      );
    }
  }

//* DATA SAMPEL
//   {
//     "tanggal": "2024-06-03",
//     "sumber_batok": "Sulawesi",
//     "batok_masuk": 1200.0,
//     "batok_kotor": 1500.0,
//     "hasil_batok": 1000.0,
//     "hasil_abu": 9000.0,
//     "keterangan": "Tidak ada"
// }

  static Future<AyakRotariPostResponseModel> postAyakRotari({
    int? idAyakRotari,
    required String tanggal,
    required String sumberBatok,
    required double batokMasuk,
    required double batokKotor,
    required double hasilBatok,
    required double hasilAbu,
    required String keterangan,
  }) async {
    try {
      var formData = FormData.fromMap({
        "tanggal": tanggal,
        "sumber_batok": sumberBatok,
        "batok_masuk": batokMasuk,
        "batok_kotor": batokKotor,
        "hasil_batok": hasilBatok,
        "hasil_abu": hasilAbu,
        "keterangan": keterangan,
      });

      print('ID BAHAN BAKU : $idAyakRotari');

      var response = await dio.post(
        idAyakRotari != null
            ? AyakRotariApiConstant.updateAyakRotari(idAyakRotari)
            : AyakRotariApiConstant.postAyakRotari(),
        data: formData,
      );

      return AyakRotariPostResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response!.statusCode! >= 500) {
        return AyakRotariPostResponseModel(
          status: 500,
          message: "Terjadi masalah pada server",
        );
      }

      var response = e.response?.data;

      if (e.response != null) {
        if (response['status'] == 401) {
          return AyakRotariPostResponseModel(
            status: response['status'],
            message: response["message"],
          );
        } else {
          return AyakRotariPostResponseModel(
            status: response['status'],
            message: "Terjadi masalah pada server",
          );
        }
      } else {
        return AyakRotariPostResponseModel(
          status: 500,
          message: "Koneksi device ini terputus, silahkan cek kembali koneksi!",
        );
      }
    }
  }

  static Future<AyakRotariDeleteResponseModel> deleteAyakRotari(
      {required int idAyakRotari}) async {
    try {
      var response = await dio
          .delete(AyakRotariApiConstant.deleteAyakRotari(idAyakRotari));
      return AyakRotariDeleteResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      var errorResponse = e.response?.data;
      return AyakRotariDeleteResponseModel(message: errorResponse);
    }
  }

  static Future<Response?> exportAyakRotari() async {
    try {
      var response = await dio.get(
        ApiProductionConstant.exportAyakRotari(),
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );

      return response;
    } on DioException catch (e) {
      var errorResponse = e.response?.data;
      log('ERROR EXPORT AYAK ROTARI : $errorResponse');
      return e.response;
    }
  }
}
