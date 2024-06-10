class AyakManualApiConstant {
  AyakManualApiConstant._();

  static String getAyakManual(String filter) {
    return 'ayak_manual?filter=$filter';
  }

  static String postAyakManual() {
    return 'store/ayak_manual';
  }

  static String updateAyakManual(int id) {
    return 'update/ayak_manual/$id';
  }

  static String deleteAyakManual(int id) {
    return 'delete/ayak_manual/$id';
  }
}
