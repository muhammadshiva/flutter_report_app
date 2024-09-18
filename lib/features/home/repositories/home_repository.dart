import 'dart:developer';

import 'package:bas_app/constants/api_authentication_constant.dart';
import 'package:bas_app/constants/api_production_constant.dart';
import 'package:bas_app/features/home/model/menu_fetch_model.dart';
import 'package:bas_app/shared/model/sumber_batok_fetch_model.dart';
import 'package:bas_app/utils/services/dio_service.dart';
import 'package:bas_app/utils/services/hive_service.dart';
import 'package:dio/dio.dart';

class HomeRepository {
  HomeRepository._();
  static final dio =
      DioService.dioCall(authorization: HiveService.box.get('token'));

  static final token = HiveService.box.get('token');

  static Future<Response> logout() async {
    try {
      final response = await dio.post(
        ApiAuthenticationConstant.signOut(),
      );

      return response;
    } catch (e) {
      log('Error during sign out: $e');
      throw Exception('Failed to sign out');
    }
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
    } catch (e) {
      return MenuFetchResponseModel(message: e.toString());
    }
  }

  static Future<SumberBatokFetchModel> getSumberBatok() async {
    try {
      var response = await dio.get(
        ApiProductionConstant.getSumberBatok(),
      );
      return SumberBatokFetchModel.fromJson(response.data);
    } on DioException catch (e) {
      var errorResponse = e.response?.data;
      return SumberBatokFetchModel(
        status: errorResponse['status'],
        message: errorResponse['message'],
      );
    } catch (e) {
      return SumberBatokFetchModel(message: e.toString());
    }
  }
}
