class BatokPostResponseModel {
  int? status;
  String? message;
  Data? data;

  BatokPostResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory BatokPostResponseModel.fromJson(Map<String, dynamic> json) => BatokPostResponseModel(
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
  double? barangMasuk;
  double? barangKeluar;
  double? stokAwal;
  double? stokAkhir;
  String? keterangan;
  String? updatedAt;
  String? createdAt;

  Data({
    this.id,
    this.tanggal,
    this.sumberBatok,
    this.barangMasuk,
    this.barangKeluar,
    this.stokAwal,
    this.stokAkhir,
    this.keterangan,
    this.updatedAt,
    this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        tanggal: json["tanggal"],
        sumberBatok: json["sumber_batok"],
        barangMasuk: double.parse(json["barang_masuk"].toString()),
        barangKeluar: double.parse(json["barang_keluar"].toString()),
        stokAwal: double.parse(json["stok_awal"].toString()),
        stokAkhir: double.parse(json["stok_akhir"].toString()),
        keterangan: json["keterangan"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tanggal": tanggal,
        "sumber_batok": sumberBatok,
        "barang_masuk": barangMasuk,
        "barang_keluar": barangKeluar,
        "stok_awal": stokAwal,
        "stok_akhir": stokAkhir,
        "keterangan": keterangan,
        "updated_at": updatedAt,
        "created_at": createdAt,
      };
}

class BatokDeleteResponseModel {
  String? message;

  BatokDeleteResponseModel({
    this.message,
  });

  factory BatokDeleteResponseModel.fromJson(Map<String, dynamic> json) => BatokDeleteResponseModel(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
