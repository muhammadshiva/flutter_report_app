import 'package:bas_app/constants/api_authentication_constant.dart';
import 'package:bas_app/features/home/model/menu_fetch_model.dart';
import 'package:bas_app/utils/services/dio_service.dart';
import 'package:bas_app/utils/services/hive_service.dart';
import 'package:dio/dio.dart';

class HomeRepository {
  HomeRepository._();
  static final dio =
      DioService.dioCall(authorization: HiveService.box.get('token'));

  static Future<Response> logout() async {
    final response = await dio.post(
      ApiAuthenticationConstant.signOut(),
    );

    return response;
  }

  static Future<MenuFetchResponseModel> fetchMenu() async {
    try {
      var response = await dio.get(
        ApiAuthenticationConstant.fetchMenu(),
      );
      return MenuFetchResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      var errorResponse = e.response?.data;
      return MenuFetchResponseModel(
        status: errorResponse['status'],
        message: errorResponse['message'],
      );
    }
  }
}
