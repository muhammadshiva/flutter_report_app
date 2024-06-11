class DiskmillPostResponseModel {
  int? status;
  String? message;
  Data? data;

  DiskmillPostResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory DiskmillPostResponseModel.fromJson(Map<String, dynamic> json) =>
      DiskmillPostResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int? id;
  String? tanggal;
  String? sumberBatok;
  double? batokMasuk;
  double? hasilPisau02;
  double? hasilPisau03;
  String? keterangan;

  Data({
    this.id,
    this.tanggal,
    this.sumberBatok,
    this.batokMasuk,
    this.hasilPisau02,
    this.hasilPisau03,
    this.keterangan,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        tanggal: json["tanggal"],
        sumberBatok: json["sumber_batok"],
        batokMasuk: json["batok_masuk"] != null
            ? double.tryParse(json["batok_masuk"].toString())
            : null,
        hasilPisau02: json["hasil_pisau_02"] != null
            ? double.tryParse(json["hasil_pisau_02"].toString())
            : null,
        hasilPisau03: json["hasil_pisau_03"] != null
            ? double.tryParse(json["hasil_pisau_03"].toString())
            : null,
        keterangan: json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tanggal": tanggal,
        "sumber_batok": sumberBatok,
        "batok_masuk": batokMasuk,
        "hasil_pisau_02": hasilPisau02,
        "hasil_pisau_03": hasilPisau03,
        "keterangan": keterangan,
      };
}
