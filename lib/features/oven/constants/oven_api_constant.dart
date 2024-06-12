class OvenApiConstant {
  OvenApiConstant._();

  static String getOven(String filter) {
    return 'oven?filter=$filter';
  }

  static String postOven() {
    return 'store/oven';
  }

  static String updateOven(int id) {
    return 'update/oven/$id';
  }

  static String deleteOven(int id) {
    return 'delete/oven/$id';
  }
}
