class DiskmillApiConstant {
  DiskmillApiConstant._();

  static String getDiskmill(String filter) {
    return 'diskmill?filter=$filter';
  }

  static String postDiskmill() {
    return 'store/diskmill';
  }

  static String updateDiskmill(int id) {
    return 'update/diskmill/$id';
  }

  static String deleteDiskmill(int id) {
    return 'delete/diskmill/$id';
  }
}
