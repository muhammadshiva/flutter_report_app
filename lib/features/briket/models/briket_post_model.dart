class BriketPostResponseModel {
  int? status;
  String? message;
  Data? data;

  BriketPostResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory BriketPostResponseModel.fromJson(Map<String, dynamic> json) =>
      BriketPostResponseModel(
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
  String? jenisMasukan;
  DateTime? tanggal;
  String? sumberBatok;
  double? stok;
  String? keterangan;

  Data({
    this.id,
    this.jenisMasukan,
    this.tanggal,
    this.sumberBatok,
    this.stok,
    this.keterangan,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        jenisMasukan: json["jenis_masukan"],
        tanggal:
            json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        sumberBatok: json["sumber_batok"],
        stok: json["stok"] != null
            ? double.tryParse(json["stok"].toString())
            : null,
        keterangan: json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jenis_masukan": jenisMasukan,
        "tanggal":
            "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        "sumber_batok": sumberBatok,
        "stok": stok,
        "keterangan": keterangan,
      };
}
