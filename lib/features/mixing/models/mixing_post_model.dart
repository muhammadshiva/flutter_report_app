class MixingPostResponseModel {
  int? status;
  String? message;
  Data? data;

  MixingPostResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory MixingPostResponseModel.fromJson(Map<String, dynamic> json) =>
      MixingPostResponseModel(
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
  DateTime? tanggal;
  String? sumberBatok;
  double? ukuranPisau;
  double? jumlahArang;
  double? jumlahAci;
  double? jumlahCairan;
  String? keterangan;

  Data({
    this.id,
    this.tanggal,
    this.sumberBatok,
    this.ukuranPisau,
    this.jumlahArang,
    this.jumlahAci,
    this.jumlahCairan,
    this.keterangan,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        tanggal:
            json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        sumberBatok: json["sumber_batok"],
        ukuranPisau: json["ukuran_pisau"] != null
            ? double.tryParse(json["ukuran_pisau"].toString())
            : null,
        jumlahArang: json["jumlah_arang"] != null
            ? double.tryParse(json["jumlah_arang"].toString())
            : null,
        jumlahAci: json["jumlah_aci"] != null
            ? double.tryParse(json["jumlah_aci"].toString())
            : null,
        jumlahCairan: json["jumlah_cairan"] != null
            ? double.tryParse(json["jumlah_cairan"].toString())
            : null,
        keterangan: json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tanggal":
            "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        "sumber_batok": sumberBatok,
        "ukuran_pisau": ukuranPisau,
        "jumlah_arang": jumlahArang,
        "jumlah_aci": jumlahAci,
        "jumlah_cairan": jumlahCairan,
        "keterangan": keterangan,
      };
}
