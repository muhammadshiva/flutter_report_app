class AyakRotariApiConstant {
  AyakRotariApiConstant._();

  static String getAyakRotari(String filter) {
    return 'ayak_rotari?filter=$filter';
  }

  static String postAyakRotari() {
    return 'store/ayak_rotari';
  }

  static String updateAyakRotari(int id) {
    return 'update/ayak_rotari/$id';
  }

  static String deleteAyakRotari(int id) {
    return 'delete/ayak_rotari/$id';
  }
}
