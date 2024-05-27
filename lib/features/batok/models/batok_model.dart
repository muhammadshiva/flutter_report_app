class BatokResponseModel {
  int? status;
  String? message;
  List<BatokData>? data;

  BatokResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory BatokResponseModel.fromJson(Map<String, dynamic> json) => BatokResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<BatokData>.from(json["data"]!.map((x) => BatokData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BatokData {
  String? sumberBatok;
  double? persentaseBarang;
  double? persentaseStok;
  String? tanggal;
  List<ListBatok>? listBatok;

  BatokData({
    this.sumberBatok,
    this.persentaseBarang,
    this.persentaseStok,
    this.tanggal,
    this.listBatok,
  });

  factory BatokData.fromJson(Map<String, dynamic> json) => BatokData(
        sumberBatok: json["sumber_batok"],
        persentaseBarang: json["persentase_barang"] is int
            ? (json["persentase_barang"] as int).toDouble()
            : json["persentase_barang"],
        persentaseStok: json["persentase_stok"] is int
            ? (json["persentase_stok"] as int).toDouble()
            : json["persentase_stok"],
        tanggal: json["tanggal"],
        listBatok: json["list_batok"] == null
            ? []
            : List<ListBatok>.from(json["list_batok"]!.map((x) => ListBatok.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sumber_batok": sumberBatok,
        "persentase_barang": persentaseBarang,
        "persentase_stok": persentaseStok,
        "tanggal": tanggal,
        "list_batok":
            listBatok == null ? [] : List<dynamic>.from(listBatok!.map((x) => x.toJson())),
      };
}

class ListBatok {
  int? id;
  String? tanggal;
  String? sumberBatok;
  int? barangMasuk;
  int? barangKeluar;
  int? stokAwal;
  int? stokAkhir;
  String? keterangan;
  String? createdAt;
  String? updatedAt;

  ListBatok({
    this.id,
    this.tanggal,
    this.sumberBatok,
    this.barangMasuk,
    this.barangKeluar,
    this.stokAwal,
    this.stokAkhir,
    this.keterangan,
    this.createdAt,
    this.updatedAt,
  });

  factory ListBatok.fromJson(Map<String, dynamic> json) => ListBatok(
        id: json["id"],
        tanggal: json["tanggal"],
        sumberBatok: json["sumber_batok"],
        barangMasuk: json["barang_masuk"],
        barangKeluar: json["barang_keluar"],
        stokAwal: json["stok_awal"],
        stokAkhir: json["stok_akhir"],
        keterangan: json["keterangan"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
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
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
