import 'package:bas_app/features/oven/constants/oven_api_constant.dart';
import 'package:bas_app/features/oven/models/oven_delete_model.dart';
import 'package:bas_app/features/oven/models/oven_fetch_model.dart';
import 'package:bas_app/features/oven/models/oven_post_model.dart';
import 'package:bas_app/utils/services/dio_service.dart';
import 'package:bas_app/utils/services/hive_service.dart';
import 'package:dio/dio.dart';

class OvenRepository {
  OvenRepository._();

  static final dio =
      DioService.dioCall(authorization: HiveService.box.get('token'));

  static Future<OvenFetchResponseModel> getOven(String filter) async {
    try {
      var response = await dio.get(
        OvenApiConstant.getOven(filter),
      );
      return OvenFetchResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      var errorResponse = e.response?.data;
      return OvenFetchResponseModel(
        status: errorResponse['status'],
        message: errorResponse['message'],
      );
    }
  }

//* SAMPEL DATA

// {
//     "jenis_masukan": "Penambahan",
//     "tanggal" : "2024-05-09",
//     "sumber_batok" : "Sumatera",
//     "jenis_briket" : "Grade B",
//     "pengovenan" : 1100.0,
//     "pendinginan" : 1200.0,
//     "keterangan" : "Tidak ada"
// }

  static Future<OvenPostResponseModel> postOven({
    int? idOven,
    required String jenisMasukan,
    required String tanggal,
    required String sumberBatok,
    required String jenisBriket,
    required double pengovenan,
    required double pendinginan,
    required String keterangan,
  }) async {
    try {
      var formData = FormData.fromMap({
        "jenis_masukan": jenisMasukan,
        "tanggal": tanggal,
        "sumber_batok": sumberBatok,
        "jenis_briket": jenisBriket,
        "pengovenan": pengovenan,
        "pendinginan": pendinginan,
        "keterangan": keterangan,
      });

      print('ID BAHAN BAKU : $idOven');

      var response = await dio.post(
        idOven != null
            ? OvenApiConstant.updateOven(idOven)
            : OvenApiConstant.postOven(),
        data: formData,
      );

      return OvenPostResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response!.statusCode! >= 500) {
        return OvenPostResponseModel(
          status: 500,
          message: "Terjadi masalah pada server",
        );
      }

      var response = e.response?.data;

      if (e.response != null) {
        if (response['status'] == 401) {
          return OvenPostResponseModel(
            status: response['status'],
            message: response["message"],
          );
        } else {
          return OvenPostResponseModel(
            status: response['status'],
            message: "Terjadi masalah pada server",
          );
        }
      } else {
        return OvenPostResponseModel(
          status: 500,
          message: "Koneksi device ini terputus, silahkan cek kembali koneksi!",
        );
      }
    }
  }

  static Future<OvenDeleteResponseModel> deleteOven(
      {required int idOven}) async {
    try {
      var response = await dio.delete(OvenApiConstant.deleteOven(idOven));
      return OvenDeleteResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      var errorResponse = e.response?.data;
      return OvenDeleteResponseModel(message: errorResponse);
    }
  }
}
