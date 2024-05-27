class ApiProductionConstant {
  ApiProductionConstant._();

  static String getBatok() {
    return 'batok';
  }

  static String postBatok() {
    return 'store/batok';
  }

  static String updateBatok(int id) {
    return 'update/batok/$id';
  }

  static String deleteBatok(int id) {
    return 'delete/batok/$id';
  }

  //* BAHAN BAKU
  static String getBahanBaku() {
    return 'bahan_baku';
  }

  static String postBahanBaku() {
    return 'store/bahan_baku';
  }

  static String updateBahanBaku(int id) {
    return 'update/bahan_baku/$id';
  }

  static String deleteBahanBaku(int id) {
    return 'delete/bahan_baku/$id';
  }
}
