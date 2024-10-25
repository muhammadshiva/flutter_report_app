import 'package:bas_app/features/user/constants/user_api_constant.dart';
import 'package:bas_app/features/user/models/user_fetch_model.dart';
import 'package:bas_app/utils/services/dio_service.dart';
import 'package:bas_app/utils/services/hive_service.dart';
import 'package:dio/dio.dart';

class UserRepository {
  UserRepository._();

  static final dio =
      DioService.dioCall(authorization: HiveService.box.get('token'));

  static Future<UserFetchResponseModel> getAllUser() async {
    try {
      var response = await dio.get(UserApiConstant.getAllUser());

      return UserFetchResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      var errorResponse = e.response?.data;
      return UserFetchResponseModel(
        status: errorResponse['status'],
        message: errorResponse['message'],
      );
    } catch (e) {
      return UserFetchResponseModel(message: e.toString());
    }
  }
}
