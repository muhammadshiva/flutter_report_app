import 'package:dio/dio.dart';
import 'package:flutter_report_app/constants/api_production_constant.dart';
import 'package:flutter_report_app/features/batok/models/batok_model.dart';
import 'package:flutter_report_app/features/batok/models/batok_post_model.dart';
import 'package:flutter_report_app/utils/services/dio_service.dart';
import 'package:flutter_report_app/utils/services/hive_service.dart';

class BatokRepository {
  BatokRepository._();

  static final dio = DioService.dioCall(authorization: HiveService.box.get('token'));

  static Future<BatokResponseModel> getBatok() async {
    try {
      var response = await dio.get(ApiProductionConstant.getBatok());
      return BatokResponseModel.fromJson(response.data);
    } catch (e) {
      if (e is DioException) {
        var errorResponse = e.response?.data;
        return BatokResponseModel(
          status: errorResponse['status'],
          message: errorResponse['message'],
        );
      } else {
        return BatokResponseModel(message: e.toString());
      }
    }
  }

  static Future<BatokPostResponseModel> postBatok({
    int? idBatok,
    required String tanggal,
    required String sumberBatok,
    required double barangMasuk,
    required double barangKeluar,
    required double stokAwal,
    required double stokAkhir,
    required String keterangan,
  }) async {
    try {
      var formData = FormData.fromMap({
        "tanggal": tanggal,
        "sumber_batok": sumberBatok,
        "barang_masuk": barangMasuk,
        "barang_keluar": barangKeluar,
        "stok_awal": stokAwal,
        "stok_akhir": stokAkhir,
        "keterangan": keterangan,
      });

      var response = await dio.post(
        idBatok != null
            ? ApiProductionConstant.updateBatok(idBatok)
            : ApiProductionConstant.postBatok(),
        data: formData,
      );

      return BatokPostResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response!.statusCode! >= 500) {
        return BatokPostResponseModel(
          status: 500,
          message: "Terjadi masalah pada server",
        );
      }

      var response = e.response?.data;

      if (e.response != null) {
        if (response['status'] == 401) {
          return BatokPostResponseModel(
            status: response['status'],
            message: response["message"],
          );
        } else {
          return BatokPostResponseModel(
            status: response['status'],
            message: "Terjadi masalah pada server",
          );
        }
      } else {
        return BatokPostResponseModel(
          status: 500,
          message: "Koneksi device ini terputus, silahkan cek kembali koneksi!",
        );
      }
    }
  }

  static Future<BatokDeleteResponseModel> deleteBatok({required int idBatok}) async {
    try {
      var response = await dio.delete(ApiProductionConstant.deleteBatok(idBatok));
      return BatokDeleteResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      var errorResponse = e.response?.data;
      return BatokDeleteResponseModel(message: errorResponse);
    }
  }
}
