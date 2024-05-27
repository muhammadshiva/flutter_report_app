import 'package:flutter_report_app/utils/services/dio_service.dart';
import 'package:flutter_report_app/utils/services/hive_service.dart';

class OvenRepository {
  OvenRepository._();

  static final dio = DioService.dioCall(authorization: HiveService.box.get('token'));
}
