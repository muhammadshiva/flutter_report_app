class UserQueryApiConstant {
  UserQueryApiConstant._();

  static String registerUser() {
    return 'register';
  }

  static String updateUser({required int id}) {
    return 'user/update/$id';
  }

  static String deleteUser({required int id}) {
    return 'user/$id';
  }
}
