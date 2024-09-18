import 'package:bas_app/constants/api_production_constant.dart';
import 'package:bas_app/shared/model/sumber_batok_fetch_model.dart';
import 'package:bas_app/utils/services/dio_service.dart';
import 'package:bas_app/utils/services/hive_service.dart';
import 'package:dio/dio.dart';

class GlobalRepository {
  GlobalRepository._();

  static final dio =
      DioService.dioCall(authorization: HiveService.box.get('token'));
}
