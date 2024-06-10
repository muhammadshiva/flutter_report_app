class BahanBakuPostResponseModel {
  int? status;
  String? message;
  Data? data;

  BahanBakuPostResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory BahanBakuPostResponseModel.fromJson(Map<String, dynamic> json) =>
      BahanBakuPostResponseModel(
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
  String? bahanBaku;
  int? jumlah;
  String? keterangan;
  String? updatedAt;
  String? createdAt;

  Data({
    this.id,
    this.tanggal,
    this.sumberBatok,
    this.bahanBaku,
    this.jumlah,
    this.keterangan,
    this.updatedAt,
    this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        tanggal: json["tanggal"],
        sumberBatok: json["sumber_batok"],
        bahanBaku: json["bahan_baku"],
        jumlah: json["jumlah"] != null ? int.tryParse(json["jumlah"].toString()) : null,
        keterangan: json["keterangan"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tanggal": tanggal,
        "sumber_batok": sumberBatok,
        "bahan_baku": bahanBaku,
        "jumlah": jumlah,
        "keterangan": keterangan,
        "updated_at": updatedAt,
        "created_at": createdAt,
      };
}
