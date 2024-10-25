import 'package:bas_app/features/user/models/user_fetch_model.dart';

class UserQueryArgument {
  final bool? isEdit;
  final UserData? userData;

  UserQueryArgument({
    this.isEdit,
    this.userData,
  });
}
