import 'package:dio/dio.dart';
import 'package:flutter_report_app/constants/api_authentication_constant.dart';
import 'package:flutter_report_app/utils/services/dio_service.dart';
import 'package:flutter_report_app/utils/services/hive_service.dart';

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
