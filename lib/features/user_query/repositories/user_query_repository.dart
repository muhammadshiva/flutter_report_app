import 'package:bas_app/features/user_query/constants/user_query_api_constant.dart';
import 'package:bas_app/features/user_query/models/user_delete_response_model.dart';
import 'package:bas_app/features/user_query/models/user_post_response_model.dart';
import 'package:bas_app/features/user_query/models/user_update_response_model.dart';
import 'package:bas_app/utils/services/dio_service.dart';
import 'package:bas_app/utils/services/hive_service.dart';
import 'package:dio/dio.dart';

class UserQueryRepository {
  UserQueryRepository._();

  static final dio =
      DioService.dioCall(authorization: HiveService.box.get('token'));

  static Future<UserPostResponseModel> registerUser({
    required String name,
    required String username,
    required String email,
    required String position,
    required String password,
  }) async {
    try {
      var formData = FormData.fromMap({
        "name": name,
        "username": username,
        "email": email,
        "position": position,
        "password": password,
      });

      var response = await dio.post(
        UserQueryApiConstant.registerUser(),
        data: formData,
      );

      return UserPostResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response!.statusCode! >= 500) {
        return UserPostResponseModel(
          status: 500,
          message: "Terjadi masalah pada server",
        );
      }

      var response = e.response?.data;

      if (e.response != null) {
        if (response['status'] == 401) {
          return UserPostResponseModel(
            status: response['status'],
            message: response["message"],
          );
        } else {
          return UserPostResponseModel(
            status: response['status'],
            message: "Terjadi masalah pada server",
          );
        }
      } else {
        return UserPostResponseModel(
          status: 500,
          message: "Koneksi device ini terputus, silahkan cek kembali koneksi!",
        );
      }
    } catch (e) {
      return UserPostResponseModel(message: e.toString());
    }
  }

  static Future<UserUpdateResponseModel> updateUser({
    required int id,
    required String name,
    required String username,
    required String email,
    required String position,
    required String password,
  }) async {
    try {
      var formData = FormData.fromMap({
        "email": email,
        "name": name,
        "username": username,
        "password": password,
        "position": position,
      });

      var response = await dio.put(
        UserQueryApiConstant.updateUser(id: id),
        data: formData,
      );

      return UserUpdateResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response!.statusCode! >= 500) {
        return UserUpdateResponseModel(
          status: 500,
          message: "Terjadi masalah pada server",
        );
      }

      var response = e.response?.data;

      if (e.response != null) {
        if (response['status'] == 401) {
          return UserUpdateResponseModel(
            status: response['status'],
            message: response["message"],
          );
        } else {
          return UserUpdateResponseModel(
            status: response['status'],
            message: "Terjadi masalah pada server",
          );
        }
      } else {
        return UserUpdateResponseModel(
          status: 500,
          message: "Koneksi device ini terputus, silahkan cek kembali koneksi!",
        );
      }
    } catch (e) {
      return UserUpdateResponseModel(message: e.toString());
    }
  }

  static Future<UserDeleteResponseModel> deleteUser({
    required int id,
  }) async {
    try {
      var response = await dio.delete(
        UserQueryApiConstant.deleteUser(id: id),
      );

      return UserDeleteResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response!.statusCode! >= 500) {
        return UserDeleteResponseModel(
          status: 500,
          message: "Terjadi masalah pada server",
        );
      }

      var response = e.response?.data;

      if (e.response != null) {
        if (response['status'] == 401) {
          return UserDeleteResponseModel(
            status: response['status'],
            message: response["message"],
          );
        } else {
          return UserDeleteResponseModel(
            status: response['status'],
            message: "Terjadi masalah pada server",
          );
        }
      } else {
        return UserDeleteResponseModel(
          status: 500,
          message: "Koneksi device ini terputus, silahkan cek kembali koneksi!",
        );
      }
    } catch (e) {
      return UserDeleteResponseModel(message: e.toString());
    }
  }
}
