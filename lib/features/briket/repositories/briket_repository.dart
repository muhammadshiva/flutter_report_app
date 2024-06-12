import 'package:bas_app/features/briket/constants/briket_api_constant.dart';
import 'package:bas_app/features/briket/models/briket_delete_model.dart';
import 'package:bas_app/features/briket/models/briket_fetch_model.dart';
import 'package:bas_app/features/briket/models/briket_post_model.dart';
import 'package:bas_app/utils/services/dio_service.dart';
import 'package:bas_app/utils/services/hive_service.dart';
import 'package:dio/dio.dart';

class BriketRepository {
  BriketRepository._();

  static final dio =
      DioService.dioCall(authorization: HiveService.box.get('token'));

  static Future<BriketFetchResponseModel> getBriket(String filter) async {
    try {
      var response = await dio.get(
        BriketApiConstant.getBriket(filter),
      );
      return BriketFetchResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      var errorResponse = e.response?.data;
      return BriketFetchResponseModel(
        status: errorResponse['status'],
        message: errorResponse['message'],
      );
    }
  }

  //* SAMPEL DATA
  //   {
  //     "jenis_masukan": "Penambahan",
  //     "tanggal" : "2024-06-04",
  //     "sumber_batok" : "Kalimantan",
  //     "jenis_briket" : "Grade C",
  //     "stok" :1000.0,
  //     "keterangan" : "Todal ada"
  // }

  static Future<BriketPostResponseModel> postBriket({
    int? idBriket,
    required String jenisMasukan,
    required String tanggal,
    required String sumberBatok,
    required String jenisBriket,
    required double stok,
    required String keterangan,
  }) async {
    try {
      var formData = FormData.fromMap({
        "jenis_masukan": jenisMasukan,
        "tanggal": tanggal,
        "sumber_batok": sumberBatok,
        "jenis_briket": jenisBriket,
        "stok": stok,
        "keterangan": keterangan,
      });

      var response = await dio.post(
        idBriket != null
            ? BriketApiConstant.updateBriket(idBriket)
            : BriketApiConstant.postBriket(),
        data: formData,
      );

      return BriketPostResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response!.statusCode! >= 500) {
        return BriketPostResponseModel(
          status: 500,
          message: "Terjadi masalah pada server",
        );
      }

      var response = e.response?.data;

      if (e.response != null) {
        if (response['status'] == 401) {
          return BriketPostResponseModel(
            status: response['status'],
            message: response["message"],
          );
        } else {
          return BriketPostResponseModel(
            status: response['status'],
            message: "Terjadi masalah pada server",
          );
        }
      } else {
        return BriketPostResponseModel(
          status: 500,
          message: "Koneksi device ini terputus, silahkan cek kembali koneksi!",
        );
      }
    }
  }

  static Future<BriketDeleteResponseModel> deleteOven(
      {required int idBriket}) async {
    try {
      var response = await dio.delete(BriketApiConstant.deleteBriket(idBriket));
      return BriketDeleteResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      var errorResponse = e.response?.data;
      return BriketDeleteResponseModel(message: errorResponse);
    }
  }
}
