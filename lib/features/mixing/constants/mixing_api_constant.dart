class MixingApiConstant {
  MixingApiConstant._();

  static String getMixing(String filter) {
    return 'mixing?filter=$filter';
  }

  static String postMixing() {
    return 'store/mixing';
  }

  static String updateMixing(int id) {
    return 'update/mixing/$id';
  }

  static String deleteMixing(int id) {
    return 'delete/mixing/$id';
  }
}
