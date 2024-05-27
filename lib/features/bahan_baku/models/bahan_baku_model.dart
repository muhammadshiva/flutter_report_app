class BahanBakuResponseModel {
  int? status;
  String? message;
  List<BahanBakuData>? data;

  BahanBakuResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory BahanBakuResponseModel.fromJson(Map<String, dynamic> json) => BahanBakuResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<BahanBakuData>.from(json["data"]!.map((x) => BahanBakuData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BahanBakuData {
  String? sumberBatok;
  double? persentaseBahanBaku;
  String? tanggal;
  List<ListBahanBaku>? listBahanBaku;

  BahanBakuData({
    this.sumberBatok,
    this.persentaseBahanBaku,
    this.tanggal,
    this.listBahanBaku,
  });

  factory BahanBakuData.fromJson(Map<String, dynamic> json) => BahanBakuData(
        sumberBatok: json["sumber_batok"],
        persentaseBahanBaku: json["persentase_bahan_baku"]?.toDouble(),
        tanggal: json['tanggal'],
        listBahanBaku: json["list_bahan_baku"] == null
            ? []
            : List<ListBahanBaku>.from(
                json["list_bahan_baku"]!.map((x) => ListBahanBaku.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sumber_batok": sumberBatok,
        "persentase_bahan_baku": persentaseBahanBaku,
        "tanggal": tanggal,
        "list_bahan_baku":
            listBahanBaku == null ? [] : List<dynamic>.from(listBahanBaku!.map((x) => x.toJson())),
      };
}

class ListBahanBaku {
  int? id;
  String? tanggal;
  String? sumberBatok;
  String? bahanBaku;
  double? jumlahMasuk;
  double? jumlahKeluar;
  String? keterangan;
  String? createdAt;
  String? updatedAt;

  ListBahanBaku({
    this.id,
    this.tanggal,
    this.sumberBatok,
    this.bahanBaku,
    this.jumlahMasuk,
    this.jumlahKeluar,
    this.keterangan,
    this.createdAt,
    this.updatedAt,
  });

  factory ListBahanBaku.fromJson(Map<String, dynamic> json) => ListBahanBaku(
        id: json["id"],
        tanggal: json["tanggal"],
        sumberBatok: json["sumber_batok"],
        bahanBaku: json["bahan_baku"],
        jumlahMasuk: json["jumlah_masuk"] is int
            ? (json["jumlah_masuk"] as int).toDouble()
            : json["jumlah_masuk"],
        jumlahKeluar: json["jumlah_keluar"] is int
            ? (json["jumlah_keluar"] as int).toDouble()
            : json["jumlah_keluar"],
        keterangan: json["keterangan"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tanggal": tanggal,
        "sumber_batok": sumberBatok,
        "bahan_baku": bahanBaku,
        "jumlah_masuk": jumlahMasuk,
        "jumlah_keluar": jumlahKeluar,
        "keterangan": keterangan,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class DeleteBahanBakuResponseModel {
  String? message;

  DeleteBahanBakuResponseModel({
    this.message,
  });

  factory DeleteBahanBakuResponseModel.fromJson(Map<String, dynamic> json) =>
      DeleteBahanBakuResponseModel(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
