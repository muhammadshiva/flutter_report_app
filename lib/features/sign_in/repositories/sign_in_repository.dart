import 'package:dio/dio.dart';
import 'package:flutter_report_app/constants/api_authentication_constant.dart';
import 'package:flutter_report_app/features/sign_in/models/sign_in_model.dart';
import 'package:flutter_report_app/utils/services/dio_service.dart';

class SignInRepository {
  SignInRepository._();

  static final Dio dio = DioService.dioCall();

  /// Function to hit Sign In API
  ///
  static Future<SignInResponseModel> signIn(
      {required String email, required String password}) async {
    try {
      var data = {
        'email': email,
        'password': password,
      };

      var response = await dio.post(
        ApiAuthenticationConstant.signIn(),
        data: data,
      );

      return SignInResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      var errorResponse = e.response?.data;
      return SignInResponseModel(
        status: errorResponse['status'],
        message: errorResponse['message'],
      );
    }
  }
}

//* BACKUP
// } catch (e) {
//   if (e is DioException) {
//     // Dio error handling
//     var errorResponse = e.response?.data;
//     return SignInResponseModel(
//       status: errorResponse['status'],
//       message: errorResponse['message'],
//     );
//   } else {
//     return SignInResponseModel(message: e.toString());
//   }
// }
