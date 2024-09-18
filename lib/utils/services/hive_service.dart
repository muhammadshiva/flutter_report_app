import 'package:bas_app/features/sign_in/models/sign_in_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  HiveService._();

  static final box = Hive.box("bas");

  static Future<void> setAuth(
    SignInData signInData, {
    bool isLogin = true,
  }) async {
    if (signInData.email != null) {
      await box.put("email", signInData.email);
    }

    if (signInData.password != null) {
      await box.put("password", signInData.password);
    }

    if (signInData.token != null) {
      await box.put("token", signInData.token);
    }

    await box.put("isLogin", isLogin);
  }

  static Future<void> deleteAuth() async {
    await box.delete("email");
    await box.delete("password");
    await box.delete("token");
    await box.delete("isLogin");
  }
}
