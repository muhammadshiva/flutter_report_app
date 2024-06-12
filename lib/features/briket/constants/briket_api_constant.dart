class BriketApiConstant {
  BriketApiConstant._();

  static String getBriket(String filter) {
    return 'briket?filter=$filter';
  }

  static String postBriket() {
    return 'store/briket';
  }

  static String updateBriket(int id) {
    return 'update/briket/$id';
  }

  static String deleteBriket(int id) {
    return 'delete/briket/$id';
  }
}
