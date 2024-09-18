import 'package:bas_app/utils/services/dio_service.dart';
import 'package:bas_app/utils/services/hive_service.dart';

class GlobalRepository {
  GlobalRepository._();

  static final dio =
      DioService.dioCall(authorization: HiveService.box.get('token'));
}
