import 'package:bas_app/constants/api_authentication_constant.dart';
import 'package:bas_app/utils/services/dio_service.dart';
import 'package:bas_app/utils/services/hive_service.dart';
import 'package:dio/dio.dart';

class HomeRepository {
  HomeRepository._();

  static Future<Response> logout() async {
    final dio = DioService.dioCall(authorization: HiveService.box.get('token'));

    final response = await dio.post(
      ApiAuthenticationConstant.signOut(),
    );

    return response;
  }
}
