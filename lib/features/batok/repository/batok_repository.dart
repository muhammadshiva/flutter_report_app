import 'package:bas_app/constants/api_production_constant.dart';
import 'package:bas_app/features/batok/models/batok_delete_model.dart';
import 'package:bas_app/features/batok/models/batok_fetch_model.dart';
import 'package:bas_app/features/batok/models/batok_post_model.dart';
import 'package:bas_app/utils/services/dio_service.dart';
import 'package:bas_app/utils/services/hive_service.dart';
import 'package:dio/dio.dart';

class BatokRepository {
  BatokRepository._();

  static final dio = DioService.dioCall(authorization: HiveService.box.get('token'));

  static Future<BatokFetchResponseModel> getBatok(String filter) async {
    try {
      var response = await dio.get(
        ApiProductionConstant.getBatok(filter),
      );
      return BatokFetchResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      var errorResponse = e.response?.data;
      return BatokFetchResponseModel(
        status: errorResponse['status'],
        message: errorResponse['message'],
      );
    }
  }

  //* SAMPEL DATA BATOK
//   {
//     "jenis_masukan": "Penambahan",
//     "tanggal": "2024-06-09",
//     "sumber_batok": "Sumatera",
//     "jumlah_batok": 700.0,
//     "keterangan": "Stok tersedia"
// }
  static Future<BatokPostResponseModel> postBatok({
    int? idBatok,
    required String tanggal,
    required String jenisMasukan,
    required String sumberBatok,
    required double jumlahBatok,
    required String keterangan,
  }) async {
    try {
      var formData = FormData.fromMap({
        "jenis_masukan": jenisMasukan,
        "tanggal": tanggal,
        "sumber_batok": sumberBatok,
        "jumlah_batok": jumlahBatok,
        "keterangan": keterangan,
      });

      print('ID BATOK : $idBatok');

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
